{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nemo";
  home.homeDirectory = "/home/nemo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nemo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$fileManager" = "thunar";
      "$launcher" = "wofi --show drun";
      monitor = [
        ",preferred,auto,auto,transform,1"
      ];
      exec-once = [
        "/nix/store/b98hiszyrbkk3fxakz30mwxnib3f9bhs-polkit-kde-agent-1-5.27.10/libexec/polkit-kde-authentication-agent-1"
        "hyprpaper"
        "hypridle"
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
        workspace_swipe_numbered = true;
      };
      decoration = {
        rounding = 8;
        drop_shadow = false;
        blur.enabled = false;
        };
      animations.enabled = false;
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        animate_manual_resizes = true;
      };
      bind = [
        "SUPER,Q,killactive"
       "SUPER_L,DELETE,exit"
        "SUPER,E,exec,$fileManager"
        "SUPER,R,exec,$launcher"
        "SUPER,X,pseudo,"
        "SUPER,C,togglefloating,"
        "SUPER,L,exec,hyprlock --immediate"
        "SUPER,W,movefocus,u"
        "SUPER,A,movefocus,l"
        "SUPER,S,movefocus,d"
        "SUPER,D,movefocus,r"
        "SUPER,1,workspace,1"
        "SUPER,2,workspace,2"
        "SUPER,3,workspace,3"
        "SUPER,4,workspace,4"
        "SUPER,5,workspace,5"
        "SUPER,6,workspace,6"
        "SUPER,7,workspace,7"
        "SUPER,8,workspace,8"
        "SUPER,9,workspace,9"
        "SUPER,0,workspace,10"
        "ALT,1,movetoworkspace,1"
        "ALT,2,movetoworkspace,2"
        "ALT,3,movetoworkspace,3"
        "ALT,4,movetoworkspace,4"
        "ALT,5,movetoworkspace,5"
        "ALT,6,movetoworkspace,6"
        "ALT,7,movetoworkspace,7"
        "ALT,8,movetoworkspace,8"
        "ALT,9,movetoworkspace,9"
        "ALT,0,movetoworkspace,10"
      ];
    };
  };
}
