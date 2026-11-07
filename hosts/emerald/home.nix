{
  pkgs,
  my-variables,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${my-variables.username}";
  home.homeDirectory = "/home/${my-variables.username}";
  /*
   gtk doe not work
  gtk = {
    enable = true;
    gtk4 = {
      enable = true;
      theme = {
        package = pkgs.gruvbox-dark-gtk;
        name = "gruvbox dark";
      };
    };
  };
  */
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
  ];
  programs.swaylock = {
    package = pkgs.swaylock;
    /*
    settings = {
      color = "808080";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
      };
    */
  };
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  xdg.configFile."swaylock/config".source = ./../../configfiles/swaylock/frappe;
  home.file = {
  };
}
