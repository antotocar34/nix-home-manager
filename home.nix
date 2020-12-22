{ config, pkgs, ... }:

let
# Personal Info
user = "carnec" ;
home = "/home/${user}" ;
name = "Antoine Carnec" ;
email = "antoinecarnec@gmail.com" ;
# Paths
dotconfig = "./extraConfigs/.config" ;
# try this one if the other one does not work.
# config = ./extraConfigs/.config ;


{
	programs.home-manager.enable = true;

	home.username = "carnec";
	home.homeDirectory = "/home/carnec";

# This value determines the Home Manager release that your
# configuration is compatible with. This helps avoid breakage
# when a new Home Manager release introduces backwards
# incompatible changes.
#
# You can update Home Manager without changing this value. See
# the Home Manager release notes for a list of state version
# changes in each release.
	home.stateVersion = "21.03";

	home.sessionVariables = {
		EDITOR = "vim" ;
		FZF_DEFAULT_COMMAND=''
			ag --hidden --ignore .stack --ignore .cabal --ignore .cache --ignore .git --ignore .vim --ignore .local -l -g ""
			'' ;

	} ;

	home.packages = with pkgs;  [
		ripgrep
			anki
			fzf
			jupyter
			python38
			python38Packages.ipython
			python38Packages.virtualenv
			python38Packages.pip
			pipenv

			nodejs # Needed by coc-nvim

			ghc
			haskellPackages.haskell-language-server

			bitwarden
			bitwarden-cli

			xclip
			flameshot

            texlive.combined.scheme-full
			zathura
			xdotool

			youtube-dl
			exa
			psmisc # pstree and the like

			fd
			discord
			feh 
			vlc
			libreoffice
			];

	programs.alacritty = {
		enable = true ;
# settings = builtins.readFile ./extraConfigs/alacritty.yml ;
	} ; 

    # programs.neovim = {
    #   enable = true ;
    #   # TODO get vim-plug working
    #   plugins = with pkgs.vimPlugins ; 
    #   [
    #     vimtex
    #     vim-surround
    #     ultisnips
    #     vim-commentary
    #     vim-nix
    #     nord-vim
    #     fzf-vim
    #     nerdtree
    #     haskell-vim
    #     coc-nvim
    #   ];

    #     extraConfig = builtins.readFile extraConfigs/.vimrc ;
    #     vimAlias = true ; 
    #     viAlias = true ; 
    #   } ;

    programs.vim = {
      enable = true ;
      # TODO get vim-plug working
      plugins = with pkgs.vimPlugins ; 
      [
        vimtex
        vim-surround
        ultisnips
        vim-commentary
        vim-nix
        nord-vim
        fzf-vim
        nerdtree
        haskell-vim
        coc-nvim
      ];

      extraConfig = builtins.readFile extraConfigs/.vimrc ;
    } ;



	programs.git = {
		enable = true;

		aliases = {
			lg = ''log --graph --abbrev-commit --decorate --date=short -10 --format=format:"'%C(bold blue)%h%C(reset) %C(bold yellow)%d%C(reset) %C(white)%s%C(reset) %C(green)(%ad)%C(reset) %C(dim white)- %an%C(reset)'"'' ;
			te = ''log --all --graph --decorate=short --color --date=short --format=format:"'%C(bold blue)%h%C(reset) %C(bold yellow)%d%C(reset)\n         %C(green)(%ad)%C(reset)  %x09%C(white)%an: %s %C(reset)'"'' ;
			st = "status --short" ;
			wdiff = "diff --word-diff=color" ;
			unstage = "reset HEAD --";
		} ;
		userName = "${name}" ;
		userEmail = "${email}" ;
	} ;

	programs =  {
		bash = {
			enable = true ; 
			# profileExtra = builtins.readFile ./extraConfigs/.bash_profile
				# + builtins.readFile ./extraConfigs/.profile ;

			initExtra   = builtins.readFile ./extraConfigs/.bashrc ; 
		};  
		ssh = {
			enable = true ;
			matchBlocks =
			{
				"acer" = {
					user = "carnec" ;
					host = "192.168.1.8" ; 
				} ;
			};
		} ;

		rofi = {
			enable = true ;
			configPath = "./extraConfigs/rofi/config.rasi"; 
		};
		tmux = {
			enable = true;
			baseIndex = 1; 
			escapeTime = 1;
			keyMode = "vi";
			newSession = true;
			shortcut = "k" ;
			extraConfig = builtins.readFile ./extraConfigs/.tmux.conf ;
		} ;

		chromium = {
			enable = true ;
			extensions = 
				[
				"blaaajhemilngeeffpbfkdjjoefldkok" # LeechBlock
			    "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
			    "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
			    "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock
				"icpgjfneehieebagbmdbhnlpiopdcmna" # New tab
				"edacconmaakjimmfgnblocblbcdcpbko" # Session Buddy
				] ;
		};
	};
	# services.sxhkd = 
	# {
	# 	enable = false ;
	# 	extraPath = "/home/${user}/Documents/Scripts" ;
	# 	extraConfig = builtins.readFile ./extraConfigs/sxhkdrc ;
	# };
	xdg = {
      # cacheHome = ~/.cache ;
      # configHome = ~/.config ;
      # dataHome = ~/.local/share ;
      configFile = {"alacritty/alacritty.yml".source = ${dotconfig}/alacritty/alacritty.yml; 
                    "rofi/config.rasi".source = ${dotconfig}/rofi/config.rasi ;
                    "rofi/nord.rasi".source = ${dotconfig}/rofi/nord.rasi ;
                    "nvim/coc-settings.json".source = extraConfigs/.vim/coc-settings.json ;
                    "sxhkd/sxhkdrc".source = ${dotconfig}/sxhkd/sxhkdrc ;
          };
	};
}
