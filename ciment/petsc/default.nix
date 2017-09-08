{ stdenv
, fetchurl
, openblas
, python
, gfortran
, openmpi
, tcsh
, valgrind
}:

stdenv.mkDerivation rec {
  name = "petsc-${version}";
  version = "3.7.6";

  src = fetchurl {
    url = "http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-${version}.tar.gz";
    sha256 = "0jfl35lrhzvv982z6h1v5rcp39g0x16ca43rm9dx91wm6i8y13iw";
  };

  patches = [ ./petscmpiexec.patch ];

  nativeBuildInputs = [ openblas python openmpi tcsh valgrind gfortran ];

  enableParallelBuilding = true;

  preConfigure = ''
    patchShebangs .
    configureFlagsArray=(
      $configureFlagsArray
      "--with-scalar-type=complex"
      "--with-mpi=1"
      "--with-mpi-dir=${openmpi}"
      "--with-blas-lapack-lib=${openblas}/lib/libopenblas.a"
      "--with-valgrind=1"
      "--with-valgrind-dir=${valgrind}"
    )
  '';


  postInstall = ''
    rm $out/bin/popup
    rm $out/bin/uncrustify.cfg
    rm -rf $out/bin/win32fe
  '';

  checkPhase = "make test";

  doCheck = true;

  meta = {
    description = "Library of linear algebra algorithms for solving partial differential equations";
    homepage = https://www.mcs.anl.gov/petsc/index.html;
    platforms = stdenv.lib.platforms.all;
    license = stdenv.lib.licenses.bsd2;
  };
}
