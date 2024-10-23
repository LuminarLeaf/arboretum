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
      intel-media-driver # intel vaapi
      # vpl-gpu-rt         # intel qsv # currently only on unstable
      intel-media-sdk # qsv
    ];
  };
}
