{pkgs, ...}: {
  environment.systemPackages = [pkgs.davinci-resolve];
  environment.variables = {
    RUSTCL_ENABLE = "radeonsi";
  };
}
