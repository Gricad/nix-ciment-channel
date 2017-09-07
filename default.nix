{ pkgs ? import ./nixpkgs {} }:

let
  inherit (pkgs.lib) callPackageWith;
  inherit (pkgs.lib) callPackagesWith;
  callPackage = callPackageWith (pkgs // self.ciment);
  callPackage_i686 = callPackageWith (pkgs.pkgsi686Linux // self.ciment);
  callPackages = callPackagesWith (pkgs // self.ciment);

  self.ciment = {

    # Hello
    hello = callPackage ./ciment/hello { };

    # Intel compiler
    intel-compilers-2016 = callPackage ./ciment/intel/2016.nix { };
    intel-compilers-2017 = callPackage ./ciment/intel/2017.nix { };

    # Gildas
    gildas = callPackage ./ciment/gildas { };

    # Openmpi
    openmpi = callPackage ./ciment/openmpi { };
    openmpi2 = callPackage ./ciment/openmpi/2.nix { };

    # Singularity
    singularity = callPackage ./ciment/singularity { };  

  };
in pkgs // self
