{ pkgs, ... }:

let
  screenshotSave = pkgs.writeShellScript "screenshot-save" ''
    TMPFILE=$(mktemp /tmp/screenshot-XXXXXX.png)
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" "$TMPFILE" 2>/dev/null
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
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - 2>/dev/null \
      | ${pkgs.wl-clipboard}/bin/wl-copy --type image/png
  '';

  screenshotFullSave = pkgs.writeShellScript "screenshot-full-save" ''
    TMPFILE=$(mktemp /tmp/screenshot-XXXXXX.png)
    ${pkgs.grim}/bin/grim "$TMPFILE" 2>/dev/null
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
    ${pkgs.grim}/bin/grim - 2>/dev/null \
      | ${pkgs.wl-clipboard}/bin/wl-copy --type image/png
  '';

  dvpWorkspaceKeys = {
    "ampersand" = "1";
    "bracketleft" = "2";
    "braceleft" = "3";
    "braceright" = "4";
    "parenleft" = "5";
    "equal" = "6";
    "asterisk" = "7";
    "parenright" = "8";
    "plus" = "9";
    "bracketright" = "10";
  };

  workspaceBinds = builtins.concatStringsSep "\n" (
    builtins.concatLists (
      builtins.attrValues (
        builtins.mapAttrs (key: ws: [
          "bindsym Mod4+${key} workspace number ${ws}"
          "bindsym Mod4+Mod1+${key} move container to workspace number ${ws}"
        ]) dvpWorkspaceKeys
      )
    )
  );
in

{
  wayland.windowManager.sway = {
    enable = true;

    config = {
      modifier = "Mod4";

      input = {
        "type:keyboard" = {
          xkb_layout = "us";
        };
        "1:1:kanata" = {
          xkb_layout = "us";
          xkb_variant = "dvp";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";
        };
      };

      output = {
        "eDP-1" = {
          resolution = "1920x1200@60Hz";
          position = "0 0";
        };
        "HDMI-A-1" = {
          resolution = "3840x2160@30Hz";
          position = "-2560 0";
          scale = "1.5";
        };
        "*" = {
          bg = "#000000 solid_color";
        };
      };

      window = {
        border = 2;
        titlebar = false;
      };

      floating = {
        border = 2;
        titlebar = false;
        modifier = "Mod4";
      };

      colors = {
        focused = {
          border = "#48ff00ff";
          background = "#48ff00ff";
          text = "#000000";
          indicator = "#48ff00ff";
          childBorder = "#48ff00ff";
        };
        unfocused = {
          border = "#000000";
          background = "#000000";
          text = "#888888";
          indicator = "#000000";
          childBorder = "#000000";
        };
      };

      defaultWorkspace = "workspace number 1";

      keybindings =
        let
          mod = "Mod4";
        in
        {
          # Window management
          "${mod}+q" = "kill";
          "${mod}+f" = "fullscreen toggle";

          # Focus (vim-like)
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          # Move windows
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          # Move workspace to other monitor
          "${mod}+Ctrl+h" = "move workspace to output left";
          "${mod}+Ctrl+l" = "move workspace to output right";

          # Splits
          "${mod}+b" = "splith";
          "${mod}+v" = "splitv";

          # Layout
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";

          # Floating
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";

          # Screenshots
          "Print" = "exec ${screenshotSave}";
          "Shift+Print" = "exec ${screenshotClipboard}";
          "${mod}+Print" = "exec ${screenshotFullSave}";
          "${mod}+Shift+Print" = "exec ${screenshotFullClipboard}";

          # Volume
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

          # Launch mode
          "${mod}+o" = "mode launch";

        };

      modes = {
        launch = {
          "b" = "exec bitwarden; mode default";
          "c" = "exec kitty -- nvim -c Cilantro; mode default";
          "d" = "exec discord; mode default";
          "k" = "exec kitty; mode default";
          "o" = "exec osu!; mode default";
          "q" = "exec qutebrowser; mode default";
          "s" = "exec spotify; mode default";
          "v" = "exec code; mode default";
          "w" = "exec wdisplays; mode default";
          "y" = "exec kitty -- yazi; mode default";
          "z" = "exec zotero; mode default";
          "Escape" = "mode default";
          "Return" = "mode default";
        };
      };

      bars = [
        {
          fonts = {
            names = [ "FiraCode Nerd Font Mono" ];
            size = 10.0;
          };
          position = "bottom";
          trayOutput = "none";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
        }
      ];
    };

    extraConfig = ''
      default_border pixel 2
      default_floating_border pixel 2
      smart_gaps off
      gaps outer 0
      gaps inner 0
      ${workspaceBinds}
      bindsym Mod4+dollar workspace number 1
      bindsym Mod4+Mod1+dollar move container to workspace number 1
    '';
  };

  programs.i3status-rust = {
    enable = true;
    bars.default = {
      icons = "awesome6";
      blocks = [
        {
          block = "net";
          format = " $icon $ssid ";
          format_alt = " $icon $ip ";
        }
        {
          block = "battery";
          format = " $icon $percentage ";
        }
        {
          block = "time";
          format = " $icon $timestamp.datetime(f:'%H:%M:%S %b %d, %Y') ";
          interval = 1;
        }
      ];
    };
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
    slurp
    wdisplays
    wl-clipboard
    wireplumber
    zenity
  ];
}
