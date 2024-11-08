{ config, pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
  fonts.packages = with pkgs; [
    font-awesome
    dejavu_fonts
    ipafont
    ipaexfont
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    noto-fonts-emoji-blob-bin
    noto-fonts-monochrome-emoji
  ];
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = [ pkgs.fcitx5-mozc ];
    };
  };
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.waybar.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-volman tumbler thunar-archive-plugin ];
  };
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    bitwarden
    bluez-tools
    brightnessctl
    cryptomator
    discord
    easyeffects
    firefox
    gamescope
    hypridle
    hyprlock
    hyprpaper
    keepassxc
    kitty
    libsForQt5.polkit-kde-agent
    libnotify
    mako
    mangohud
    networkmanagerapplet
    papirus-icon-theme
    pavucontrol
    playerctl
    qt6Packages.qt6gtk2
    seahorse
    spotify
    syncthing
    tor-browser
    veracrypt
    vlc
    vscodium
    wofi
    xarchiver
    xdg-desktop-portal-hyprland
    xdg-user-dirs
    xdg-utils
    xfce.ristretto
  ];
}