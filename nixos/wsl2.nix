{ config, lib, pkgs, ... }:

{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "24.11";
  wsl.enable = true;
  wsl.defaultUser = "nemo";
  users.users.nemo.shell = pkgs.zsh;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = "Asia/Tokyo";
  networking.hostName = "nixos-wsl";
  services.timesyncd.enable = false;
  security.doas = {
    enable = true;
    extraRules = [ { groups = [ "wheel" ]; persist = true; keepEnv = true; } ];
  };
  virtualisation.podman.enable = true;
  programs = {
    git.enable = true;
    zsh.enable = true;
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld;
    };
  };
  environment.systemPackages = with pkgs; [
    gnupg
    ldns
    nixd
    pinentry-tty
    podman-compose
    vim
    wget
    zsh-completions
  ];
}