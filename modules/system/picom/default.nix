{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    picom
    picom-next
    picom-pijulius
    picocom
  ];
}
