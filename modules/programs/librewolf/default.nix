{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.librewolf-unwrapped
  ];
}
