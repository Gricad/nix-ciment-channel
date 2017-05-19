{ stdenv, fetchurl, gtk2 , pkgconfig , python27 , gfortran , python27Packages , lesstif , cfitsio , getopt , perl , groff }:

stdenv.mkDerivation rec {
  version = "feb17d";
  name = "gildas-${version}";

  src = fetchurl {
    url = "http://www.iram.fr/~gildas/dist/gildas-src-${version}.tar.gz";
    sha256 = "1b7rh3jbjvrpxqxf3ync3693daax429mwf40y8gsb3cb5d97v57a";
  };

  enableParallelBuilding = false;

  buildInputs = [ gtk2 pkgconfig python27 gfortran python27Packages.numpy lesstif cfitsio getopt perl groff ];

  patches = [ ./format-security.patch ./wrapper.patch ];

  configurePhase=''
    substituteInPlace admin/wrapper.sh --replace '%%OUT%%' $out
    source admin/gildas-env.sh -b gcc -c gfortran -o openmp
    export GAG_INC_FLAGS=""
  '';

  buildPhase="make install";

  installPhase=''
    mkdir -p $out/bin
    cp -a ../gildas-exe-${version}/* $out
    mv $out/$GAG_EXEC_SYSTEM $out/libexec
    cp admin/wrapper.sh $out/bin/gildas-wrapper.sh
    chmod 755 $out/bin/gildas-wrapper.sh
    for i in $out/libexec/bin/* ; do
      ln -s $out/bin/gildas-wrapper.sh $out/bin/`basename $i`
    done
  '';

  meta = {
    description = "Radioastronomy data analysis software";
    longDescription = ''
      GILDAS is a collection of state-of-the-art softwares
      oriented toward (sub-)millimeter radioastronomical
      applications (either single-dish or interferometer).
      It is daily used to reduce all data acquired with the
      IRAM 30M telescope and Plateau de Bure Interferometer
      PDBI (except VLBI observations). GILDAS is easily
      extensible. GILDAS is written in Fortran-90, with a
      few parts in C/C++ (mainly keyboard interaction,
      plotting, widgets).'';
    homepage = http://www.iram.fr/IRAMFR/GILDAS/gildas.html;
    license = stdenv.lib.licenses.free;
    maintainers = [ stdenv.lib.maintainers.bzizou ];
    platforms = stdenv.lib.platforms.all;
  };

}
