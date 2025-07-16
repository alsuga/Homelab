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
      ""
    ];
  };
}

