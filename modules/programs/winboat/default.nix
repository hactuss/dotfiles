{
  pkgs,
  my-variables,
  ...
}: {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };
  environment.systemPackages = [
    pkgs.winboat
  ];
  users.users.${my-variables.username}.extraGroups = ["docker"];
  hardware.nvidia-container-toolkit.enable = true;
}
