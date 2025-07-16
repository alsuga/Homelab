{ config, lib, pkgs, ... }:

{
  users.users.alsuga = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"      # Enable 'sudo' for the user
      "docker"     # Allow docker access
      "networkmanager"  # Allow network configuration
    ];
    packages = with pkgs; [
      tree
      tmux
      htop
    ];
    # Use agenix for password management
    hashedPasswordFile = config.age.secrets.user-password.path;
    openssh.authorizedKeys.keys = [
      # Move your SSH key here or use agenix
      config.age.secrets.ssh-key.path
    ];

    age.secrets.alejandro-password = {
      file = ./secrets/alejandro-password.age;
      owner = "alejandro";
      group = "users";
      mode = "0400";
    };
  };
}

