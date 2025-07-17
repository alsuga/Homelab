{ config, lib, pkgs, meta, ... }:
{
  networking.hostName = meta.hostname; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  
# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ 80 ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 22 6443 10250 2379 2380 ];  # SSH, K3s API, kubelet, etcd
  allowedUDPPorts = [ 8472 ];  # flannel VXLAN
  trustedInterfaces = [ "flannel.1" "cni0" ];
};

# Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;  # Only allow key-based auth
      PermitRootLogin = "no";         # Disable root login
      PubkeyAuthentication = true;
      X11Forwarding = false;          # Disable X11 forwarding
      AllowUsers = [ "alsuga" ];      # Only allow specific users
    };
  };

  # Additional security measures
  services.fail2ban = {
    enable = true;
    jails = {
      ssh.settings = {
        enabled = true;
        port = "22";  # Match your SSH port
        maxretry = 3;
        bantime = "1h";
      };
    };
  };
}
