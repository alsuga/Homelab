{ ... }:
{
  age.secrets.user-password = {
    file = ./secrets/user-password.age;
    owner = "alsuga";
    publicKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOtOvtzUhnmekCdm+VaF6lGbxiIHZ4qmcecvqnOzVcew ing.alsuga@gmail.com"
      # Temporary until I figure out how to import this
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILLYKcnob711EjEzLViY5IwkRzSzVqc7AptL+gx3buCp root@nixos"
    ];
  };

  age.secrets.k3s-token = {
    file = ./secrets/k3s-token.age;
    owner = "root";
    publicKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOtOvtzUhnmekCdm+VaF6lGbxiIHZ4qmcecvqnOzVcew ing.alsuga@gmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILLYKcnob711EjEzLViY5IwkRzSzVqc7AptL+gx3buCp root@nixos"
    ];
  };
}
