{my-variables, ...}: {
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [
      5432
      22
    ];
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = ["${my-variables.username}"];
    };
  };
}
