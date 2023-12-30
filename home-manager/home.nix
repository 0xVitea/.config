{ config, pkgs, ... }:

{
    # Let home manager install and manage itself
    programs.home-manager.enable = true;
    home.stateVersion = "23.11";
	home.username = "vrusnac";
	home.homeDirectory = "/Users/vrusnac";

	# Install packages
	home.packages = [
        # Fonts
        pkgs.fira-mono

        # Utils
        pkgs.nix
		pkgs.heroku
	];

    # Configure vim
    programs.vim = {
        enable = true;
        settings = {
            tabstop = 4;
            shiftwidth = 4;
        };
  };

    # Configure zsh
    programs.zsh = {
        enable = true;
    };

}
