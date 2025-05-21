{
  lib,
  stdenvNoCC,
  base16-schemes,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "base24-schemes";
  version = "${base16-schemes.version}";

  src = base16-schemes.src;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/themes/
    install base24/*.yaml $out/share/themes

    runHook postInstall
  '';

  meta = {
    description = "All the color schemes for use in base24 packages";
    homepage = finalAttrs.src.meta.homepage;
    license = lib.licenses.mit;
  };
})
