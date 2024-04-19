# EXAMPLE
{ config, lib, ... }:

{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  boot.initrd.luks.devices.crytped.device = "/dev/disk/by-partuuid/";
  fileSystems."/" =
    { device = "/dev/mapper/";
      fsType = "xfs";
    };
  fileSystems."/boot" = 
    { device = "/dev/disk/by-partuuid/";
      fsType = "vfat";
    };
  swapDevices = [ { devices = "/dev/mapper/"; } ];
}