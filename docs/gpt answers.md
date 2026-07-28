# 1
That error happens because **Nix flakes evaluate in pure mode by default**, and your configuration is referencing an absolute path like:

```nix
/home/username/dotfiles
```

Pure evaluation deliberately forbids reading arbitrary files outside the flake, so `--impure` disables that restriction.

The proper fix is **not** to permanently disable purity, but to restructure your configuration so the path is inside the flake.

### Option 1 (recommended): Make your dotfiles part of the flake

If your flake is in:

```
~/dotfiles/
├── flake.nix
├── hosts/
├── home/
└── ...
```

instead of

```nix
imports = [
  /home/username/dotfiles/home/default.nix
];
```

use

```nix
imports = [
  ./home/default.nix
];
```

or

```nix
imports = [
  ../home/default.nix
];
```

or pass paths relative to `self`:

```nix
inputs.self + "/home/default.nix"
```

Everything inside the flake is automatically accessible in pure mode.

---

### Option 2: Add the directory as a flake input

If the directory is separate from the flake:

```nix
inputs.dotfiles.url = "path:../dotfiles";
```

Then use

```nix
inputs.dotfiles
```

instead of `/home/...`.

---

### Option 3: If you really want impure evaluation by default

`nh` forwards arguments to Nix, but there isn't a Nix setting that permanently whitelists arbitrary absolute paths for pure evaluation. Your options are essentially:

- always pass `--impure`
    
- create an alias:
    

```bash
alias nh='nh --impure'
```

or

```bash
alias nhos='nh os switch --impure'
```

or configure your shell similarly.

---

### There is no "allow this directory" option

Nix's purity model is intentionally all-or-nothing during evaluation. You cannot whitelist:

```
/home/username/dotfiles
```

while keeping everything else pure. The only mechanisms are:

- files inside the flake
    
- declared flake inputs (`path:` inputs count)
    
- `--impure`
    

---

If you can show your `flake.nix` (especially where `/home/username/dotfiles` is referenced), I can point out the exact line that should be changed so `nh os switch` works without `--impure`.

# 2
Your `flake.nix` itself looks fine. I don't see any absolute paths like `/home/hactuss/dotfiles` in what you posted.

The error:

```
error: access to absolute path '/home/username/dotfiles' is forbidden in pure evaluation mode
```

means **something else** in your configuration is referencing that path. Common places are:

- `builtins.readFile /home/...`
    
- `import /home/...`
    
- `imports = [ /home/... ]`
    
- `builtins.path "/home/..."`
    
- `source = /home/...`
    
- `environment.etc.<name>.source = /home/...`
    
- Home Manager options like:
    
    ```nix
    home.file.".config/foo".source = /home/hactuss/dotfiles/foo;
    ```
    
- A module under `modules/` or `hosts/`.
    

## Find it

From the root of your flake, run:

```bash
rg '/home/hactuss'
```

or

```bash
grep -R "/home/hactuss" .
```

Also search for the generic form:

```bash
rg '"/home'
rg '/home/'
```

There should be at least one hit.

## If your flake lives in `~/dotfiles`

Suppose your repository is:

```
~/dotfiles
├── flake.nix
├── modules
└── hosts
```

Then this is **wrong**:

```nix
source = /home/hactuss/dotfiles/foo/bar;
```

and should become

```nix
source = ./foo/bar;
```

or

```nix
source = ../foo/bar;
```

or

```nix
source = self + "/foo/bar";
```

depending on where the file is located.

## If `nh` is pointing at the wrong flake

Another possibility is that you're running something like:

```bash
nh os switch /home/hactuss/dotfiles
```

or your `nh` configuration contains

```
path = /home/hactuss/dotfiles
```

That absolute path is also considered impure. Normally, `nh` should be using a flake reference such as:

```bash
nh os switch .
```

or

```bash
nh os switch ~/dotfiles
```

where `~/dotfiles` is the actual flake directory, not a path that's being evaluated inside the Nix expression.

---

Could you also show:

1. the exact command you run (`nh os switch ...`)
    
2. the full error output (especially the lines after the first error, which usually include a stack trace)
    
3. the output of:
    

```bash
rg '/home/hactuss' .
```

One of those should pinpoint the offending line.

# 3 
In a Nix flake, the common way to create "global variables" that every module or file can use is to define them once in `outputs` and pass them to your modules through `specialArgs` (for NixOS) or `extraSpecialArgs` (for Home Manager).

### Example project

```
.
├── flake.nix
├── vars.nix
├── hosts
│   └── laptop.nix
└── modules
    └── example.nix
```

### `vars.nix`

```nix
{
  username = "alice";
  hostname = "laptop";
  timezone = "Europe/Berlin";

  packages = [
    "git"
    "vim"
    "curl"
  ];
}
```

### `flake.nix`

```nix
{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";

    vars = import ./vars.nix;
  in {
    nixosConfigurations.${vars.hostname} =
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs vars;
        };

        modules = [
          ./hosts/laptop.nix
        ];
      };
  };
}
```

### `hosts/laptop.nix`

```nix
{ config, pkgs, vars, ... }:

{
  networking.hostName = vars.hostname;
  time.timeZone = vars.timezone;

  imports = [
    ../modules/example.nix
  ];
}
```

### `modules/example.nix`

```nix
{ pkgs, vars, ... }:

{
  users.users.${vars.username} = {
    isNormalUser = true;

    packages = with pkgs; [
      git
      vim
      curl
    ];
  };
}
```

---

## Passing individual variables

Instead of a `vars` attribute set, you can pass everything directly:

```nix
let
  username = "alice";
  hostname = "laptop";
in
{
  specialArgs = {
    inherit username hostname;
  };
}
```

Then modules receive:

```nix
{ username, hostname, ... }:

{
  networking.hostName = hostname;
}
```

---

## If using Home Manager

Pass them with `extraSpecialArgs`:

```nix
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  extraSpecialArgs = {
    inherit vars;
  };

  modules = [
    ./home.nix
  ];
}
```

Then in `home.nix`:

```nix
{ vars, ... }:

{
  home.username = vars.username;
}
```

---

### Best practice

Keep all shared configuration in a single attribute set:

```nix
# vars.nix
{
  user = {
    name = "alice";
    email = "alice@example.com";
  };

  system = {
    hostname = "laptop";
    timezone = "Europe/Berlin";
  };

  paths = {
    dotfiles = "/home/alice/dotfiles";
  };
}
```

Then access it everywhere as:

```nix
vars.user.name
vars.user.email
vars.system.hostname
vars.system.timezone
vars.paths.dotfiles
```

This approach scales well and is the idiomatic way to share configuration across all NixOS and Home Manager modules in a flake.
