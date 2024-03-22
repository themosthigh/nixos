# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./dev-env.nix
      
      # Home manager
      # <home-manager/nixos>
    ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.supportedFilesystems = [ "ntfs" ];


  # custom file_system mount points

  fileSystems."perm" = {
    device = "/dev/nvme0n1p2";
    fsType = "auto";
    mountPoint = "/perm";
  };

  fileSystems."archie" = {
    device = "/dev/nvme0n1p3";
    fsType = "auto";
    mountPoint = "/archie";
  };

  fileSystems."marley" = {
    device = "/dev/sda5";
    fsType = "auto";
    mountPoint = "/marley";
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Nairobi";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Pinyin input
  i18n.inputMethod.enabled = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [libpinyin];
  

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
	
  # Enable Flatpak
  services.flatpak.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;i

  # bluetooth  
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  
  # default shell
  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.n00b = {
    isNormalUser = true;
    description = "n00b";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      # cypress
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # garabage collection
  nix.gc.automatic = true;
  nix.gc.dates = "6:00";
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
  
    # system packages
    pkgs.wget
    pkgs.flatpak
    pkgs.home-manager
    pkgs.coreutils-full
    pkgs.ntfs3g
    pkgs.wl-clipboard

    # desktop
    pkgs.gnome.gnome-tweaks
    pkgs.papirus-icon-theme
    pkgs.papirus-folders
    pkgs.volantes-cursors

    # fonts
    pkgs.nerdfonts
    pkgs.monaspace
    pkgs.noto-fonts
    pkgs.noto-fonts-emoji
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif

    # terminals and TUIs
    pkgs.btop
    pkgs.bat
    pkgs.stow
    pkgs.starship
    pkgs.tmux

    pkgs.gparted
    
    # text editors
    pkgs.neovim
    pkgs.helix

    # work, productivity etc
    pkgs.firefox
  ];

  nixpkgs.config.permittedInsecurePackages = [
    # "nodejs-16.20.2"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  # system.autoUpgrade.channel = "https://channels.nixos.org/nixos-23.11";
}
