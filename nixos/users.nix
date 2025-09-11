{ config, lib, pkgs, ... }:

{
  users.users.alsuga = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"      # Enable 'sudo' for the user
      "docker"
    ];
    packages = with pkgs; [
      tree
    ];
    hashedPasswordFile = config.sops.secrets.user_password.path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOtOvtzUhnmekCdm+VaF6lGbxiIHZ4qmcecvqnOzVcew ing.alsuga@gmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2aNQQRfJsIrWRtFyntXyxWgsdw9J1VHyZNLv2DQIwb ing.alsuga@gmail.com"
    ];
  };
}

