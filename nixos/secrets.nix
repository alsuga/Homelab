let
  host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOtOvtzUhnmekCdm+VaF6lGbxiIHZ4qmcecvqnOzVcew ing.alsuga@gmail.com";
  target1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILLYKcnob711EjEzLViY5IwkRzSzVqc7AptL+gx3buCp root@nixos";
in
{
  "user-password.age".publicKeys = [ host target1 ];
  "k3s-token.age".publicKeys = [ host target1 ];
}
