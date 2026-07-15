{ ... }:

{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";

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
}
