{
  description = "Packaging Flake for leaf-markdown-viewer";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
  };

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.rustPlatform.buildRustPackage {
            pname = "leaf-markdown-viewer";
            version = "1.28.2";

            src = ./.;

            cargoLock = {
              lockFile = ./Cargo.lock;
            };

            meta = with pkgs.lib; {
              description = "Terminal Markdown previewer with a GUI-like experience";
              homepage = "https://leaf.rivolink.mg";
              license = licenses.mit;
              maintainers = [ ];
              mainProgram = "leaf";
            };
          };
        }
      );
    };
}
