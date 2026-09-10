{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      libsForQt5.qt5ct
      kdePackages.qt6ct
      adwaita-qt
      kdePackages.breeze
    ];
    sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";
    };
    etc = {
      "xdg/qt5ct/qt5ct.conf".text = ''
        [Appearance]
        style=BreezeDark
      '';
      "xdg/qt6ct/qt6ct.conf".text = ''
        [Appearance]
        style=BreezeDark
      '';
    };
  };
}
