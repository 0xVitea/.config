{ config, pkgs, lib, ... }:

{
    # Let home manager install and manage itself
    programs.home-manager.enable = true;
    home.stateVersion = "23.11";
	home.username = "vrusnac";
	home.homeDirectory = "/Users/vrusnac";

	# Install packages
	home.packages = [
        
        # Programming languages
        pkgs.go pkgs.nodejs_21 pkgs.rustup

        # Fonts
        pkgs.fira-mono

        # Utils
        pkgs.nix pkgs.heroku pkgs.ripgrep
	];

    # Configure vim
    programs.vim = {
        enable = true;
        settings = {
            tabstop = 4;
            shiftwidth = 4;
        };
  };

    # Configure git
    programs.git = {
        enable = true;
        userName = "vrusnac";
        userEmail = "victor.rusnac20@gmail.com";
        aliases = {
            s = "status";
        };
        extraConfig = {
            color = {
                ui = "auto";
            };
            core = {
                excludesfile = "~/.config/git/.gitignore_global";
            };
        };
    };

    # Configure zsh
    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        dotDir = ".config/zsh";

        zplug = {
            enable = true;
            plugins = [
                { name = "zsh-users/zsh-autosuggestions"; }
            ];
        };

        oh-my-zsh = {
            enable = true;
            plugins = [ "git" "rust" "golang" "tmux" ];
            theme = "robbyrussell";
        };

    };

    programs.tmux = {
        enable = true;
        plugins = with pkgs.tmuxPlugins; [
            vim-tmux-navigator
        ];
        extraConfig = ''
            # Terminal Colour
            set -ga terminal-overrides ",*256col*:Tc"

            # Set prefixes
            unbind C-b
            set -g prefix C-a
            bind C-a send-prefix
        '';
    };

    # Configure neovim
    programs.neovim =
    {
        enable = true;
        plugins = with pkgs.vimPlugins; [
            packer-nvim
        ];
        extraLuaConfig = "require('core')";

    };
}
