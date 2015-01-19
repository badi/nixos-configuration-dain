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
  networking.networkmanager.enable = true;

  # rename interfaces to en0 wl0 (from enp2s0 wlp3s0)
  services.udev.extraRules = ''
    SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="10:9a:dd:4c:24:97", NAME="en0"
    SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="c8:bc:c8:ec:d1:94", NAME="wl0"
  '';


  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    # system tools
    file
    which
    lsof
    iotop

    # editors
    emacs24-nox
    vim

    # web
    chromium
    firefox

    # audio
    kde4.kmix # doesn't automaticaly get installed for kde

    # misc
    gitAndTools.gitFull

    networkmanagerapplet

    wget
  ];

  nixpkgs.config = {
    allowUnfree = true;
    chromium = {
      enableGoogleTalkPlugin = true;
      enablePepperFlash = true;
      enablePepperPDF = true;
    };
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
      accelFactor = "0.01";
      palmDetect = true;
      twoFingerScroll = true;
      buttonsMap = [ 1 3 2 ];
      fingersMap = [ 1 3 2 ];
    };
    videoDrivers = [ "nvidia" "nouveau" "vesa" "modesetting" ];

    displayManager.kdm.enable = true;
    desktopManager = {
      kde4.enable = true;
    };
      

  };
  # services.xserver.xkbOptions = "eurosign:e";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.badi= {
    createHome = true;
    home = "/home/badi";
    group = "users";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = "/run/current-system/sw/bin/zsh";
  };

  time.timeZone = "America/New_York";

}
