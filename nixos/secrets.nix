{ ... }:

{
  # Secreto para la contraseña del usuario
  age.secrets.user-password = {
    file = ./secrets/user-password.age;
    owner = "root";
    mode = "0400";
  };

  # Secreto para el token de k3s
  age.secrets.k3s-token = {
    file = ./secrets/k3s-token.age;
    owner = "root"; # K3s necesita leer este archivo
    mode = "0440";  # Permisos de lectura para root y el grupo k3s
    group = "k3s";  # Asignar al grupo k3s
  };
}
