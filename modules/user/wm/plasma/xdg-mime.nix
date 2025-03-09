{
  pkgs,
  lib,
  ...
}: let
  defaultApps = {
    browser = ["firefox.desktop"];
    # browser = ["librewolf.desktop"];
    text = ["org.kde.kate.desktop"];
    image = ["org.kde.gwenview.desktop"];
    audio = ["org.kde.elisa.desktop"];
    video = ["org.kde.haruna.desktop"];
    directory = ["org.kde.dolphin.desktop"];
    office = ["libreoffice.desktop"];
    pdf = ["org.kde.okular.desktop"];
    terminal = ["com.mitchellh.ghostty.desktop"];
    archive = ["org.kde.ark.desktop"];
    discord = ["vesktop.desktop"];
  };

  mimeMap = {
    text = ["text/plain"];
    image = [
      "image/bmp"
      "image/gif"
      "image/jpeg"
      "image/jpg"
      "image/png"
      "image/svg+xml"
      "image/tiff"
      "image/vnd.microsoft.icon"
      "image/webp"
    ];
    audio = [
      "audio/aac"
      "audio/mpeg"
      "audio/ogg"
      "audio/opus"
      "audio/wav"
      "audio/flac"
      "audio/webm"
      "audio/x-matroska"
    ];
    video = [
      "video/mp2t"
      "video/mp4"
      "video/mpeg"
      "video/ogg"
      "video/webm"
      "video/x-flv"
      "video/x-matroska"
      "video/x-msvideo"
    ];
    directory = ["inode/directory"];
    browser = [
      "text/html"
      "x-scheme-handler/about"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/unknown"
    ];
    office = [
      "application/vnd.oasis.opendocument.text"
      "application/vnd.oasis.opendocument.spreadsheet"
      "application/vnd.oasis.opendocument.presentation"
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
      "application/msword"
      "application/vnd.ms-excel"
      "application/vnd.ms-powerpoint"
      "application/rtf"
    ];
    pdf = ["application/pdf"];
    terminal = ["terminal"];
    archive = [
      "application/zip"
      "application/rar"
      "application/7z"
      "application/*tar"
    ];
    discord = ["x-scheme-handler/discord"];
  };

  associations = with lib;
    listToAttrs (flatten (mapAttrsToList (key: map (type: attrsets.nameValuePair type defaultApps."${key}")) mimeMap));
in {
  xdg = {
    configFile."mimeapps.list".force = true;
    mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };

  home.sessionVariables = {
    # prevent wine from creating file associations
    WINEDLLOVERRIDES = "winemenubuilder.exe=d";
  };
}
