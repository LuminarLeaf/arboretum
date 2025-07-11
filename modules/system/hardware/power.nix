{pkgs, ...}: {
  services.power-profiles-daemon.enable = false;

  environment.systemPackages = [
    pkgs.powertop
  ];

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services.system76-scheduler.settings.cfsProfiles.enable = true;
  services.thermald.enable = true;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      START_CHARGE_THRESH_BAT0 = 55;
      STOP_CHARGE_THRESH_BAT0 = 60;

      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth";
      DEVICES_TO_ENABLE_ON_AC = "wifi bluetooth";
    };
  };
}
