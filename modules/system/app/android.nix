{
  pkgs,
  userSettings,
  ...
}: {
  config = {
    nixpkgs.config.android_sdk.accept_license = true;

    environment.systemPackages = [
      pkgs.android-tools

      (pkgs.androidStudioPackages.beta.withSdk
        (pkgs.androidenv.composeAndroidPackages {
          repoJson = ./repo.json;
          numLatestPlatformVersions = 2;
          includeEmulator = "if-supported";
          includeSystemImages = "if-supported";
          includeSources = true;
          useGoogleAPIs = true;
          systemImageTypes = ["google_apis"];
          abiVersions = ["x86_64" "arm64-v8a"];
          includeNDK = "if-supported";
        }).androidsdk)
    ];
    users.users.${userSettings.username} = {extraGroups = ["adbusers" "kvm"];};
  };
}
