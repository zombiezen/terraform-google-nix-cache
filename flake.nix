{
  description = "Development environment for terraform-google-nix-cache";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachSystem flake-utils.lib.defaultSystems (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages = {
        inherit (pkgs) google-cloud-sdk;

        terraform = pkgs.terraform_1.withPlugins (p: [
          p.google
        ]);
      };

      devShells.default = pkgs.mkShell {
        packages = [
          self.packages.${system}.google-cloud-sdk
          self.packages.${system}.terraform
        ];
      };
    });
}
