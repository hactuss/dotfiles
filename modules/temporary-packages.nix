{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alacritty
    freerdp
    flameshot
    librewolf
    ghostty
    pavucontrol

    waypaper
    feh
    fuzzel
    onefetch
    git

    btop
    prismlauncher
    alejandra
    mpv
    # davinci-resolve
    #xmrig
    r2modman
    unrar
    xwayland-satellite

    # niri wallpaper
    swaybg

    swaylock
    awww
    imagemagick
    waybar

    swaylock-plugin
    swaylock-fancy
    swaylock-effects
    kdePackages.partitionmanager
  ];
}
