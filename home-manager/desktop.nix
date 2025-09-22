{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.extraCommands = [];
    settings = {
      "$mod" = "SUPER";
      "$fileManager" = "thunar";
      "$launcher" = "wofi --show drun";
      env = [ 
        "XCURSOR_THEME,capitaine-cursors-white"
        "XCURSOR_SIZE,24"
      ];
      monitor = [
        ",preferred,auto,auto"
      ];
      exec-once = [
        "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"
        "hyprpaper"
        "hypridle"
        "waybar"
        "mako"
        "thunar --daemon"
        "nm-applet"
        "blueman-applet"
        "fcitx5"
      ];
      input = {
        kb_layout = "us";
        sensitivity = 0;
        accel_profile = "flat";
        follow_mouse = 0;
        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true;
          tap-to-click = false;
        };
      };
      general = {
        border_size = 1;
        gaps_in = 0;
        gaps_out = 0;
        "col.inactive_border" = "rgba(404040ff)";
        "col.active_border" = "rgba(606060ff)";
        layout = "dwindle";
        allow_tearing = false;
      };
      gesture = [
        "4, horizontal, workspace"
      ];
      decoration = {
        rounding = 0;
        blur.enabled = false;
        shadow.enabled = false;
        };
      animations.enabled = true;
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        animate_manual_resizes = true;
      };
      bind = let
        mf = "movefocus";
        ws = "workspace";
        mws = "movetoworkspace";
        xbri = "XF86MonBrightness";
        xbkl = "XF86KbdBrightness";
        xaud = "XF86Audio";
        bctl = "exec,brightnessctl";
        pctl = "exec,playerctl";
        wpvol = "exec,wpctl set-volume -l 1";
        lmb = "mouse:272";
        rmb = "mouse:273";
      in [
        "$mod,Q,killactive"
        "$mod_L,DELETE,exit"
        "$mod,E,exec,$fileManager"
        "$mod,space,exec,$launcher"
        "$mod,X,pseudo,"
        "$mod,C,togglefloating,"
        "$mod,L,exec,hyprlock --immediate"
        "$mod,W,${mf},u"
        "$mod,A,${mf},l"
        "$mod,S,${mf},d"
        "$mod,D,${mf},r"
        "$mod,1,${ws},1"
        "$mod,2,${ws},2"
        "$mod,3,${ws},3"
        "$mod,4,${ws},4"
        "$mod,5,${ws},5"
        "$mod,6,${ws},6"
        "$mod,7,${ws},7"
        "$mod,8,${ws},8"
        "$mod,9,${ws},9"
        "$mod,0,${ws},10"
        "ALT,1,${mws},1"
        "ALT,2,${mws},2"
        "ALT,3,${mws},3"
        "ALT,4,${mws},4"
        "ALT,5,${mws},5"
        "ALT,6,${mws},6"
        "ALT,7,${mws},7"
        "ALT,8,${mws},8"
        "ALT,9,${mws},9"
        "ALT,0,${mws},10"
        ",${xbri}Up,${bctl} s +1%"
        ",${xbri}Down,${bctl} s 1%-"
        ",${xbkl}Up,${bctl} -d *kbd_backlight s +1%"
        ",${xbkl}Down,${bctl} -d *kbd_backlight s 1%-"
        ",${xaud}Play,${pctl} play-pause"
        ",${xaud}Pause,${pctl} play-pause"
        ",${xaud}Next,${pctl} next"
        ",${xaud}Prev,${pctl} previous"
        ",${xaud}RaiseVolume,${wpvol} @DEFAULT_AUDIO_SINK@ 2%+"
        ",${xaud}LowerVolume,${wpvol} @DEFAULT_AUDIO_SINK@ 2%-"
        ",${xaud}Mute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ''
        bind=$mod,F,submap,edit
        submap=edit
        bindm=,${lmb},movewindow
        bindm=,${rmb},resizewindow
        bind=$mod,F,submap,reset
        submap=reset
        ''
      ];
    };
  };
  services.hypridle ={
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        before_sleep_cmd = "loginctl lock-session";
        lock_cmd = "pidof hyprlock || hyprlock --immediate";
      };
      listener = [
        {
          on-resume = "hyprctl dispatch dpms on";
          on-timeout = "hyprctl dispatch dpms off";
          timeout = 600;
        }
        {
          on-resume = "hyprctl dispatch dpms on && brightnessctl s 1 && brightnessctl -d *kbd_backlight s 1";
          on-timeout = "loginctl lock-session";
          timeout = 660;
        }
        {
          on-timeout = "systemctl suspend-then-hibernate";
          timeout = 3600;
        }
      ];
    };
  };
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 5;
        no_fadein = true;
        no_fade_out = true;
      };
      background = {
        monitor = "";
        path = "/home/nemo/Pictures/wallpaper/01.png";
        color = "rgb(303030)";
        blur_passes = 1;
        blur_size = 1;
        brightness = 0.5;
      };
      image = {
        path = "/home/nemo/Pictures/icon/01.png";
        size = 200;
        rounding = -1;
        border_size = 0;
        position = "0, 0";
        halign = "center";
        valign = "center";
      };
      input-field = {
        monitor = "";
        size = "300, 50";
        outline_thickness = 0;
        inner_color = "rgb(404040)";
        dots_size = 0.3;
        dots_center = false;
        font_color = "rgb(f0f0f0)";
        fade_on_empty = false;
        placeholder_text = "Password";
        fail_color = "rgb(9a1818)";
        position = "0, -200";
      };
      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<b>$(date "+%F")</b>"'';
          color = "rgb(f0f0f0)";
          font_size = 24;
          font_family = "sans-serif";
          position = "0, -150";
          halign = "center";
          valign = "top";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<b>$(date "+%H:%M")</b>"'';
          font_size = 64;
          color = "rgb(f0f0f0)";
          font_family = "sans-serif";
          position = "0, -50";
          halign = "center";
          valign = "top";
        }
        {
          monitor = "";
          text = " <b>$USER</b>";
          color = "rgb(f0f0f0)";
          font_family = "sans-serif";
          position = "0, -150";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
        "/home/nemo/Pictures/wallpaper/01.png"
      ];
      wallpaper = [
        ",/home/nemo/Pictures/wallpaper/01.png"
      ];
    };
  };
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
    window#waybar {background-color: #303030;}
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
  programs.wofi = {
    enable = true;
    settings = {
      prompt = "Search";
      allow_images = true;
      allow_markup = true;
      sort_order = "alphabetical";
      location = 2;
      yoffset = 100;
    };
    style = 
    ''
      #window {background-color: #303030; border-radius: 8px;}
      #outer-box {background-color: #303030; border-radius: 8px; margin: 6px;}
      #input {background-color: #404040; border-radius: 16px;}
      #inner-box {border-radius: 16px; padding: 4px;}
      #entry:selected {background-color: #606060; border-radius: 16px;}
    '';
  };
  services.mako = {
    enable = true;
    settings = {
      background-color = "#404040ff";
      text-color = "#f0f0f0ff";
      height = 500;
      border-size = 0;
      border-radius = 8;
      default-timeout = 10000;
      icon-path = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
      on-button-right = "exec makoctl menu -n $id -- wofi -d && makoctl dismiss -n $id";
    };
  };
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors-white";
      size = 24;
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme = {
      package = pkgs.materia-theme;
      name = "Materia-dark-compact";
    };
  };
}