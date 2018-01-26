{ stdenv, fetchurl, fetchsvn, gmt, autoconf, gfortran, libtiff, hdf5, liblapack
}:

stdenv.mkDerivation rec {
  name = "5.3";
  src = fetchsvn  {
  url = "svn://gmtserver.soest.hawaii.edu/GMT5SAR/branches/${name}";
  sha256 = "19698ajcclsnk5jhv695jg5j9b6vrw6dzams1r3j5jg9di6x71zr";
    };

  buildInputs = [ autoconf gmt gfortran libtiff hdf5 liblapack ];
  
  preConfigure = "autoconf";
  configureFlags=[
    "--with-orbits-dir=/home/ltavard/GRICAD/Nix_wip/mychannel/nix-ciment-channel/tmp/orbits"
    "--with-hdf5=${hdf5}"
    "--with-tiff-lib=${libtiff}"
    "--with-gmt-config=${gmt}"
    "--with-lapack=${liblapack}"];

  meta = {
    description     =  "An InSAR processing system based on GMT";
    longDescription = ''
      GMTSAR is an open source (GNU General Public License) InSAR 
      processing system designed for users familiar with Generic 
      Mapping Tools (GMT).
    '';
    homepage        = http://topex.ucsd.edu/gmtsar/;
    license         = stdenv.lib.licenses.glp3Plus;
    maintainers     = [ stdenv.lib.maintainers.ltavard ];
    platforms       = stdenv.lib.platforms.linux;
  };
}

