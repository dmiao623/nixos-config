{ pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        icon-theme = "Papirus";
        list-executables-in-path = "no";
        font = "monospace:size=9";
        width = 35;
        lines = 8;
      };
      colors = {
        background = "2e3440ff";
        text = "d8dee9ff";
        selection = "4c566aff";
        selection-text = "eceff4ff";
        border = "88c0d0ff";
        match = "88c0d0ff";
        selection-match = "8fbcbbff";
      };
      border = {
        radius = 0;
      };
      key-bindings = {
        next = "Control+j";
        prev = "Control+k";
        delete-line-forward = "none";
      };
    };
  };

  home.packages = [ pkgs.papirus-icon-theme ];

  xdg.dataFile."icons/hicolor/scalable/apps/yazi.svg".text = ''
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">
      <rect width="64" height="64" rx="8" fill="#2e3440"/>
      <polyline points="10,10 32,34 54,10" fill="none" stroke="#88c0d0" stroke-width="7" stroke-linecap="round" stroke-linejoin="round"/>
      <line x1="32" y1="34" x2="32" y2="56" stroke="#88c0d0" stroke-width="7" stroke-linecap="round"/>
    </svg>
  '';

  xdg.desktopEntries = {
    # standardize capitalization
    kitty = {
      name = "Kitty";
      exec = "kitty";
      icon = "kitty";
    };
    "org.qutebrowser.qutebrowser" = {
      name = "Qutebrowser";
      exec = "qutebrowser %u";
      icon = "qutebrowser";
      mimeType = [
        "text/html"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
    };
    uuctl = {
      name = "Uuctl";
      exec = "uuctl";
      icon = "uuctl";
    };
    osu = {
      name = "Osu!";
      exec = "osu!";
      icon = "osu";
    };

    # hide unwanted .desktop entries from fuzzel
    "blueman-adapters" = {
      name = "Bluetooth Adapters";
      noDisplay = true;
    };
    htop = {
      name = "htop";
      noDisplay = true;
    };
    "kitty-open" = {
      name = "kitty-open";
      noDisplay = true;
    };
    lf = {
      name = "lf";
      noDisplay = true;
    };
    yazi = {
      name = "Yazi";
      exec = "kitty yazi";
      icon = "yazi";
    };
    nvim = {
      name = "Neovim";
      noDisplay = true;
    };
    "code-url-handler" = {
      name = "VS Code URL Handler";
      noDisplay = true;
    };
    "networkmanager_dmenu" = {
      name = "NetworkManager Dmenu";
      noDisplay = true;
    };
    "org.pulseaudio.pavucontrol" = {
      name = "PulseAudio Volume Control";
      noDisplay = true;
    };
    "nixos-manual" = {
      name = "NixOS Manual";
      noDisplay = true;
    };
    slack = {
      name = "Slack";
      exec = "slack";
      icon = "slack";
    };
    zotero = {
      name = "Zotero";
      exec = "zotero";
      icon = "zotero";
    };
    "org.freedesktop.Xwayland" = {
      name = "Xwayland";
      noDisplay = true;
    };
    "xdg-desktop-portal-gtk" = {
      name = "Portal";
      noDisplay = true;
    };
  };
}
