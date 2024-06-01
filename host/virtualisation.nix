{ config, pkgs, mainConfig, ... }:
{
    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
    };
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    services.spice-vdagentd.enable = true;
}