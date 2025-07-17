{ ... }:

{
  age.secrets.user-password = {
    file = ./secrets/user-password.age;
    owner = "alsuga";
  };

  age.secrets.k3s-token = {
    file = ./secrets/k3s-token.age;
    owner = "root";
  };
}
