{ config, pkgs, lib, utils, modulesPath, stdenv, ... }:

let
	secure_network = true;
	
	pkgs = import (fetchTarball {
		url = "https://github.com/NixOS/nixpkgs/archive/2d5c155466bbe4c266a0a2f3416256ecde503bac.tar.gz";
		sha256 = "0r39mibz0f6jx8141f1y7lzm7x4fabrm6pqfgn55n45n3aafdfxz"; 
	}) {};

	mainConfig = builtins.fromTOML (builtins.readFile ./config.toml);
	securityConfig = builtins.fromTOML (builtins.readFile ./config_security.toml);

	hardwareConfig = import ./hardware-configuration.nix { inherit config lib pkgs modulesPath; };
	networkingConfig = import ./host/networking.nix { inherit config pkgs secure_network mainConfig; };
	virtualisationConfig = import ./host/virtualisation.nix { inherit config pkgs mainConfig; };
	homeManagerConfig = import <home-manager/nixos> { inherit config pkgs lib utils mainConfig; };
	programsConfig = import ./host/programs.nix { inherit config pkgs lib mainConfig; };
	homeUserConfig = import ./host/home_user/user.nix { inherit config pkgs lib stdenv mainConfig; };
in
{
	imports =
		[
			hardwareConfig
			homeManagerConfig
			virtualisationConfig
			programsConfig
			homeUserConfig
		];

	boot.loader.systemd-boot.enable = false;
	boot.loader.grub.enable = true;
	boot.loader.grub.efiSupport = true;
	boot.loader.grub.device = "nodev";
	boot.loader.grub.gfxmodeEfi = "1600x1200";
	boot.loader.grub.fontSize = 48;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
	boot.extraModprobeConfig = "options kvm_intel nested=1";
	virtualisation.libvirtd.enable = true;

	time.timeZone = mainConfig.System.time_zone;
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	networking = networkingConfig.networking;

	environment.pathsToLink = [ "/libexec" ];

	services.xserver = {
		enable = true;
		layout = "us";
		xkbVariant = "";
		desktopManager = {
			xterm.enable = false;
			gnome.enable = true;
		};
	
		displayManager = {
			gdm.enable = true;
			defaultSession = "gnome";
		};
	};

	services.fwupd.enable = true;

	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		# If you want to use JACK applications, uncomment this
		#jack.enable = true;
	};
	services.printing.enable = false;

    qt = {
		enable = true;
		platformTheme = "gnome";
		style = "adwaita-dark";
    };

	system.stateVersion = "23.11";
}
