{ stdenv, fetchurl, boost,  flex, bison, cmake, openmpi, ncurses, scotch, zlib, gnuplot, readline, xorg, freeglut, qt4, webkit, cgal, fftw }:

stdenv.mkDerivation rec {
  version = "v1612+";
  name = "openfoamplus-${version}";

  src = fetchurl {
    url = "https://sourceforge.net/projects/openfoamplus/files/${version}/OpenFOAM-${version}.tgz";
    sha256 = "17anydlhvvr3riw9rqz1izyf12llls363jnhxwiiz3m60qsw8299";
  };

  enableParallelBuilding = true;

  buildInputs = [ boost flex bison cmake openmpi ncurses scotch zlib xorg.libXt qt4 webkit cgal fftw ];
  propagateBuildInputs = [ gnuplot readline ];

  configurePhase=''
    patchShebangs ./
    substituteInPlace etc/bashrc --replace '[ $BASH_SOURCE ]' '#[ $BASH_SOURCE ]'
    substituteInPlace etc/bashrc --replace 'FOAM_INST_DIR=$HOME/$WM_PROJECT' FOAM_INST_DIR=$out
    substituteInPlace etc/bashrc --replace '$HOME' $out 
    substituteInPlace wmake/wmakeCheckPwd --replace /bin/pwd pwd
    substituteInPlace wmake/rules/linux64Gcc/general --replace 'PROJECT_LIBS = ' 'PROJECT_LIBS = -L$(FOAM_LIBBIN)/dummy '
    mkdir $out
    cp -a ../$sourceRoot $out/
    cd $out/$sourceRoot
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
    mkdir $WM_THIRD_PARTY_DIR
    foamInstallationTest
    rmdir $WM_THIRD_PARTY_DIR # no thirdparty needed, all deps provided by nix!
  '';

  meta = {
    homepage = http://www.openfoam.com/;
    license = stdenv.lib.licenses.gpl3;
    maintainers = [ stdenv.lib.maintainers.bzizou ];
    platforms = stdenv.lib.platforms.x86_64-linux;
  };

}
