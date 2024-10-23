{pkgs, ...}: {
  # Enable hardware acceleration
  # hardware.graphics # on unstable
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      # nvidia-vaapi-driver
      # vaapiVdpau
      # libvdpau-va-gl
      # mesa
      # egl-wayland
      intel-media-driver
    ];
  };
}
