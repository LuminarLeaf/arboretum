{
  stdenv,
  tmuxPlugins,
  replaceVars,
  fetchFromGitHub,
  lib,
  ...
}: let
  mighty-scroll = stdenv.mkDerivation (finalAttrs: {
    pname = "tmux-mighty-scroll";
    version = "unstable-2025-04-15";

    src = fetchFromGitHub {
      owner = "noscript";
      repo = "tmux-mighty-scroll";
      rev = "fa5db0718e9e9f7278520ecf63b96b84b0cc57d6";
      hash = "sha256-F62qF3rGhvSIP5MKamTZHswt8rvuBspRCi2iDjcZuTI=";
    };

    buildPhase = ''
      mkdir -p $out/bin

      cc -Wall -Wextra -Werror -Wconversion -pedantic -std=c99 -O3 $src/pscheck.c -o $out/bin/pscheck
    '';

    meta = {
      description = "More scroll, less hassle";
      homepage = "https://github.com/noscript/tmux-mighty-scroll";
      license = lib.licenses.mit;
    };
  });
in
  tmuxPlugins.mkTmuxPlugin {
    inherit
      (mighty-scroll)
      version
      src
      meta
      ;

    pluginName = mighty-scroll.src.repo;
    rtpFilePath = "mighty-scroll.tmux";

    patches = [
      (replaceVars ./fix-binary.patch {
        tmuxMightyScrollDir = "${mighty-scroll}/bin";
      })
    ];
  }
