{
  disko.devices = {
    disk = {
      os_nvme_disk = {
        device = "/dev/nvme0n1";

        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              name = "ESP";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                mountpoint = "/mnt/btrfs-root";
                subvolumes = {
                  "/@rootfs" = {
                    mountpoint = "/";
                  };
                  "/@home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" ];
                  };
                  "/@home/alsuga" = { };
                  "/@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime"];
                  };
                };
              };
            };
          };
        };
      };

      sata_media_disk = {
        device = "/dev/sda";

        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            data_storage = {
              name = "MEDIA_STORAGE";
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/srv/media";
              };
            };
          };
        };
      };
    };
  };
}
