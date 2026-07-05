{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    synthv1
  ];
}
