{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;
    settings = {
      mainBar = {
        layer = "top";
        spacing = 0;
        modules-left = [ "mpris" "hyprland/submap" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "tray" "battery" "pulseaudio" "privacy" "clock" ];
        clock = {
          format = "{:%T}";
          format-alt = "{:%F}";
          interval = 1;
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        mpris = {
          format = "{player_icon} <b>{dynamic}</b>";
          format-paused = "{status_icon} <b>{dynamic}</b>";
          format-stopped = "{status_icon} </b>{dynamic}</b>";
          dynamic-len = 64;
          player-icons = {
            default = "";
            firefox = "";
          };
          status-icons = {
            paused = "";
            stopped = "";
          };
        };
        "hyprland/submap" = {
          format = " <b>{}</b>";
          tooltop = false;
        };
        "hyprland/workspaces".persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
            "6" = [];
            "7" = [];
            "8" = [];
            "9" = [];
            "10" = [];
        };
        privacy.modules = [
          { type = "screenshare"; }
          { type = "audio-in"; }
        ];
        tray.spacing = 8;
        pulseaudio = {
          format = "{icon}";
          format-bluetooth = "{icon}";
          format-bluetooth-muted = "";
          format-muted = "";
          format-icons.default = [ "" "" "" ];
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
      };
    };
    style = 
    ''
    * {
      font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
      font-size: 13px;
    }
    window#waybar {background-color: #303030; border-radius: 0 0 16px 16px;}
    #clock, #mpris, #submap, #workspaces, #privacy-item, #tray, #pulseaudio, #battery {
    color: #f0f0f0;
    background-color: #404040;
    margin: 4px 0;
    }
    #tray {padding: 2px 4px 2px 10px; border-radius: 16px 0 0 16px;}
    #pulseaudio {padding: 2px 4px;}
    #privacy-item {color: red; padding: 2px 4px;}
    #clock {margin-right: 8px; font-weight: bolder; border-radius: 0 16px 16px 0; padding: 2px 10px 2px 4px;}
    #mpris {margin-left: 8px; border-radius: 16px; padding: 2px 10px;}
    #submap {border-radius: 16px; padding: 2px 10px; font-weight: bolder;}
    #workspaces {padding: 2px 8px; border-radius: 16px;}
    #workspaces button {color: #f0f0f0; border-radius: 16px; padding: 0 1px; margin: 0 2px;}
    #workspaces button.active {background-color: #606060;}
    #workspaces button.empty {color: #303030; padding: 0 4px;}
    #workspaces button.visible {color: #f0f0f0; font-weight: bolder; padding: 0 4px;}
    '';
  };
}