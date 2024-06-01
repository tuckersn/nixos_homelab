#!/bin/bash
sudo cp ./configuration.nix /etc/nixos/configuration.nix
sudo cp ./config.toml /etc/nixos/config.toml
sudo cp ./config_security.toml /etc/nixos/config_security.toml
if [[ ! -e /etc/nixos/host ]]; then
    sudo mkdir /etc/nixos/host
fi
sudo cp -r ./host/* /etc/nixos/host
sudo nixos-rebuild switch --show-trace
