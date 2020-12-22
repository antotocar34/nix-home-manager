# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

  # let
  #   home-manager = builtins.fetchGit {
  #     url = "https://github.com/rycee/home-manager.git";
  #     rev = "e87bccabc318475ab712470657b85435354b53f7"; # CHANGEME 
  #     # ref = "No idea";
  #   };
  #   user = "antoine" ;

  # in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # (import "${home-manager}/nixos")
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "OldBoy"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Dublin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s29u1u1.useDHCP = true;
  networking.interfaces.enp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.  
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
     font = "latarcyrheb-sun32";
     keyMap = "uk";
   };

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  

# Configure keymap in X11
  services.xserver.layout = "gb";
  services.xserver.xkbOptions = "ctrl:swapcaps" ;



  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.antoine = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    wget 
    silver-searcher
    #chromium
    ripgrep
    fd
    # git
    vimHugeX
  ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts
    dina-font
    proggyfonts
    iosevka
  ];

# let
#   user = "antoine";
#   userHome = "/home/${user}";
#   hostName = "laptop";
# 
#   home-manager = { home-manager-path, config-path }:
#     assert builtins.typeOf home-manager-path == "string";
#     assert builtins.typeOf config-path == "string";
#     (
#       pkgs.callPackage
#         (/. + home-manager-path + "/home-manager") { path = "${home-manager-path}"; }
#     ).overrideAttrs (old: {
#       nativeBuildInputs = [ pkgs.makeWrapper ];
#       buildCommand =
#         let
#           home-mananger-bootstrap = pkgs.writeTextFile {
#             name = "home-manager-bootstrap.nix";
#             text = ''
#               { config, pkgs, ... }:
#               {
#                 # Home Manager needs a bit of information about you and the
#                 # paths it should manage.
#                 home.username = "${user}";
#                 home.homeDirectory = "${userHome}";
#                 home.sessionVariables.HOSTNAME = "${hostName}";
#                 imports = [ ${config-path} ];
#               }
#             '';
#           }; in
#         ''
#           ${old.buildCommand}
#           wrapProgram $out/bin/home-manager --set HOME_MANAGER_CONFIG "${home-mananger-bootstrap}"
#         '';
#     });
# in
# {
#   users.users.${user} = {
#     home = userHome;
#     packages = [
#       (home-manager {
#         home-manager-path = "${userHome}/.config/home-manager";
#         config-path = builtins.toString ../home-manager + "/${hostName}.nix";
#       })
#     ];
#   };
# }

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

  # home-manager.users.antoine = import ../../home/antoine/.config/home-git/nix-home-manager/home.nix  ;
  }

