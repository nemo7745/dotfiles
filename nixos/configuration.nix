{ config, pkgs, lib, ... }:

{
  imports =[ ./hardware-configuration.nix ./users.nix ./desktop.nix ];
  boot.loader = {
    timeout = 0;
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      editor = false;
    };
  };
  systemd.oomd.enable = false;
  security.doas = {
    enable = true;
    extraRules = [ { groups = [ "wheel" ]; persist = true; keepEnv = true; } ];
  };
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Asia/Tokyo";
  networking.networkmanager.enable = true;
  services.timesyncd = {
    enable = true;
    servers = [ "ntp.jst.mfeed.ad.jp" "ntp1.v6.mfeed.ad.jp" "ntp2.v6.mfeed.ad.jp" "ntp3.v6.mfeed.ad.jp" ];
    extraConfig = "FallbackNTP=ntp.nict.jp";
  };
  networking.firewall.enable = false;
  networking.nftables = {
    enable = true;
    flushRuleset = true;
    ruleset = 
      ''
        table inet filter {
          chain input {
            type filter hook input priority filter; policy drop;
            iif "lo" accept
            ct state established,related accept
            ct state invalid drop
            icmpv6 type { nd-router-solicit, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert } accept
          }
          chain forward {
            type filter hook forward priority filter; policy drop;
          }
          chain output {
            type filter hook output priority filter; policy accept;
          }
        }
      '';
    extraDeletions =
      ''
        table inet mangle;
      '';
  };
  services.resolved = {
    enable = true;
    llmnr = "false";
  };
  networking.hostName = "nixos";
  virtualisation.podman.enable = false;
  services.resolved = {
    enable = true;
    llmnr = false;
  };
  programs.zsh.enable = true;
  programs.git.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    wireless-regdb
  ];
  system.stateVersion = "23.11";
}