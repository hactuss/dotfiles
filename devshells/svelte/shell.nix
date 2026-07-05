{
  pkgs ? import <nixpkgs> { },
}:
let
  DEVSHELL_NAME = "svelte";
in
pkgs.mkShell {
  packages = [ pkgs.pnpm ];

  # inputsFrom = [ pkgs.bat ];

  shellHook = ''
    echo "welcome to the shell!"
  '';

  PS1 = "${DEVSHELL_NAME}@\h>";
}
