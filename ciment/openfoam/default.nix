{ stdenv, fetchurl, boost,  flex, bison, cmake, openmpi, ncurses, scotch, zlib, gnuplot, readline, xorg, freeglut, qt4, webkit, cgal, fftw }:

stdenv.mkDerivation rec {
  version = "5.0";
  name = "openfoam-${version}";

  src = fetchurl {
    url = "https://github.com/OpenFOAM/OpenFOAM-5.x/archive/version-${version}.tar.gz";
    sha256 = "12bcj74jkjw41q6dsp1w1dg0d6an44as5sqzi018i8czpfldcmwh";
  };

  enableParallelBuilding = true;

  nativeBuildInputs = [ flex bison cmake ];
  buildInputs = [ boost openmpi ncurses scotch zlib xorg.libXt qt4 webkit cgal fftw ];
  propagateBuildInputs = [ gnuplot readline ];

  configurePhase=''
    patchShebangs ./
    substituteInPlace etc/bashrc --replace '[ $BASH_SOURCE ]' '#[ $BASH_SOURCE ]'
    substituteInPlace etc/bashrc --replace 'FOAM_INST_DIR=$HOME/$WM_PROJECT' FOAM_INST_DIR=$out
    substituteInPlace etc/bashrc --replace '$HOME' $out 
    substituteInPlace wmake/wmakeCheckPwd --replace /bin/pwd pwd
    substituteInPlace wmake/rules/linux64Gcc/general --replace 'PROJECT_LIBS = ' 'PROJECT_LIBS = -L$(FOAM_LIBBIN)/dummy '
    mkdir $out
    cp -a ../$sourceRoot $out/OpenFOAM-${version}
    cd $out/OpenFOAM-${version}
    ./bin/tools/foamConfigurePaths -boost-path ${boost.dev} -fftw-path ${fftw.dev} -scotch-path ${scotch}
    source etc/bashrc
    export LOGNAME=nix
    foamSystemCheck
    export WM_NCOMPPROCS=$NIX_BUILD_CORES
  '';

  buildPhase=''
    ./Allwmake
  '';

  installPhase=''
    foamInstallationTest
  '';

  meta = {
    homepage = http://www.openfoam.org/;
    license = stdenv.lib.licenses.gpl3;
    maintainers = [ stdenv.lib.maintainers.bzizou ];
    platforms = stdenv.lib.platforms.x86_64-linux;
  };

}
