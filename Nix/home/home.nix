{ config, pkgs, ... }:

{ 
  home.username = "ageha";
  home.homeDirectory = "/home/ageha";
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };
  home.packages = with pkgs;[
  ];
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
