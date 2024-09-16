{ config, pkgs, lib, ... }:

{
  imports =[ ./hardware-configuration.nix ./users.nix ];
  boot.loader = {
    timeout = 0;
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      editor = false;
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  security.doas = {
    enable = true;
    extraRules = [ { groups = [ "wheel" ]; persist = true; keepEnv = true; } ];
  };
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Asia/Tokyo";
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";
  services.resolved.enable = true;
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
  };
  services.tor = {
    enable = false;
    settings = {
      AvoidDiskWrites = true;
      CookieAuthentication = true;
      DataDirectoryGroupReadable = true;
      CookieAuthFileGroupReadable = true;
      ControlPort = [ { port = 9051; } ];
      UseBridge = true;
      ClientTransportPlugin = "obfs4 exec ${pkgs.obfs4}/bin/lyrebird";
      ReachableAddresses = [ "*:80" "*:443" ];
      Bridge= [
      ];
    };
  };
  virtualisation.podman.enable = false;
  programs.zsh.enable = true;
  programs.git.enable = true;
  environment.systemPackages = with pkgs; [
    gnupg
    nyx
    obfs4
    pinentry
    vim
    wireless-regdb
    zsh-completions
  ];
  system.stateVersion = "24.11";
}