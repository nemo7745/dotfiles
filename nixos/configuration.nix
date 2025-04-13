{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  system.stateVersion = "25.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  security.doas = {
    enable = true;
    extraRules = [ { groups = [ "wheel" ]; persist = true; keepEnv = true; } ];
  };
  i18n.defaultLocale = "en_GB.UTF-8";
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
            udp dport 5353 accept
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
    users.users.nemo = {
    isNormalUser = true;
    initialPassword = "CHANGE_IT";
    home = "/home/nemo";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "tor" ];
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
  nixpkgs.config.allowUnfree = true;
  virtualisation.podman.enable = true;
  programs.zsh.enable = true;
  programs.git.enable = true;
  environment.systemPackages = with pkgs; [
    gnupg
    ldns
    nyx
    obfs4
    pinentry-tty
    sbctl
    vim
    wireless-regdb
    zsh-completions
  ];
}