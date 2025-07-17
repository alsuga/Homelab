{ config, lib, pkgs, ... }:

{
  users.users.alsuga = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"      # Enable 'sudo' for the user
    ];
    packages = with pkgs; [
      tree
    ];
    # Use agenix for password management
    hashedPasswordFile = config.age.secrets.user-password.path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOtOvtzUhnmekCdm+VaF6lGbxiIHZ4qmcecvqnOzVcew ing.alsuga@gmail.com"
    ];
  };
}

