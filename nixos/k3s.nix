{ config, lib, pkgs, meta, ... }:

{
  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];
  
  virtualisation.docker = {
    enable = true;
    logDriver = "json-file";
  };

  services.k3s = {
    enable = true;
    role = "server";
    tokenFile = config.age.secrets.k3s-token.path;
    extraFlags = toString ([
      "--write-kubeconfig-mode=0644"
      "--cluster-init"
      "--disable=servicelb"
      "--disable=traefik"
      "--disable=local-storage"
    ] ++ lib.optionals (meta.hostname != "homelab-0") [
      "--server=https://homelab-0:6443"
    ]);
    clusterInit = (meta.hostname == "homelab-0");
  };

  services.openiscsi = {
    enable = true;
    name = "iqn.2016-04.com.open-iscsi:${meta.hostname}";
  };
}

