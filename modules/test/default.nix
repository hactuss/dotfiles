{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ cbonsai ];
}
