{ pkgs ? import ./nixpkgs {} }:

let
  inherit (pkgs.lib) callPackageWith;
  inherit (pkgs.lib) callPackagesWith;
  callPackage = callPackageWith (pkgs // self.ciment);
  callPackage_i686 = callPackageWith (pkgs.pkgsi686Linux // self.ciment);
  callPackages = callPackagesWith (pkgs // self.ciment);

  self.ciment = rec {

    # Hello
    hello = callPackage ./ciment/hello { };

    # Casa
    casa = callPackage ./ciment/casa/4.7.2.nix { };

    # Charliecloud
    charliecloud = callPackage ./ciment/charliecloud { };

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

    # Petsc
    petscComplex = callPackage ./ciment/petsc { scalarType = "complex"; };
    petscReal = callPackage ./ciment/petsc { scalarType = "real"; };
    petsc = petscComplex;

    # Arpack-ng
    arpackNG = callPackage ./ciment/arpack-ng { };  

};
in pkgs // self
