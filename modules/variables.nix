let
system = "x86_64-linux";
pkgs = nixpkgs.legacyPackages.${system};
username = "hactuss";
desktopName = "emerald";
thinkpadName = "opal";
modulesPath = ./modules;
hostsPath = ./hosts;
configfilesPath = ./configfilesPath;
desktopPath = hostsPath + "/${desktopName}";
thinkpadPath = hostsPath + "/${thinkpadName}";
my-variables = rec {
  inherit
    username
    desktopName
    thinkpadName
    modulesPath
    hostsPath
    configfilesPath
    desktopPath
    thinkpadPath
    ;
};
homedir = /home/${username};
configPath = /${homedir}/dotfiles;
timezone = "Europe/Berlin";
in {

}
