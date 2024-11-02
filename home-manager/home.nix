{ config, ... }:

{
  imports = [
    ./dotfiles.nix
    ./git.nix
    ./gpg-agent.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./mako.nix
    ./theme.nix
    ./waybar.nix
    ./wofi.nix
  ];
  home.username = "nemo";
  home.homeDirectory = "/home/nemo";
  home.stateVersion = "24.11";
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  programs.home-manager.enable = true;
}