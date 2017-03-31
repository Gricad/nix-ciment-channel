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

    # iRods
    inherit (callPackages ./ciment/irods rec {
              stdenv = pkgs.llvmPackages_38.libcxxStdenv;
              libcxx = pkgs.llvmPackages_38.libcxx;
              boost = pkgs.boost160.override { inherit stdenv; };
            })
            irods
            irods-icommands;

  };
in pkgs // self
