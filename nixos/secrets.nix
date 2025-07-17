{ config, lib, ... }:

{
  age.secrets.user-password = {
    file = ./secrets/user-password.age;
    owner = "alsuga";
    publicKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOtOvtzUhnmekCdm+VaF6lGbxiIHZ4qmcecvqnOzVcew ing.alsuga@gmail.com"
      (lib.findSingle (key: key.type == "ed25519") config.services.openssh.hostKeys).pubKey
    ];
  };

  age.secrets.k3s-token = {
    file = ./secrets/k3s-token.age;
    owner = "root";
    publicKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOtOvtzUhnmekCdm+VaF6lGbxiIHZ4qmcecvqnOzVcew ing.alsuga@gmail.com"
      (lib.findSingle (key: key.type == "ed25519") config.services.openssh.hostKeys).pubKey
    ];
  };
}
