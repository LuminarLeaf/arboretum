{...}: {
  programs.fd.enable = true;
  programs.fd.ignores = [
    ".git"
    ".vscode"
    ".idea"
    "node_modules"
    "target"
    "dist"
    "build"
    "vendor"
    "deps"
    "cache"
    "tmp"
    "temp"
  ];
}
