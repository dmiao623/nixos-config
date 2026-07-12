{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "docker-28.5.2"
    "electron-39.8.10"
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  environment.systemPackages = with pkgs; [
    bat
    bitwarden-desktop
    claude-code
    curl
    discord
    docker-client
    eza
    gcc
    git
    google-chrome
    gotop
    jq
    kitty
    lf
    neofetch
    nixfmt-classic
    nixfmt-tree
    osu-lazer
    protonvpn-gui
    qutebrowser
    ripdrag
    slack
    rclone
    ripgrep
    spotify
    texlive.combined.scheme-medium
    unzip
    uv
    wget
    wl-clipboard
    yazi
    zathura
    zotero
    zoom-us
  ];
}
