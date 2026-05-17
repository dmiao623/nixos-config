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
        modules-center = [ "clock" ];
        modules-right = [ "custom/spotify" "pulseaudio" "network" "battery" ];

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          sort-by-number = true;
          all-outputs = true;
          active-only = false;
          format-icons = {
            active = "";
            default = "";
            empty = "";
          };
          window-rewrite-default = "";
          window-rewrite = {
            "class<kitty>" = "";
            "class<firefox>" = "";
            "class<qutebrowser>" = "";
            "class<Code>" = "";
            "class<code>" = "";
            "class<dolphin>" = "";
            "class<thunar>" = "";
            "class<spotify>" = "";
            "class<Spotify>" = "";
            "class<discord>" = "";
            "class<slack>" = "";
            "class<obsidian>" = "";
            "class<steam>" = "";
            "class<mpv>" = "";
          };
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%A, %B %d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "  {capacity}%";
          format-plugged = "  {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };

        network = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "  {ipaddr}";
          format-disconnected = "  Disconnected";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "  Muted";
          format-icons = {
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };

        "custom/spotify" = {
          format = "{}";
          return-type = "json";
          max-length = 40;
          interval = 5;
          exec = "${pkgs.writeShellScript "waybar-spotify" ''
            STATUS=$(${pkgs.playerctl}/bin/playerctl --player=spotify status 2>/dev/null)
            if [ "$STATUS" = "Playing" ]; then
              ARTIST=$(${pkgs.playerctl}/bin/playerctl --player=spotify metadata artist)
              TITLE=$(${pkgs.playerctl}/bin/playerctl --player=spotify metadata title)
              echo "{\"text\": \"  $ARTIST - $TITLE\", \"class\": \"playing\"}"
            elif [ "$STATUS" = "Paused" ]; then
              ARTIST=$(${pkgs.playerctl}/bin/playerctl --player=spotify metadata artist)
              TITLE=$(${pkgs.playerctl}/bin/playerctl --player=spotify metadata title)
              echo "{\"text\": \"  $ARTIST - $TITLE\", \"class\": \"paused\"}"
            else
              echo "{\"text\": \"\", \"class\": \"stopped\"}"
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
        font-family: "FiraCode Nerd Font Mono", sans-serif;
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
      #battery,
      #network,
      #pulseaudio,
      #custom-spotify {
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

      #network {
        color: #88c0d0;
      }

      #network.disconnected {
        color: #bf616a;
      }

      #pulseaudio {
        color: #b48ead;
      }

      #pulseaudio.muted {
        color: #4c566a;
      }

      #custom-spotify {
        color: #a3be8c;
      }

      #custom-spotify.paused {
        color: #4c566a;
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
  ];
}
