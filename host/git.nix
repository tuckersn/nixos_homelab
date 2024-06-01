{ config, lib, pkgs, ... }:

{
    programs.git = {
        enable = true;
        lfs.enable = true;
    };
    environment.etc."gitconfig".text = ''
        [init]
        defaultBranch = main
    '';
}