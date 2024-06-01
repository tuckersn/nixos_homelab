{ secure_network, config, pkgs, mainConfig, ... }:

{
    networking.networkmanager.enable = true;
    networking.hostName = "virt-platform";
    networking.defaultGateway = "192.168.1.1";
    networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

    networking.firewall = {
        enable = true;
        allowedTCPPorts = if secure_network then 
            [ 22 ]
        else 
            [];
        allowedUDPPorts = [ ];
    };
}