{ stdenv, fetchurl, gtk2 , pkgconfig , python27 , gfortran , python27Packages , lesstif , cfitsio , getopt , perl , groff , which }:

stdenv.mkDerivation rec {
  srcVersion = "mar18c";
  version = "20180301_c";
  name = "gildas-${version}";

  src = fetchurl {
    url = "http://www.iram.fr/~gildas/dist/gildas-src-${srcVersion}.tar.gz";
    sha256 = "0b7p0sv37dgba2rfdxcwqrgk7v6hjn5mff98vpb7d2bdlk6xypp9";
  };

  enableParallelBuilding = true;

  nativeBuildInputs = [ pkgconfig groff perl getopt gfortran python27 python27Packages.numpy which ];

  buildInputs = [ gtk2 lesstif cfitsio ];

  patches = [ ./wrapper.patch ./return-error-code.patch ];

  configurePhase=''
    substituteInPlace admin/wrapper.sh --replace '%%OUT%%' $out
    source admin/gildas-env.sh -b gcc -c gfortran -o openmp
    echo "gag_doc:        $out/share/doc/" >> kernel/etc/gag.dico.lcl
  '';

  buildPhase=''
    make depend
    make install
  '';

  installPhase=''
    mkdir -p $out/bin
    cp -a ../gildas-exe-${srcVersion}/* $out
    mv $out/$GAG_EXEC_SYSTEM $out/libexec
    cp admin/wrapper.sh $out/bin/gildas-wrapper.sh
    chmod 755 $out/bin/gildas-wrapper.sh
    for i in $out/libexec/bin/* ; do
      ln -s $out/bin/gildas-wrapper.sh $out/bin/$(basename "$i")
    done
  '';

  meta = {
    description = "Radioastronomy data analysis software";
    longDescription = ''
      GILDAS is a collection of state-of-the-art software
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
