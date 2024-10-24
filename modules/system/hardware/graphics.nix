{pkgs, ...}: {
  # Enable hardware acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # nvidia-vaapi-driver
      # vaapiVdpau
      # libvdpau-va-gl
      # mesa
      # egl-wayland
      intel-media-driver # intel vaapi
      vpl-gpu-rt # intel qsv
    ];
  };
}
