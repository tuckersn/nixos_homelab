{ config, pkgs, lib, mainConfig, ... }:

let
    gitConfig = import ./git.nix { inherit config lib pkgs; };
in {
    nixpkgs.config.allowUnfree = true;

    services.openssh.enable = true;

    environment.systemPackages = with pkgs; [
        wget
        go
        (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
            qemu-system-x86_64 \
            -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
            "$@"
        '')
    ];

    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/desktops/gnome/default.nix
    environment.gnome.excludePackages = (with pkgs; [
        gnome-photos
        gnome-tour
    ]) ++ (with pkgs.gnome; [
        cheese # webcam tool
        gedit # text editor
        epiphany # web browser
        geary # email reader
        evince # document viewer
        gnome-characters
        totem # video player
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        
        gnome-maps
        gnome-weather
        gnome-clocks
        gnome-contacts
        gnome-calculator
    ]);
    
    programs = {
        nix-ld.enable = true;

        tmux = {
            enable = true;
            clock24 = true;
            historyLimit = 10000;
        };

        htop = {
            enable = true;
            settings.show_cpu_temperature = 1;
        };

        git = {
            enable = true;
            lfs.enable = true;
            extraConfig = ''
                [init]
                defaultBranch = main
            '';
        };
    } // gitConfig.programs;
    
    environment.etc = {

    } // gitConfig.environment.etc;
}