{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        margin-top = 8;
        margin-left = 10;
        margin-right = 10;
        spacing = 0;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ ];
        modules-right = [ "group/spotify" "group/volume" "group/brightness" "group/bluetooth" "group/network" "battery" "clock" "clock#date" ];

        "hyprland/workspaces" = {
          format = "{id} {windows}";
          format-window-separator = " ";
          on-click = "activate";
          sort-by-number = true;
          all-outputs = true;
          active-only = false;
          window-rewrite-default = "󰂣";
          window-rewrite = {
            "class<kitty>" = "󰆍";
            "class<org.qutebrowser.qutebrowser>" = "󰖟";
            "class<Code>" = "󰨞";
            "class<code>" = "󰨞";
            "class<spotify>" = "󰓇";
            "class<Spotify>" = "󰓇";
            "class<discord>" = "󰙯";
            "class<obsidian>" = "󰎚";
          };
        };

        # Volume: icon + slider drawer
        "group/volume" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 300;
            transition-left-to-right = true;
          };
          modules = [ "pulseaudio" "pulseaudio/slider" ];
        };

        pulseaudio = {
          format = "{icon}";
          format-muted = "󰝟";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          tooltip-format = "{volume}%";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };

        # Brightness: icon + slider drawer
        "group/brightness" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 300;
            transition-left-to-right = true;
          };
          modules = [ "backlight" "backlight/slider" ];
        };

        backlight = {
          format = "{icon}";
          format-icons = [ "󰃞" "󰃟" "󰃠" ];
          tooltip-format = "{percent}% brightness";
        };

        "backlight/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };

        # Bluetooth: icon + status drawer
        "group/bluetooth" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 300;
            transition-left-to-right = true;
          };
          modules = [ "bluetooth#icon" "bluetooth#status" ];
        };

        "bluetooth#icon" = {
          format = "󰂯";
          format-connected = "󰂱";
          format-disabled = "󰂲";
          tooltip-format = "{status}";
          on-click = "blueman-manager";
        };

        "bluetooth#status" = {
          format = "Disconnected";
          format-connected = "{device_alias}";
          format-disabled = "";
        };

        # Network: icon + name drawer
        "group/network" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 300;
            transition-left-to-right = true;
          };
          modules = [ "network#icon" "network#name" ];
        };

        "network#icon" = {
          format-wifi = "{icon}";
          format-ethernet = "";
          format-disconnected = "󰤮";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          on-click = "networkmanager_dmenu";
        };

        "network#name" = {
          format-wifi = "{essid}";
          format-ethernet = "{ipaddr}";
          format-disconnected = "Disconnected";
        };

        "clock#date" = {
          format = "󰃶 {:%b %d, %Y}";
          interval = 60;
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        clock = {
          format = "󰥔 {:%H:%M:%S}";
          interval = 1;
          tooltip-format = "{:%A, %B %d %Y}";
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };

        "group/spotify" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 300;
            transition-left-to-right = true;
          };
          modules = [ "custom/spotify-icon" "custom/spotify-info" ];
        };

        "custom/spotify-icon" = {
          format = "{}";
          return-type = "json";
          interval = 3;
          exec = "${pkgs.writeShellScript "waybar-spotify-icon" ''
            STATUS=$(${pkgs.playerctl}/bin/playerctl --player=spotify status 2>/dev/null)
            if [ "$STATUS" = "Playing" ]; then
              echo "{\"text\": \"󰓇\", \"class\": \"playing\"}"
            elif [ "$STATUS" = "Paused" ]; then
              echo "{\"text\": \"󰓇\", \"class\": \"paused\"}"
            else
              echo "{\"text\": \"󰓇\", \"class\": \"closed\"}"
            fi
          ''}";
          on-click = "${pkgs.playerctl}/bin/playerctl --player=spotify play-pause";
        };

        "custom/spotify-info" = {
          format = "{}";
          return-type = "json";
          interval = 3;
          exec = "${pkgs.writeShellScript "waybar-spotify-info" ''
            STATUS=$(${pkgs.playerctl}/bin/playerctl --player=spotify status 2>/dev/null)
            if [ "$STATUS" = "Playing" ] || [ "$STATUS" = "Paused" ]; then
              ARTIST=$(${pkgs.playerctl}/bin/playerctl --player=spotify metadata artist 2>/dev/null)
              TITLE=$(${pkgs.playerctl}/bin/playerctl --player=spotify metadata title 2>/dev/null)
              echo "{\"text\": \"$ARTIST - $TITLE\"}"
            else
              echo "{\"text\": \"\"}"
            fi
          ''}";
          on-click = "${pkgs.playerctl}/bin/playerctl --player=spotify play-pause";
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "FiraCode Nerd Font", sans-serif;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(46, 52, 64, 0.85);
        border-radius: 12px;
        color: #d8dee9;
      }

      tooltip {
        background: #3b4252;
        border: 1px solid #4c566a;
        border-radius: 8px;
      }

      tooltip label {
        color: #d8dee9;
      }

      #workspaces,
      #clock,
      #battery {
        padding: 0 14px;
        margin: 6px 3px;
        border-radius: 8px;
        background: rgba(59, 66, 82, 0.6);
      }

      #workspaces {
        padding: 0 4px;
      }

      #workspaces button {
        padding: 0 8px;
        margin: 4px 2px;
        color: #4c566a;
        border-radius: 6px;
        background: transparent;
        transition: all 0.2s ease;
      }

      #workspaces button.active {
        color: #88c0d0;
        background: rgba(136, 192, 208, 0.15);
      }

      #workspaces button:hover {
        color: #81a1c1;
        background: rgba(129, 161, 193, 0.1);
      }

      #workspaces button.urgent {
        color: #bf616a;
        background: rgba(191, 97, 106, 0.15);
      }

      #clock {
        font-weight: bold;
        color: #eceff4;
      }

      #battery {
        color: #a3be8c;
      }

      #battery.charging {
        color: #a3be8c;
      }

      #battery.warning:not(.charging) {
        color: #ebcb8b;
      }

      #battery.critical:not(.charging) {
        color: #bf616a;
        animation: blink 1s linear infinite;
      }

      /* Group drawer styling */
      #spotify,
      #volume,
      #brightness,
      #bluetooth,
      #network {
        margin: 6px 3px;
        border-radius: 8px;
        background: rgba(59, 66, 82, 0.6);
      }

      /* Lead icons in drawers - fixed size, centered */
      #pulseaudio,
      #backlight,
      #bluetooth.icon,
      #network.icon,
      #custom-spotify-icon {
        min-width: 28px;
        padding: 0;
        background: transparent;
      }

      label {
        margin: 0;
      }

      #pulseaudio {
        color: #b48ead;
      }

      #pulseaudio.muted {
        color: #4c566a;
      }

      #backlight {
        color: #ebcb8b;
      }

      #bluetooth.icon {
        color: #81a1c1;
      }

      #bluetooth.disabled,
      #bluetooth.off {
        color: #4c566a;
      }

      #network.icon {
        color: #88c0d0;
      }

      #network.disconnected {
        color: #bf616a;
      }

      /* Slider styling */
      #pulseaudio-slider,
      #backlight-slider {
        padding: 0 8px;
        min-width: 100px;
      }

      #pulseaudio-slider slider,
      #backlight-slider slider {
        min-height: 0px;
        min-width: 0px;
        box-shadow: none;
        background: transparent;
        border: none;
        opacity: 0;
      }

      #pulseaudio-slider trough {
        min-height: 6px;
        min-width: 80px;
        border-radius: 4px;
        background: rgba(76, 86, 106, 0.6);
      }

      #pulseaudio-slider highlight {
        min-height: 6px;
        border-radius: 4px;
        background: #b48ead;
      }

      #backlight-slider trough {
        min-height: 6px;
        min-width: 80px;
        border-radius: 4px;
        background: rgba(76, 86, 106, 0.6);
      }

      #backlight-slider highlight {
        min-height: 6px;
        border-radius: 4px;
        background: #ebcb8b;
      }

      /* Drawer child text modules */
      #bluetooth.status,
      #network.name {
        color: #d8dee9;
        padding: 0 8px 0 4px;
      }

      #custom-spotify-icon {
        color: #a3be8c;
      }

      #custom-spotify-icon.paused,
      #custom-spotify-icon.closed {
        color: #4c566a;
      }

      #custom-spotify-info {
        color: #d8dee9;
        padding: 0 8px 0 4px;
      }

      @keyframes blink {
        to {
          color: #eceff4;
        }
      }
    '';
  };

  home.packages = with pkgs; [
    playerctl
    pavucontrol
    networkmanager_dmenu
    brightnessctl
    blueman
  ];
}
