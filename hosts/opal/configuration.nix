# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  #boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.splashImage = "/etc/nixos/assets/Jotaro_Thinkpad_2.png";
  boot.loader.grub.backgroundColor = "#000000";

  boot.loader.limine.enable = true;
  networking.hostName = "opal"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  #desktopManager.enable = true;
  # Open ports in the firewall.
  networking.firewall = {
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
  # system.stateVersion = "25.05";

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "-L"
    ];
    dates = "04:00";
    randomizedDelaySec = "60min";
  };
  networking.firewall.allowPing = true;

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nix.settings.auto-optimise-store = true;
  hardware.trackpoint.enable = true;
  hardware.enableAllHardware = true;
  hardware.steam-hardware.enable = true;
  hardware.graphics.enable = true;
  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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

  hardware.bluetooth.enable = true;
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.

  # Enable the KDE Plasma Desktop Environment.
  /*
    services.desktopManager = {
      plasma6.enable = true;
    };
  */
  # displayManager.sddm.wayland.enable = true;
  services.displayManager.ly = {
    enable = true;
    # https://github.com/fairyglade/ly/blob/master/res/config.ini
    settings = {
      animation = "matrix";
      battery_id = "BAT0";
      bigclock = "en";
      show_tty = true;
      lang = "de";
    };
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb = {
      layout = "de";
      variant = "deadacute";
    };
  };
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
  # hardware.alsa.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hactuss = {
    shell = pkgs.bash;
    isNormalUser = true;
    description = "hactuss";
    extraGroups = [
      "networkmanager"
      "wheel"
      "users"
      "docker"
    ];
    packages = with pkgs; [ ];
  };

  #services.tlp.enable = true;
  services.thermald.enable = true;
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "poweroff";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "ignore";
  };
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
      TLP_DEFAULT_MODE = "BAT";
      TLP_PERSISTENT_DEFAULT = 1;
    };
  };
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

  # one of "ignore", "poweroff", "reboot", "halt", "kexec", "suspend", "hibernate", "hybrid-sleep", "suspend-then-hibernate", "lock"

  programs.zsh.enable = true;
  #programs.zsh.shellInit = "echo Kernel by Linus Torvalds | cowsay -f tux";
  # services.tor.enable = true;
  # services.h2o.enable = true;
  programs.zsh.autosuggestions.enable = true;
  # programs.niri.enable = true;
  programs.sway.enable = true;
  virtualisation.docker = {
    enable = true;
  };
  environment.sessionVariables = {
    NH_FLAKE = "/home/hactuss/dotfiles";
    NIXOS_OZONE_WL = "1";
    DEFAULT_BROWSER = "librewolf";
    DEFAULT_EDITOR = "neovim";
    EDITOR = "neovim";
  };
  environment.loginShellInit = "pushd /home/hactuss/dotfiles; git pull; popd; exit;";
  environment.systemPackages = with pkgs; [
    brave
    librewolf
    pulseaudio
    papirus-nord
    autotiling-rs
    deadnix
    spotify-cli-linux
    #lix
    puddletag
    dzen2
    libnotify
    xwayland-satellite
    onefetch
    fuzzel
    swaybg

    powerstat
    flameshot
    pscircle
    blueman
    unrar
    speedtest
    exif
    nixfmt
    nixfmt-tree
    nh
    exiftool
    foremost
    # GUI apps
    #alacritty
    ghostty
    waybar
    #brave
    #vivaldi
    discord
    #spotify
    libreoffice
    obs-studio
    #krita
    vlc
    zed-editor
    obsidian
    #giada
    #firefox
    feh
    mpv
    cmake
    #filemanagers choice
    #nautilus
    #nemo
    #polybarFull
    #lemonbar
    eww
    pavucontrol
    # cli
    gnupg
    metasploit
    nmap
    netcat
    gnome-tweaks
    #neovim
    fastfetch
    btop
    wget
    ly
    yt-dlp
    ffmpeg
    curl
    tmux
    pnpm
    alejandra
    metadata
    tree
    wine
    networkmanager
    presenterm
    udev
    gnupg
    gparted
    #fun stuff
    cmatrix
    cowsay
    cava
    fortune
    peaclock
    tetris
    cbonsai
    figlet
    sl
    hollywood
    #other
    hardinfo2

    # dependencies
    # gui apps
    # terminal
    # utility
    brightnessctl
    alsa-utils
    # misc

    #grim # screenshot functionality
    #slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    waypaper
  ];

  # environment.

  programs.nix-ld.enable = true;

  /*
    services.xmrig = {
      enable = true;
    };
  */

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans

      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
    ];

    enableGhostscriptFonts = true;
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      /*
        defaultFonts = {
          monospace = "Jetbrains-mono";
        };
      */
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "hactuss" = import ./home.nix;
    };
  };

  console = {
    font = "jetbrains-mono";
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [
      5432
      22
    ];
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "hactuss" ];
    };
  };
  programs.ssh.askPassword = "askPassword";
}
