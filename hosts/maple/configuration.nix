{
  config,
  lib,
  pkgs,
  inputs,
  userSettings,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/system/hardware/bluetooth.nix
    ../../modules/system/hardware/graphics.nix
    ../../modules/system/hardware/nvidia.nix
    ../../modules/system/hardware/power.nix
    ../../modules/system/hardware/ssd.nix
    ../../modules/system/hardware/time.nix
    ../../modules/system/hardware/virtualization.nix
    ../../modules/system/hardware/asus.nix

    ../../modules/system/hardware/razer.nix

    ../../modules/system/wm/plasma.nix

    (import ../../modules/system/app/docker.nix {
      storageDriver = null;
      inherit pkgs lib config userSettings;
    })
    ../../modules/system/app/flatpak.nix
    ../../modules/system/app/gaming.nix
    ../../modules/system/app/mullvad.nix
    # ../../modules/system/app/qbittorrent.nix
    ../../modules/system/app/virtualization.nix

    ../../modules/system/security/firewall.nix
    ../../modules/system/security/gpg.nix
  ];

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["@wheel"];
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };

  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        extraEntries = ''
          menuentry "UEFI Firmware Settings" {
            fwsetup
          }
        '';
      };
    };
    kernelPackages = pkgs.linuxPackages_xanmod;
  };
  catppuccin.grub.enable = true;

  networking = {
    hostName = "maple";
    hostId = "007f0200";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
    LC_CTYPE = "en_US.UTF-8";
  };

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = ["wheel" "networkmanager"];
    packages = [];
    uid = 1000;
    shell = pkgs.zsh;
  };

  environment.systemPackages =
    (with pkgs; [
      age
      curl
      dnsutils
      duf
      ffmpeg-full
      file
      git
      hwinfo
      nixd
      pv
      rsync
      tldr
      tmux
      wget

      rar
      unar
      p7zip
      unzip
      xz
      # cryptsetup
      kitty
      mpv
      ghostty

      brave
      firefox
    ])
    ++ [
      inputs.alejandra.defaultPackage.${pkgs.system}
    ];

  environment.shells = with pkgs; [bash zsh fish];
  system.userActivationScripts.zshrc = "touch .zshrc"; # disables the zsh initial "popup"

  programs = {
    zsh.enable = true;
    fish.enable = true;
    neovim.enable = true;
    vim.enable = true;
    nh.enable = true;

    localsend = {
      enable = true;
      openFirewall = true;
    };
  };

  services.gvfs.enable = true;

  xdg.portal = {
    enable = true;
  };

  custom.hardware.nvidia.enablePrime = true;
  custom.waydroid = false;

  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = ["on-the-go"];

      custom = {
        hardware.nvidia.disableNvidia = true;
        hardware.supergfxd = false;
        docker.powerSave = true;
        qemu = false;
        virt-manager = false;
        waydroid = false;
      };

      # suspend to RAM(deep)
      boot.kernelParams = ["mem_sleep_default=deep"];
      # suspend then hibernate
      systemd.sleep.extraConfig = ''
        HibernateDelaySec=30m
        SuspendState=mem
      '';
    };
  };

  system.stateVersion = "24.05";
}
