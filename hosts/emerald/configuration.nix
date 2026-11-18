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
    inputs.home-manager.nixosModules.default
  ];
  #  prism-mod.enable = true;
  # Bootloader.
  boot = {
    loader = {
      limine.enable = true;
      efi.canTouchEfiVariables = true;
      limine.style.wallpaperStyle = "centered";
    };
    kernelPackages = pkgs.linuxPackages_6_18;
    kernelParams = [
      #    "quiet"
      "splash"
      #    "rd.systemd.show_status=false"
    ];
  };

  networking.hostName = my-variables.desktopName; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  security.polkit.enable = true;
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = my-variables.timezone;
  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        mesa.opencl # Enables Rusticl (OpenCL) support
      ];
    };
    nvidia = {
      open = true;
      modesetting.enable = true;
      nvidiaSettings = true; # <--- This enables the GUI tool
      # package = config.boot.kernelPackages.nvidiaPackages.stable; # or beta/production
      nvidiaPersistenced = true;
      /*
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = "PCI:0:0:0";
          nvidiaBusId = "PCI:6:0:0";
      };
      */
    };
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

  # Enable the KDE Plasma Desktop Environment.

  #services.desktopManager.plasma6.enable = true;
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

  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024; # 8GB
    }
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${my-variables.username} = {
    isNormalUser = true;
    description = "${my-variables.username}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "syncthing"
      "samba"
    ];
  };
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
  };
  environment.systemPackages = with pkgs; [
    _7zz
    _7zz-rar
    ((pkgs.ffmpeg-full.override {withUnfree = true;}).overrideAttrs (_: {doCheck = false;}))
    #awww
    #cbonsai
    #cmatrix
    #coreutils-full
    #cowsay
    #cwal
    #discord
    #freerdp
    #hellwal
    #hollywood
    #imagemagick
    #niri wallpaper
    #nixfmt
    #pavucontrol
    #pywal16
    #regex-cli
    #regex-tui
    #seahorse
    #synthv1
    #termusic
    #thunar
    #tor-browser
    #wallust
    #waybar
    #waypaper
    #xeyes
    #xmrig
    alacritty
    alejandra
    btop
    cbonsai
    cmatrix
    cowsay
    cudaPackages.cudatoolkit
    cudatoolkit
    davinci-resolve
    ddrescue
    dysk
    fastfetch
    fastfetch
    feh
    flameshot
    fuzzel
    fzf
    ghostty
    git
    hollywood
    libdisplay-info
    librewolf
    lsd
    mpv
    nh
    nnn
    nvd
    onefetch
    openssl
    pciutils
    pcmanfm
    prismlauncher
    pstree
    r2modman
    ripgrep
    screenfetch
    screenfetch
    stow
    swaybg
    swaylock
    swaylock-effects
    swaylock-fancy
    swaylock-plugin
    tree
    unrar
    unzip
    xmrig
    xwayland-satellite
    xxd
    zed-editor
    zlib
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
