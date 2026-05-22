{
  buildFHSEnv,
  fvs2,
  bottles,
}:
bottles.override (previous: {
  removeWarningPopup = true;
  bottles-unwrapped = previous.bottles-unwrapped.overrideAttrs (prev: {
    propagatedBuildInputs = builtins.filter (p: (p.name or "") != "fvs") prev.propagatedBuildInputs ++ [fvs2];
  });
  buildFHSEnv = args:
    buildFHSEnv (args
      // {
        multiPkgs = envPkgs: let
          originalPkgs = args.multiPkgs envPkgs;
          customLdap = envPkgs.openldap.overrideAttrs (_: {doCheck = false;});
        in
          builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [customLdap];
      });
})
