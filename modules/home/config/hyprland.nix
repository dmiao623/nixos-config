{ pkgs, ... }:

let
  screenshotSave = pkgs.writeShellScript "screenshot-save" ''
    TMPFILE=$(mktemp /tmp/screenshot-XXXXXX.png)
    ${pkgs.hyprshot}/bin/hyprshot -m region --raw > "$TMPFILE" 2>/dev/null
    if [ ! -s "$TMPFILE" ]; then
      rm -f "$TMPFILE"
      exit 0
    fi
    DEST=$(${pkgs.zenity}/bin/zenity --file-selection --save \
      --filename="$(date '+%Y-%m-%d_%H-%M-%S').png" 2>/dev/null)
    if [ -n "$DEST" ]; then
      mv "$TMPFILE" "$DEST"
    else
      rm -f "$TMPFILE"
    fi
  '';

  screenshotClipboard = pkgs.writeShellScript "screenshot-clipboard" ''
    ${pkgs.hyprshot}/bin/hyprshot -m region --raw 2>/dev/null \
      | ${pkgs.wl-clipboard}/bin/wl-copy --type image/png
  '';

  screenshotFullSave = pkgs.writeShellScript "screenshot-full-save" ''
    TMPFILE=$(mktemp /tmp/screenshot-XXXXXX.png)
    ${pkgs.hyprshot}/bin/hyprshot -m output --raw > "$TMPFILE" 2>/dev/null
    if [ ! -s "$TMPFILE" ]; then
      rm -f "$TMPFILE"
      exit 0
    fi
    DEST=$(${pkgs.zenity}/bin/zenity --file-selection --save \
      --filename="$(date '+%Y-%m-%d_%H-%M-%S').png" 2>/dev/null)
    if [ -n "$DEST" ]; then
      mv "$TMPFILE" "$DEST"
    else
      rm -f "$TMPFILE"
    fi
  '';

  screenshotFullClipboard = pkgs.writeShellScript "screenshot-full-clipboard" ''
    ${pkgs.hyprshot}/bin/hyprshot -m output --raw 2>/dev/null \
      | ${pkgs.wl-clipboard}/bin/wl-copy --type image/png
  '';
in

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      monitor = [
        "eDP-1, 1920x1200@60, 0x0, 1"
        "HDMI-A-1, 3840x2160@30, auto-left, 1.5"
        ", preferred, auto, 1" # fallback for any other monitor
      ];

      workspace = [
        "1, monitor:HDMI-A-1, default:true"
        "2, monitor:HDMI-A-1"
        "3, monitor:HDMI-A-1"
        "4, monitor:HDMI-A-1"
        "5, monitor:HDMI-A-1"
        "6, monitor:eDP-1, default:true"
        "7, monitor:eDP-1"
        "8, monitor:eDP-1"
        "9, monitor:eDP-1"
        "10, monitor:eDP-1"
      ];

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

        # Move workspace to other monitor
        "$mod CTRL, H, movecurrentworkspacetomonitor, l"
        "$mod CTRL, L, movecurrentworkspacetomonitor, r"

        # Screenshots
        ", Print, exec, ${screenshotSave}"
        "SHIFT, Print, exec, ${screenshotClipboard}"
        "$mod, Print, exec, ${screenshotFullSave}"
        "$mod SHIFT, Print, exec, ${screenshotFullClipboard}"

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
      bind = , C, exec, kitty -- nvim -c "Cilantro"
      bind = , C, submap, reset
      bind = , D, exec, wdisplays
      bind = , D, submap, reset
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

  xdg.desktopEntries.cilantro = {
    name = "Cilantro";
    exec = "kitty -- nvim -c Cilantro";
    icon = ../../../assets/cilantro.svg;
    terminal = false;
  };

  home.packages = with pkgs; [
    grim
    hyprshot
    slurp
    swaybg
    wdisplays
    wireplumber
    zenity
  ];
}
