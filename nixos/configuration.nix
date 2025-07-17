# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, meta, ... }:

{
  imports = [
  # Include the results of the hardware scan.
  ./hardware-configuration.nix
  ./secrets.nix
  ./users.nix
  ./networking.nix
  ./k3s.nix
];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      '';
  };

# Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


# Set your time zone.
  time.timeZone = "America/Bogota";

# Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

# Fixes for longhorn
  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];
  virtualisation.docker = {
    enable = true;
    logDriver = "json-file";
  };

  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
  ];

# List packages installed in system profile. To search, run:
# $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    k3s
    cifs-utils
    nfs-utils
    git
  ];

# List services that you want to enable:

# Automatic updates for security
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;  # Set to true if you want automatic reboots
  };

# Better logging
  services.journald.extraConfig = ''
    SystemMaxUse=100M;
    MaxRetentionSec=7day;
  '';

# NTP for time synchronization
  services.timesyncd.enable = true;

# This option defines the first version of NixOS you have installed on this particular machine,
# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
#
# Most users should NEVER change this value after the initial install, for any reason,
# even if you've upgraded your system to a new NixOS release.
#
# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
# so changing it will NOT upgrade your system.
#
# This value being lower than the current NixOS release does NOT mean your system is
# out of date, out of support, or vulnerable.
#
# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
# and migrated your data accordingly.
#
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
