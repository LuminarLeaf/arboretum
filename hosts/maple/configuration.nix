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

    # ../../modules/system/wm/plasma.nix
    ../../modules/system/wm/gnome.nix

    (import ../../modules/system/app/docker.nix {
      storageDriver = null;
      inherit pkgs lib config userSettings;
    })
    ../../modules/system/app/flatpak.nix
    ../../modules/system/app/gaming.nix
    # ../../modules/system/app/mullvad.nix
    ../../modules/system/app/virtualization.nix

    ../../modules/system/security/firewall.nix
    ../../modules/system/security/gpg.nix
  ];

  nix = {
    channel.enable = false;

    registry = lib.mapAttrs (_: flake: {inherit flake;}) inputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      flake-registry = "";
      nix-path = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs;
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [userSettings.username];
    };
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
    # kernelPackages = pkgs.linuxPackages_zen;
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

  environment.systemPackages = with pkgs; [
    age
    alejandra
    curl
    dnsutils
    ffmpeg-full
    file
    git
    nixd
    pv
    rsync
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
  ];

  environment.shells = with pkgs; [bash zsh];
  system.userActivationScripts.zshrc = "touch .zshrc"; # disables the zsh initial "popup"

  programs = {
    zsh.enable = true;
    # fish.enable = true;
    neovim.enable = true;
    vim.enable = true;
    nh = {
      enable = true;
      flake = "/etc/nixos";
    };
    firefox.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    localsend = {
      enable = true;
      openFirewall = true;
    };
  };

  services.gvfs.enable = true;
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [hplipWithPlugin];
  systemd.services."NetworkManager-wait-online".enable = false;

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

      boot.kernelPackages = lib.mkForce pkgs.linuxPackages;
      services = {
        printing.enable = lib.mkForce false;
        gvfs.enable = lib.mkForce false;
        openssh.enable = lib.mkForce false;
      };
      hardware.openrazer.enable = lib.mkForce false;
      virtualisation.libvirtd.enable = lib.mkForce false;
      programs.gnupg.agent.enable = lib.mkForce false;

      # suspend to RAM(deep)
      boot.kernelParams = ["mem_sleep_default=deep"];
      # suspend then hibernate
      systemd.sleep.extraConfig = ''
        HibernateDelaySec=30m
        SuspendState=mem
      '';
    };
    # vfio.configuration = {
    #   system.nixos.tags = ["with-vfio"];
    #
    #   custom.hardware.nvidia.enable = false;
    #   custom.hardware.nvidia.pci_passthrough = true;
    #   custom.hardware.supergfxd = false;
    #   custom.docker.powerSave = true;
    #
    #   systemd.tmpfiles.rules = ["f /dev/shm/looking-glass 0660 ${userSettings.username} qemu-libvirtd -"];
    #   environment.systemPackages = [pkgs.looking-glass-client];
    # };
  };

  system.stateVersion = "24.05";
}
