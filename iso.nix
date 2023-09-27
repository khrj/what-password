{ config, pkgs, lib, options, ... }:

{
	imports = [
		<nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-base.nix>
		<nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
	];

	# Debug builds only
	isoImage.squashfsCompression = "lz4";

	# Whitelist wheel users to do anything
	security.polkit.extraConfig = ''
		polkit.addRule(function(action, subject) {
			if (subject.isInGroup("wheel")) {
				return polkit.Result.YES;
			}
		});
	'';

	networking.networkmanager.enable = true;
	networking.wireless.enable = lib.mkImageMediaOverride false;

	services.xserver = {
		enable = true;
		desktopManager.lxqt.enable = true;
		displayManager = {
			sddm.enable = true;
			autoLogin = {
				enable = true;
				user = "nixos";
			};
		};
	};

	environment.defaultPackages = with pkgs; [
		nano
		git
		firefox
		lxqt.qterminal

		gparted
		ntfs3g

		chntpw
	];

	system.activationScripts.installerDesktop = let
		homeDir = "/home/nixos/";
		desktopDir = homeDir + "Desktop/";

	in ''
		mkdir -p ${desktopDir}
		chown nixos ${homeDir} ${desktopDir}

		ln -sfT ${pkgs.gparted}/share/applications/gparted.desktop ${desktopDir + "gparted.desktop"}
	'';	
}
