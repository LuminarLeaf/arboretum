{...}: {
  imports = [
    ./bat.nix
    ./eza.nix
    ./fd.nix
    ./fzf.nix
    ./glow.nix
    ./omp.nix
    ./ripgrep.nix
    ./superfile.nix
    # ./tmux.nix # i am sick of using this like this, will write a custom flake when i have time
    ./yazi.nix
    ./zoxide.nix
  ];
}
