{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      font-awesome
      nerd-fonts.lilex
      proggyfonts
      terminus_font
      terminus_font_ttf
      lilex
      noto-fonts
      noto-fonts-cjk-sans

      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      # nerdfonts
    ];
    enableGhostscriptFonts = true;
    enableDefaultPackages = true;
    # console.font = "ter-v16n";
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["Fira Code"];
      };
    };
  };
}
