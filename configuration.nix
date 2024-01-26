
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  # GPU
  hardware.opengl.enable = true;
  
  #NixOS
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  #XDG portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk ];
 
  # Hyprland
  programs.hyprland = {
  enable = true;
  xwayland.enable = true;
}; 
  
  #Network 
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  #Environment 
  environment.sessionVariables = {
  NIXOS_OZONE_WL = "1";
};

  # Set your time zone.
  time.timeZone = "America/Indiana/Indianapolis";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wolfgang = {
    isNormalUser = true;
    description = "Wolfgang";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # pipewire
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;
};

  #SysPackages
  environment.systemPackages = with pkgs; [
    wget
    neofetch
    hyprland
    pipewire
    pipes
    anki
    cmatrix
    emacs
    dunst
    libnotify
    swww
    rofi-wayland
    kitty
    pcmanfm
    git
  ];

  # Nixos Version
  system.stateVersion = "23.11";

}
