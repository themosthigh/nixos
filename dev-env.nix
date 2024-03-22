# development packages

{ config,pkgs,  ... }:

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
			helix
			neovim
			lunarvim
			vimPlugins.codeium-vim

			gnumake
				
			# nix
			nil

			# lua
			lua-language-server
			stylua

			# c/cpp
			gcc
			
			# go
			go
			gopls
			golines
			gofumpt
			goimports-reviser
			gomodifytags

			# js/ts
	    nodejs_18
	    nodePackages.pnpm
			nodePackages.typescript-language-server
			nodePackages.svelte-language-server
			nodePackages.vue-language-server
			nodePackages.prettier
			prettierd
			emmet-ls
			eslint_d

			# rust
			rustup
			rust-analyzer

			# dart/flutter
			dart
			flutter

			# java
			jdk11	
		];
	};
}
