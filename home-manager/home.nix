{ config, ... }:

{
  imports = [
    ./dotfiles.nix
    ./git.nix
    ./hyprland.nix
    ./mako.nix
    ./theme.nix
    ./waybar.nix
    ./wofi.nix
  ];
  home.username = "nemo";
  home.homeDirectory = "/home/nemo";
  home.stateVersion = "23.11";
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  programs.home-manager.enable = true;
}
