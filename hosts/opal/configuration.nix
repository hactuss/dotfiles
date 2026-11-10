# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  inputs,
  my-variables,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # /etc/nixos/hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  boot = {
    loader.efi.efiSysMountPoint = "/boot";
    loader.efi.canTouchEfiVariables = true;
    loader.limine.enable = true;
  };

  networking = {
    hostName = my-variables.thinkpadName; # Define your hostname.
    wireless.enable = true; # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # Enable networking
    networkmanager.enable = true;
    firewall.allowPing = true;
    # Open ports in the firewall.
    firewall = {
      enable = true;
      allowedTCPPorts = [
        139
        445
        4533
      ];
      allowedUDPPorts = [
        137
        138
        4533
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
  # system.stateVersion = "25.05";

  hardware = {
    trackpoint.enable = true;
    enableAllHardware = true;
    bluetooth.enable = true;
  };

  # hardware.steam-hardware.enable = true;
  # hardware.graphics.enable = true;
  # Set your time zone.
  time.timeZone = my-variables.timezone;
  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.

  # Enable the KDE Plasma Desktop Environment.
  /*
  services.desktopManager = {
    plasma6.enable = true;
  };
  */
  # displayManager.sddm.wayland.enable = true;

  /*
  Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb = {
      layout = "de";
      variant = "deadacute";
    };
  };
  */
  #services.desktopManager.gnome.enable = true;
  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${my-variables.username}" = {
    shell = pkgs.bash;
    isNormalUser = true;
    description = "${my-variables.username}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "users"
      "samba"
    ];
  };
  environment.sessionVariables = {
    NH_FLAKE = "/home/${my-variables.username}/dotfiles";
    NIXOS_OZONE_WL = "1";
    DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";
    LANG = "de_DE.UTF-8";
  };
  environment.systemPackages = with pkgs; [
    librewolf
    # papirus-nord
    # autotiling-rs
    # deadnix
    # spotify-cli-linux
    #lix

    puddletag
    # dzen2
    # libnotify
    xwayland-satellite
    # onefetch
    fuzzel
    swaybg

    powerstat
    flameshot
    # pscircle
    blueman
    unrar
    # exif
    # speedtest
    #nixfmt
    #nixfmt-tree
    # nh
    #exiftool
    #foremost
    # GUI apps
    #alacritty
    ghostty
    #waybar
    #vivaldi
    # discord
    #spotify
    # libreoffice
    # obs-studio
    #krita
    #vlc
    zed-editor
    obsidian
    #giada
    #firefox
    feh
    mpv
    cmake
    # nnn
    # zlib
    openssl
    #filemanagers choice
    #nautilus
    #nemo
    #polybarFull
    #lemonbar
    #eww
    #pavucontrol
    # cli
    # pcmanfm
    #pcmanfm-qt
    #metasploit
    #nmap
    #netcat
    #gnome-tweaks
    ripgrep
    #neovim
    fastfetch
    btop
    # wget
    ly
    yt-dlp
    ((pkgs.ffmpeg-full.override {withUnfree = true;}).overrideAttrs (_: {
      doCheck = false;
    }))
    curl
    #tmux
    #pnpm
    alejandra
    #metadata
    #tree
    #wine
    #networkmanager
    #presenterm
    #udev
    #gparted
    #fun stuff
    #cmatrix
    #cowsay
    #cava
    #fortune
    #peaclock
    #tetris
    #cbonsai
    #figlet
    #sl
    #hollywood
    #other
    hardinfo2
    lsd

    # dependencies
    # gui apps
    # terminal
    # utility
    # brightnessctl
    #alsa-utils
    # misc

    #grim # screenshot functionality
    #slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    # mako # notification system developed by swaywm maintainer
    # waypaper
    dysk
    #mdr
  ];

  ##################### Laptop  power settings

  # List packages installed in system profile. To search, run:
  services.logind.settings.Login = {
    HandleLidSwitch = "lock";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "ignore";
  };
  # one of "ignore", "poweroff", "reboot", "halt", "kexec", "suspend", "hibernate", "hybrid-sleep", "suspend-then-hibernate", "lock"  home-manager = {
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      # Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    };
  };
  services.thermald.enable = true;
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GiB
    }
  ];
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit my-variables;
    };
    users = {
      "${my-variables.username}" = import ./home.nix;
    };
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
}
