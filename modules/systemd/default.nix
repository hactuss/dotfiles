{...}:{
systemd.hactuss.services.dofiles-pull = {
  enable = true;
  after = [ "network.target" ];
  wantedBy = [ "default.target" ];
  description = "Runs git pull on boot";
  serviceConfig = {
      Type = "simple";
      ExecStart = ''/home/hactuss/dotfiles/configfiles/boot.sh'';
  };
};
}
