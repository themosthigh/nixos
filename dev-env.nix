# development packages

{ config,pkgs,  ... }:
let
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in
{
	config = {
		environment.systemPackages = with pkgs; [
			# general tools 
			git
			gh
			lazygit
			ripgrep
      android-tools

			# editors
			unstable.helix
			neovim
			lunarvim

			gnumake
				
			# nix
			nil
		];
	};
}
