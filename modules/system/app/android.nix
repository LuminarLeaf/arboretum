{
  pkgs,
  userSettings,
  ...
}: let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    repoJson = ./repo.json;
    # numLatestPlatformVersions = 2;
    platformVersions = ["36.1" "37"];
    buildToolsVersions = ["36.0.0" "36.1.0" "37.0.0"];
    includeEmulator = "if-supported";
    includeSystemImages = "if-supported";
    includeSources = true;
    useGoogleAPIs = true;
    systemImageTypes = ["google_apis"];
    abiVersions = ["x86_64" "arm64-v8a"];
    includeNDK = "if-supported";
  };
in {
  config = {
    nixpkgs.config.android_sdk.accept_license = true;

    environment.systemPackages = [
      pkgs.android-tools

      (pkgs.androidStudioPackages.stable.withSdk androidComposition.androidsdk)
    ];
    users.users.${userSettings.username} = {extraGroups = ["adbusers" "kvm"];};
  };
}
