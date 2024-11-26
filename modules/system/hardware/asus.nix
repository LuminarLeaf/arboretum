{
  lib,
  config,
  ...
}: {
  options = {
    custom.hardware.supergfxd = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable asus-linux's supergfxd";
    };
  };
  config = lib.mkMerge [
    (lib.mkIf config.custom.hardware.supergfxd {services.supergfxd.enable = true;})
    {
      services.asusd = {
        enable = true;
        enableUserService = true;
      };
    }
  ];
}
