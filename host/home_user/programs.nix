{ config, lib, pkgs, ... }:
{
    programs.neovim.enable = true;
    programs.git = {
        userName = "Tucker";
        userEmail = "public.tuckersn@gmail.com";
    };
}