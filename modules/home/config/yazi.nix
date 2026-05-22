{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.yazi = {
    enable = true;

    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "<C-d>" ];
          run = ''shell 'GTK_THEME=Adwaita:dark ripdrag "$PWD"/* -x 2>/dev/null &' --confirm'';
          desc = "Drag and drop selected files";
        }
      ];
    };
  };

  xdg.configFile."gtk-4.0/gtk.css".text = ''
    window {
      background-color: #2e3440;
      color: #d8dee9;
    }

    label {
      color: #d8dee9;
      font-family: "FiraCode Nerd Font Mono";
      font-size: 12pt;
    }

    button {
      background-color: #3b4252;
      color: #d8dee9;
      border-color: #88c0d0;
    }

    button:hover {
      background-color: #4c566a;
    }

    selection {
      background-color: #4c566a;
      color: #eceff4;
    }
  '';
}
