{ my-variables, ... }: {
  programs.nh = {
    enable = true;
    flake = "/home/${my-variables.username}/dotfiles";
  };
}
