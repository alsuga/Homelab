{
  disko.devices = {
    disk = {
      os_nvme_disk = {
        device = "/dev/disk/by-id/nvme-TEAM_TM8FP6512G_TPBF2303170040302557";
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
                mountOptions = ["fmask=0077" "dmask=0077"];
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
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/@home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd"];
                  };
                  "/@nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/@snapshots" = {
                    mountpoint = "/snapshots";
                  };
                };
              };
            };
          };
        };
      };

      media_disk = {
        device = "/dev/disk/by-id/ata-ST8000DM004-2U9188_ZR1690E5";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            media_storage = {
              name = "MEDIA_STORAGE";
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                mountpoint = "/srv/storage";
                mountOptions = [
                  "compress=zstd:1"
                  "space_cache=v2"
                  "relatime"
                  "user_xattr"
                  "acl"
                ];
                subvolumes = {
                  "/@k3s-volumes" = {
                    mountpoint = "/srv/storage/volumes";
                    mountOptions = ["compress=zstd:1" "noatime"];
                  };
                  "/@backups" = {
                    mountpoint = "/srv/media/backups";
                    mountOptions = ["compress=zstd:3"];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
