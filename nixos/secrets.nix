let
  # Replace with your actual SSH public key
  alejandro = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIYourActualPublicKeyHere alejandro@example.com";
  
  # Server SSH host keys (get these after first deployment)
  homelab-0 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIServerHostKeyHere";
  
  users = [ alejandro ];
  systems = [ homelab-0 ];
  all = users ++ systems;
in
{
  "alejandro-password.age".publicKeys = all;
  "k3s-token.age".publicKeys = all;
}

