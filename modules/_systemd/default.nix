{...}: {
  systemd.user.services.dotfiles-pull = {
    enable = true;
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    name = "dofiles-pull";
    description = "Runs git pull on boot";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''pushd /home/hactuss/dotfiles; git pull --ff-only; popd'';
    };
  };
}
