{ stdenv, fetchurl, boost,  flex, bison, cmake, openmpi, ncurses, scotch, zlib, gnuplot, readline, xorg, freeglut, qt4, webkit, cgal }:

stdenv.mkDerivation rec {
  version = "5.0";
  name = "openfoam-${version}";

  src = fetchurl {
    url = "https://github.com/OpenFOAM/OpenFOAM-5.x/archive/version-5.0.tar.gz";
    sha256 = "9057d6a8bb9fa18802881feba215215699065e0b3c5cdd0c0e84cb29c9916c89";
  };

  enableParallelBuilding = true;

  buildInputs = [ boost flex bison cmake openmpi ncurses scotch zlib xorg.libXt qt4 webkit cgal ];
  propagateBuildInputs = [ gnuplot readline ];

  configurePhase=''
    patchShebangs ./
    mv ../OpenFOAM-5.x-version-5.0 ../OpenFOAM-5.0
    substituteInPlace etc/bashrc --replace '[ $BASH_SOURCE ]' '#[ $BASH_SOURCE ]'
    substituteInPlace etc/bashrc --replace 'FOAM_INST_DIR=$HOME/$WM_PROJECT' FOAM_INST_DIR=$out
    substituteInPlace etc/bashrc --replace '$HOME' $out 
    substituteInPlace wmake/wmakeCheckPwd --replace /bin/pwd pwd
    substituteInPlace wmake/rules/linux64Gcc/general --replace 'PROJECT_LIBS = ' 'PROJECT_LIBS = -L$(FOAM_LIBBIN)/dummy '
    echo "bef mkdir"
    mkdir $out
    cp -a ../OpenFOAM-5.0 $out/
    cd $out/OpenFOAM-5.0
    ls
    echo "bef source2"
    cat etc/bashrc
    source etc/bashrc
    echo "source ok"
    export LOGNAME=nix
    export WM_NCOMPPROCS=$NIX_BUILD_CORES
    echo "fin configure"
  '';

  buildPhase="./Allwmake";

  installPhase=''
    foamInstallationTest
  '';

  meta = {
    homepage = http://www.openfoam.org/;
    license = stdenv.lib.licenses.gpl3;
    maintainers = with stdenv.lib.maintainers; [bonamy];
    platforms = with stdenv.lib.platforms; linux;
  };

}
