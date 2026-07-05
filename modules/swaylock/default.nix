{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    swaylock-effects
    swaylock-fancy
    swaylock-plugin
    swaylock
  ];
}
