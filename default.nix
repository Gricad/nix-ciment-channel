{ pkgs ? import ./nixpkgs {} }:

let
  inherit (pkgs.lib) callPackageWith;
  inherit (pkgs.lib) callPackagesWith;
  inherit (pkgs) pythonPackages;
  inherit (pkgs) perlPackages;
  inherit (pkgs) buildPerlPackage;
  callPackage = callPackageWith (pkgs // self.ciment);
  callPackage_i686 = callPackageWith (pkgs.pkgsi686Linux // self.ciment);
  callPackages = callPackagesWith (pkgs // self.ciment);

  self.ciment = rec {

  # Hello
    hello = callPackage ./ciment/hello { };

    # Casa
    # Versions 4.7.2 and 5.1.1 are kept for backward
    # compatibility issues.
    casa-472 = callPackage ./ciment/casa/4.7.2.nix { };
    casa-511 = callPackage ./ciment/casa/5.1.1.nix { };
    casa = callPackage ./ciment/casa/default.nix { };

    # Charliecloud
    charliecloud = callPackage ./ciment/charliecloud { };

    # Intel compiler
    intel-compilers-2016 = callPackage ./ciment/intel/2016.nix { };
    intel-compilers-2017 = callPackage ./ciment/intel/2017.nix { };
    intel-compilers-2018 = callPackage ./ciment/intel/2018.nix { };

    # Gildas
    gildas = callPackage ./ciment/gildas { };

    # Openmpi
    openmpi = callPackage ./ciment/openmpi { };
    openmpi2 = callPackage ./ciment/openmpi/2.nix { };
    openmpi2-opa = callPackage ./ciment/openmpi/2.nix { enableFabric = true; };
    openmpi2-ib = callPackage ./ciment/openmpi/2.nix { enableIbverbs = true; };
    openmpi3 = callPackage ./ciment/openmpi/3.nix { };
    psm2 = callPackage ./ciment/psm2 { };
    libfabric = callPackage ./ciment/libfabric { };

    # Petsc
    petscComplex = callPackage ./ciment/petsc { scalarType = "complex"; };
    petscReal = callPackage ./ciment/petsc { scalarType = "real"; };
    petsc = petscComplex;

    # udocker
    udocker = pythonPackages.callPackage ./ciment/udocker { };

    # Arpack-ng
    arpackNG = callPackage ./ciment/arpack-ng { };

    # GMT
    gshhg-gmt = callPackage ./ciment/gmt/gshhg-gmt.nix { };
    dcw-gmt   = callPackage ./ciment/gmt/dcw-gmt.nix { };
    gmt = callPackage ./ciment/gmt { };

    # ParMETIS
    parmetis = callPackage ./ciment/parmetis { };

    # Trilinos
    trilinos =  callPackage ./ciment/trilinos { };

    # Szip
    szip =  callPackage ./ciment/szip { };

    # Mpi-ping example
    mpi-ping = callPackage ./ciment/mpi-ping { };

    # Singularity
    singularity = callPackage ./ciment/singularity { };

    # PLPlot
    plplot = callPackage ./ciment/plplot { };

    # Hoppet
    hoppet = callPackage ./ciment/hoppet { };

    # applgrid
    applgrid = callPackage ./ciment/applgrid { };

    # LHApdf 5.9
    lhapdf59 = callPackage ./ciment/lhapdf59 { };

    # Bagel
    bagel = callPackage ./ciment/bagel { };

    # stacks
    stacks = callPackages ./ciment/stacks { };

    # messer-slim
    messer-slim = callPackages ./ciment/messer-slim { };

    # Fate
    fate = callPackages ./ciment/fate { };

    # Migrate
    migrate = callPackages ./ciment/migrate { };

    # GDL
    gdl = callPackages ./ciment/gdl { };

    # CSA
    csa = callPackages ./ciment/csa { };

    # FFTW
    fftw3 = callPackages ./ciment/fftw { };

    # Zonation
    zonation-core = callPackages ./ciment/zonation-core { };
};
in pkgs // self
