{ config, pkgs, lib, ... }:

let
  fromGitHub = ref: repo: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
in
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
        pkgs.nix pkgs.heroku
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
            plugins = [ "git" ];
            theme = "robbyrussell";
        };

    };

    # Configure neovim
    programs.neovim =
    let
        toLua = str: "lua << EOF\n${str}\nEOF\n";
        toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
        enable = true;
        plugins = with pkgs.vimPlugins; [
            (fromGitHub "HEAD" "rebelot/kanagawa.nvim")
            packer-nvim
        ];
        extraLuaConfig = ''
            ${builtins.readFile ./nvim/init.lua}
        '';


    };
}
