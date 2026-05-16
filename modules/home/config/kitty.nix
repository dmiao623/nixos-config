{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font.name = "FiraCode Nerd Font Mono";
    font.size = 12.0;
    shellIntegration.mode = "no-cursor";

    keybindings = {
      "cmd+c"          = "copy_to_clipboard";
      "cmd+v"          = "paste_from_clipboard";
      "cmd+n"          = "new_os_window";
      "shift+cmd+w"    = "close_os_window";
      "shift+cmd+i"    = "set_tab_title";
      "cmd+t"          = "new_tab";
      "cmd+w"          = "close_tab";
      "cmd+l"          = "next_tab";
      "ctrl+tab"       = "next_tab";
      "cmd+h"          = "previous_tab";
      "ctrl+shift+tab" = "previous_tab";
      "cmd+q"          = "quit";
      "cmd+plus"       = "change_font_size all +2.0";
      "cmd+minus"      = "change_font_size all -2.0";
      "cmd+k"          = "clear_terminal to_cursor active";
    };

    settings = {
      clear_all_shortcuts                = "yes";
      cursor_stop_blinking_after         = 0;
      tab_bar_margin_height              = "5.0 2.0";
      tab_bar_style                      = "separator";
      tab_switch_strategy                = "right";
      tab_separator                      = "\" ┇ \"";
      tab_bar_min_tabs                   = 1;
      tab_title_max_length               = 30;
      tab_title_template                 = "{bell_symbol}{activity_symbol}{fmt.bold}{index}{fmt.nobold}| {title}";
      paste_actions                      = "confirm-if-large";
      macos_quit_when_last_window_closed = "yes";
    };

    extraConfig = ''
      background #2d2a2e
      foreground #e3e1e4

      selection_background #423f46
      selection_foreground #e3e1e4

      cursor #e3e1e4
      cursor_text_color background

      active_tab_background #79767a
      active_tab_foreground #e3e1e4
      active_tab_font_style bold
      inactive_tab_background #2d2a2e
      inactive_tab_foreground #e3e1e4
      inactive_tab_font_style normal

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