{ config, pkgs, lib, ... }:

{
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.opensnitch.enable = true;
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
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-with-addons fcitx5-mozc ]; 
  };
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.waybar.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-volman thunar-archive-plugin thunar-media-tags-plugin ];
  };
  environment.systemPackages = with pkgs; [
    bitwarden
    bluez-tools
    discord
    easyeffects
    firefox
    gnome.seahorse
    hyprpaper
    keepassxc
    kitty
    libsForQt5.polkit-kde-agent
    mako
    networkmanagerapplet
    opensnitch-ui
    pavucontrol
    qt6Packages.qt6ct
    qt6Packages.qt6gtk2
    spotify
    syncthing
    veracrypt
    vivaldi
    vlc
    vscodium
    wofi
    xdg-desktop-portal-hyprland
    xdg-user-dirs
    xdg-utils
    xfce.ristretto
    xfce.tumbler
    ];
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "discord"
    "spotify"
    "veracrypt"
    "vivaldi"
  ];
}