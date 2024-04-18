{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.extraCommands = [];
    settings = {
      "$mod" = "SUPER";
      "$fileManager" = "thunar";
      "$launcher" = "wofi --show drun";
      monitor = [
        ",preferred,auto,auto"
      ];
      exec-once = [
        "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
        "hyprpaper"
        "hypridle"
        "waybar"
        "mako"
        "thunar --daemon"
        "opensnitch-ui"
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
        border_size = 2;
        gaps_in = 0;
        gaps_out = 4;
        "col.inactive_border" = "rgba(505050ff)";
        "col.active_border" = "rgba(903cf5ff)";
        layout = "dwindle";
        allow_tearing = false;
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 4;
      };
      decoration = {
        rounding = 8;
        drop_shadow = false;
        blur.enabled = false;
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
        "$mod,R,exec,$launcher"
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
        ",${xbri}Up,${bctl} s +3%"
        ",${xbri}Down,${bctl} s 3%-"
        ",${xbkl}Up,${bctl} -d *kbd_backlight s +3%"
        ",${xbkl}Down,${bctl} -d *kbd_backlight s 3%-"
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
}