# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];
  #  prism-mod.enable = true;
  # Bootloader.
  boot.loader = {
    limine.enable = true;
    efi.canTouchEfiVariables = true;
    limine.style.wallpaperStyle = "centered";
  };
  boot.consoleLogLevel = 0;
  #boot.plymouth.enable = true;
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "quiet"
    "splash"
    "rd.systemd.show_status=false"
  ];

  networking.hostName = "emerald"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  security.polkit.enable = true;
  networking.networkmanager.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      mesa.opencl # Enables Rusticl (OpenCL) support
    ];
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true; # <--- This enables the GUI tool
    package = config.boot.kernelPackages.nvidiaPackages.stable; # or beta/production
  };
  # Select internationalisation properties.
  i18n = {
    /*
    defaultLocale = "de_DE.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
    */
    defaultLocale = "de_DE.UTF-8";
    extraLocaleSettings = {
      LC_ALL = "de_DE.UTF-8";
    };
  };
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  # Enable the KDE Plasma Desktop Environment.
  programs = {
    niri.enable = true;
    #sway.enable = true;
    #hyprland.enable = true;
    #waybar.enable = true;
  };
  #services.desktopManager.plasma6.enable = true;
  programs.xwayland = {
    enable = true;
    package = pkgs.xwayland-satellite;
  };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
  # Configure console keymap
  console.keyMap = "de";
  services.printing.enable = true;
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hactuss = {
    isNormalUser = true;
    description = "hactuss";
    extraGroups = [
      "networkmanager"
      "wheel"
      "syncthing"
    ];
    packages = with pkgs; [
    ];
  };
  environment.sessionVariables = {
    NH_FLAKE = /home/hactuss/dotfiles;
    NH_OS_FLAKE = /home/hactuss/dotfiles;
    NH_HOME_FLAKE = /home/hactuss/dotfiles;
    NIXOS_OZONE_WL = "1";
    RUSTICL_ENABLE = "radeonsi";
    RUST_BACKTRACE = 1;
  };
  #environment.extraInit = "pushd /home/hactuss/dotfiles; git pull --ff-only; popd;";
  hardware.bluetooth.enable = true;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    alacritty
    flameshot
    librewolf
    zed-editor
    nixfmt
    seahorse
    nh
    ghostty
    pavucontrol
    xeyes
    waypaper
    feh
    fuzzel
    fastfetch
    onefetch
    screenfetch
    git
    ffmpeg
    nix-ld
    nixd
    btop
    cmatrix
    discord
    tmux
    tor-browser
    prismlauncher
    alejandra
    mpv
    # davinci-resolve
    #xmrig
    r2modman
    unrar
    hollywood
    xwayland-satellite
    # niri wallpaper
    swaybg
    swaylock
    awww
    imagemagick
    waybar
    tree
    swaylock-plugin
    swaylock-fancy
    swaylock-effects
    # #################
    pywal16
    cwal
    hellwal
    wallust
    libdisplay-info
    cbonsai
    unzip
    coreutils-full
    cowsay
    /*
        (inputs.wrappers.lib.wrapPackage {
          inherit pkgs;
          package = pkgs.niri;
          flags = {
            "--config" = config;
          };
    })
    */

    (inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.curl;
      runtimeInputs = [pkgs.jq];
      env = {
        CURL_CA_BUNDLE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      };
      flags = {
        "--silent" = true;
        "--connect-timeout" = "30";
      };
      # Or use args directly for more control:
      # args = [ "--silent" "--connect-timeout" "30" ];
      flagSeparator = "="; # Use --flag=value instead of --flag value (default is " ")
      preHook = ''
        echo "Making request..." >&2
      '';
    })
  ];
  #services.asusd

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  /*
  services.xmrig = {
    enable = true;
    settings = {
      autosave = true;
      cpu = true;
      opencl = true;
      cuda = false;
      pools = [
        {
          url = "pool.supportxmr.com:3333";
          user = "44kBjERLZSR5syNjVyqxthMuZqZ79tPah8GcxsQxoaNP3T1g5qwGLUUGVcmT3o2y6FcBUEhsMesPxCzqR9ueYibBRfpMLeu";
          keepalive = true;
          tls = true;
        }
      ];
      donate-level = 0;
      donate-over-proxy = 0;
    };
  };
  */
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "hactuss" = import ./home.nix;
    };
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
