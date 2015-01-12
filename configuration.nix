# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "dain"; # Define your hostname.
  networking.hostId = "36483d55";
  networking.wireless.enable = true;  # Enables wireless.
  networking.wicd.enable = false;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    # editors
    emacs24-nox
    vim

    # misc
    gitAndTools.gitFull

    wget
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  # List services that you want to enable:

  programs.zsh.enable = true;

  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    synaptics = {
      enable = true;
    };
    videoDrivers = [ "nvidia" "nouveau" "vesa" "modesetting" ];

    displayManager.kdm.enable = true;
    desktopManager = {
      e19.enable = false;
      kde4.enable = true;
      xfce.enable = true;
    };
      

  };
  # services.xserver.xkbOptions = "eurosign:e";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.badi= {
    createHome = true;
    home = "/home/badi";
    group = "users";
    extraGroups = [ "wheel" ];
    shell = "/run/current-system/sw/bin/zsh";
  };

  time.timeZone = "America/New_York";

}
