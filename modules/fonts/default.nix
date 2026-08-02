{pkgs, ...}: {
  fonts.packages = with pkgs; [
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

    # nerdfonts
  ];
  # console.font = "ter-v16n";
}
