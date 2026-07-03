{
  config,
  pkgs,
  ...
}: let
  USERNAME = "hactuss";
  GTK_ICONS_NAME = "yet-another-monochrome-icon-set";
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = USERNAME;
  home.homeDirectory = "/home/hactuss";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello
    pkgs.zed-editor
    pkgs.rofi-power-menu
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "vivaldi";
    TERMINAL = "alacritty";
  };

  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;
      settings = {
        user = {
          name = "Hactus";
          email = "hactuss@proton.me";
        };
        alias = {
          ci = "commit";
          co = "checkout";
          s = "status";
        };
        init.defaultBranch = "main";
      };
      lfs.enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        gc = "git commit -a ";
        ff = "fastfetch";
        cdn = "cd /home/hactuss/dotfiles";
        l-rebuild = "sudo nixos-rebuild switch --flake /home/hactuss/dotfiles && cd /home/hactuss/dotfiles && sudo git add . && sudo git commit && cd -";
        # rebuild-sh = "sh /etc/nixos/scripts/rebuild-haj.sh";
        shut = "shutdown -P now";
        rebuild-flake = "sudo nixos-rebuild switch --flake /home/hactuss/dotfiles";
      };
    };

    neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
    };

    rofi = {
      theme = "DarkBlue";
      plugins = with pkgs; [
        rofi-calc
        rofi-power-menu
      ];
      extraConfig = {
        modes = "window,drun,run,ssh,combi,calc,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu";
      };
    };

    fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = "nixos_small";
          padding = {
            right = 1;
          };
        };
        display = {
          size = {
            binaryPrefix = "si";
          };
          color = "blue";
          separator = "  ";
        };
        modules = [
          {
            type = "datetime";
            key = "Date";
            format = "{1}-{3}-{11}";
          }
          {
            type = "datetime";
            key = "Time";
            format = "{14}:{17}:{20}";
          }
          "break"
          "player"
          "media"
        ];
      };
    };
  };
  /*
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
  */

  # services.picom.enable = true;
  # https://mynixos.com/home-manager/options/xsession.windowManager.i3.config
  # these set options for i3 dont work, only the imported config files from source
  #xsession.windowManager.i3.enable = true;
  /*
   xsession.windowManager.i3.config.menu = "rofi";
  xsession.windowManager.i3.config = {
    startup = [
      {
        command = "feh --bg-fill /etc/nixos/assets/vapor.png";
        always = true;
      }
    ];
    terminal = "alacritty";
    gaps.smartBorders = "on";
    colors.focused = {
      background = "#800080";
      border = "#fcf802";
      childBorder = "#285577";
      indicator = "#2e9ef4";
      text = "#555555";
    };
  };
  */
  services.flameshot.settings = {
    General = {
      showStartupLaunchMessage = false;
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # .zshrc ist nicht möglich
    #".zshrc".text = ''feh --bg-fill /home/hactuss/Desktop/vapor.png'';
    #".zshrc".force = true;

    #     "/home/hactuss/.config/i3/config".source = ./homefiles/i3/config.txt;
    #    "/home/hactuss/.config/i3/config".force = true;
    #"/home/hactuss/.config/i3status/config".source = ./homefiles/i3status/config.txt;
    #"/home/hactuss/.config/i3status/config".force = true;
    # fastfetch conflict
    #"/home/hactuss/.config/fastfetch/config.jsonc".source = ./homefiles/fastfetch/config.txt;
    #"/home/hactuss/.config/fastfetch/config.jsonc".force = true;
    #"/home/hactuss/.gtkrc-2.0".source = ./homefiles/gtk/2-0.txt;
    #"/home/hactuss/.gtkrc-2.0".force = true;
    "~/.bashrc".source = /home/hactuss/.bashrc;
  };
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hactuss/etc/profile.d/hm-session-vars.sh
  #

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
