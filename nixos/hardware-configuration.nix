# EXAMPLE
{ config, lib, pkgs, ... }:

{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    cpu = {
      #intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      #amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
    #nvidia.open = true;
    graphics.extraPackages = [];
  };
  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    loader = {
      timeout = 0;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = lib.mkForce false;
        editor = false;
      };
    };
    initrd = {
      availableKernelModules = [];
      kernelModules = [];
      luks.devices.luks-nixos.device = "/dev/disk/by-partuuid/33beefe0-2d93-4772-94d3-3afa441f87ae";
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [];
    kernelParams = [];
    extraModprobeConfig =
      ''
      '';
  };
  #services.xserver.videoDrivers = [];
  fileSystems."/" =
    { device = "/dev/mapper/nixos-root";
      fsType = "xfs";
    };
  fileSystems."/boot" = 
    { device = "/dev/disk/by-partuuid/";
      fsType = "vfat";
    };
  swapDevices = [ { devices = "/dev/mapper/nixos-swap"; } ];
}