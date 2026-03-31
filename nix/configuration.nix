# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  # Bootloader settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Localization and Time
  time.timeZone = "America/Araguaina";
  i18n.defaultLocale = "pt_BR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Graphics and Desktop Environment (Budgie)
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.budgie.enable = true;
    xkb = {
      layout = "br";
      variant = "";
    };
  };

  # Keyboard layout for the console (TTY)
  console.keyMap = "br-abnt2";

  # Sound and Printing
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Package and User Management
  nixpkgs.config.allowUnfree = true;
  
  users.users.jivago = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Jivago";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # Specific user packages can go here or in home.nix
    ];
  };

  # Home Manager Configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.jivago = {
      imports = [ ./home.nix ];
      # This allows unfree for home-manager specifically
      nixpkgs.config.allowUnfree = true;
    };
  };

  # Shell and Global Programs
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
    };
  };

  programs.firefox.enable = true;
  # System-wide packages
  environment.systemPackages = with pkgs; [
    	vim
    	wget
    	git
    	alacritty
    	gh
	maven
  ];

  # Fonts (Required for the 'agnoster' Zsh theme)
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.sauce-code-pro
  ];

  # This value determines the NixOS release version. 
  # Note: 25.11 suggests you are tracking the unstable branch.
  system.stateVersion = "25.11"; 
}
