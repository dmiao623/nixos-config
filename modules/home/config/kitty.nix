{
  ...
}:

{
  programs.kitty = {
    enable = true;

    font.name = "FiraCode Nerd Font Mono";
    font.size = 10.0;
    shellIntegration.mode = "no-cursor";

    keybindings = {
      "cmd+c" = "copy_to_clipboard";
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "alt+n" = "launch --cwd=current --type=os-window";
      "alt+j" = "scroll_line_down";
      "alt+k" = "scroll_line_up";
      "alt+shift+j" = "scroll_end";
      "alt+shift+k" = "scroll_home";
      "alt+s" = "show_scrollback";
      "cmd+q" = "quit";
      "alt+f" = "send_key alt+f";
      "alt+b" = "send_key alt+b";
      "alt+d" = "send_key alt+d";
      "cmd+plus" = "change_font_size all +2.0";
      "cmd+minus" = "change_font_size all -2.0";
      "cmd+k" = "clear_terminal to_cursor active";
    };

    settings = {
      clear_all_shortcuts = "yes";
      cursor_stop_blinking_after = 0;
      tab_bar_min_tabs = 2;
      paste_actions = "confirm-if-large";
      macos_quit_when_last_window_closed = "yes";
    };

    extraConfig = ''
      background #2d2a2e
      foreground #e3e1e4

      selection_background #423f46
      selection_foreground #e3e1e4

      cursor #e3e1e4
      cursor_text_color background

      # Black
      color0 #1a181a
      color8 #848089

      # Red
      color1 #f85e84
      color9 #f85e84

      # Green
      color2 #9ecd6f
      color10 #9ecd6f

      # Yellow
      color3 #e5c463
      color11 #e5c463

      # Blue
      color4 #7accd7
      color12 #7accd7

      # Magenta
      color5 #ab9df2
      color13 #ab9df2

      # Cyan
      color6 #ef9062
      color7 #ef9062

      # White
      color7 #e3e1e4
      color15 #e3e1e4
    '';
  };
}
