{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    qemu
    quickemu

    # run qemu with uefi
    (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
      qemu-system-x86_64 \
        -bios $(pkgs.OVMF.fd)/FV/OVMF.fd \
        "$@"
    '')
  ];

  virtualisation.libvirtd.qemu = {
    runAsRoot = false;
  };

  programs.virt-manager.enable = true;
}
