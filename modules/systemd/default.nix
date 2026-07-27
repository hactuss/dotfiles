{...}:{
systemd.user.services.dofiles-pull = {
  enable = true;
  after = [ "network.target" ];
  wantedBy = [ "multi-user.target" ];
  description = "Runs git pull on boot";
  serviceConfig = {
      Type = "simple";
      ExecStart = ''/home/hactuss/dotfiles/configfiles/boot.sh'';
  };
};
}
