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

    ../../modules/system/hardware/razer.nix

    ../../modules/system/wm/gnome.nix

    (import ../../modules/system/app/docker.nix {
      storageDriver = null;
      inherit pkgs lib config userSettings;
    })
    ../../modules/system/app/mullvad.nix
    ../../modules/system/app/flatpak.nix
    ../../modules/system/app/virtualization.nix

    ../../modules/system/security/firewall.nix
    ../../modules/system/security/gpg.nix

    # TODO: WIP
    ../../modules/system/app/gaming.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.settings.trusted-users = ["@wheel"];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  # Bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.copyKernels = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.catppuccin.enable = true;

  networking.hostName = "maple";
  networking.networkmanager.enable = true;

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

      brave
      firefox
    ])
    ++ [
      inputs.alejandra.defaultPackage.${pkgs.system}
    ];

  environment.shells = with pkgs; [bash zsh fish];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  system.userActivationScripts.zshrc = "touch .zshrc"; # disables the zsh initial "popup"

  programs.neovim.enable = true;
  programs.nh.enable = true;

  fonts.fontDir.enable = true;

  # handeled by gnome
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal
  #     pkgs.xdg-desktop-portal-gtk
  #   ];
  # };
  # xdg.terminal-exec.enable = true;
  # xdg.terminal-exec.settings.default = ["kitty.desktop"];

  custom.hardware.nvidia.enablePrime = true;

  specialisation = {
    on-the-go.configuration = {
      custom.hardware.nvidia.disableNvidia = true;
      custom.docker.powerSave = true;
      custom.qemu = false;
      custom.virt-manager = false;
      custom.waydroid = false;

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
