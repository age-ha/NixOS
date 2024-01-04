{
  description = "Home Manager configuration of ageha";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, spicetify-nix, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."ageha" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        # extraSpecialArgs = {inherit spicetify-nix;};
        modules = [ ./home.nix 
		    #./spicetify.nix
	];
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
