{ config, lib, stdenv, pkgs, mainConfig, ... }:

let
	firefoxConfig = import ./firefox.nix { inherit pkgs lib stdenv; };
	vscodeConfig = import ./vscode.nix { inherit pkgs; };
	programsConfig = import ./programs.nix { inherit pkgs config lib; };
in {
	users.users.tuck = {
		isNormalUser = true;
		description = "Tucker";
		extraGroups = [ 
				"networkmanager"
				"wheel"
				"docker"
				"libvirtd"
				"qemu-libvirtd"
		];
		packages = with pkgs; [
		];
	};

	home-manager.users.tuck = { pkgs, ... }: {
		dconf = {
			enable = true;
			settings = {
				"org/gnome/desktop/interface".color-scheme = "prefer-dark";
				"org/virt-manager/virt-manager/connections" = {
					autoconnect = ["qemu:///system"];
					uris = ["qemu:///system"];
				};
			};

		};

		gtk = {
			enable = true;
			theme = {
				name = "Adwaita-dark";
				package = pkgs.gnome.gnome-themes-extra;
			};
		};
			
		home.packages = with pkgs; [
		];

		programs = {
			bash.enable = true;
			home-manager.enable = true;
		} // vscodeConfig.programs // firefoxConfig.programs // programsConfig.programs;

		xsession = {

		};


		home.stateVersion = "23.11";
	};
}