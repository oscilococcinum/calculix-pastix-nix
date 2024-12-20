{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }@inputs: {
    packages = builtins.listToAttrs (map (system: 
      {
        name = system;
        value = with import nixpkgs { inherit system; config.allowUnfree = true;}; rec {
          
          calculix = pkgs.callPackage (import ./calculix) { };
          calculix-pastix = pkgs.callPackage (import ./calculix/calculix-pastix.nix) { };
        };
      }
    )[ "x86_64-linux" "aarch64-linux" ]);
  };
}