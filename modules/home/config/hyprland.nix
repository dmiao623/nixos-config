{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      monitor = [ ", preferred, auto, 1" ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        resize_on_border = true;
        "col.active_border" = "rgba(88c0d0ff)";
        "col.inactive_border" = "rgba(4c566aff)";
      };

      decoration = {
        rounding = 8;
      };

      input = {
        kb_layout = "us";
        kb_variant = "dvp";
        touchpad.natural_scroll = true;
      };

      bind = [
        "$mod, O, submap, launch"
        "$mod, Q, killactive"
        "$mod SHIFT, Q, forcekillactive"
        "$mod, D, exec, fuzzel"
        "$mod, F, fullscreen"

        # Move focus
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        # Move windows
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        # Workspaces
        "CTRL, ampersand, workspace, 1"
        "CTRL, bracketleft, workspace, 2"
        "CTRL, braceleft, workspace, 3"
        "CTRL, braceright, workspace, 4"
        "CTRL, parenleft, workspace, 5"
        "CTRL, equal, workspace, 6"
        "CTRL, asterisk, workspace, 7"
        "CTRL, parenright, workspace, 8"
        "CTRL, plus, workspace, 9"
        "CTRL, bracketright, workspace, 10"

        # Move to workspace
        "CTRL SHIFT, ampersand, movetoworkspace, 1"
        "CTRL SHIFT, bracketleft, movetoworkspace, 2"
        "CTRL SHIFT, braceleft, movetoworkspace, 3"
        "CTRL SHIFT, braceright, movetoworkspace, 4"
        "CTRL SHIFT, parenleft, movetoworkspace, 5"
        "CTRL SHIFT, equal, movetoworkspace, 6"
        "CTRL SHIFT, asterisk, movetoworkspace, 7"
        "CTRL SHIFT, parenright, movetoworkspace, 8"
        "CTRL SHIFT, plus, movetoworkspace, 9"
        "CTRL SHIFT, bracketright, movetoworkspace, 10"
      ];

      # Volume keys
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      # Mouse binds
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];


      # Touchpad gestures
      gesture = [ "3, horizontal, workspace" ];

      exec-once = [
        "waybar"
        "swaybg -i ${../../../assets/wallpaper.jpg} -m fill"

      ];
    };
    extraConfig = ''
      submap = launch
      bind = , K, exec, kitty
      bind = , K, submap, reset
      bind = , Q, exec, qutebrowser
      bind = , Q, submap, reset
      bind = , V, exec, code
      bind = , V, submap, reset
      bind = , escape, submap, reset
      submap = reset
    '';
  };


  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
  };

  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    swaybg
    wireplumber
  ];
}