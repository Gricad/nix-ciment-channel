{stdenv, fetchurl, openmpi, plplot, cmake, ncurses, zlib ,libpng, readline, gsl, gcc, imagemagick, wxGTK30,libgeotiff, netcdf, hdf5, fftw, python37, eigen }:
let
  my-python-packages = python-packages: with python-packages; [
   numpy
  ]; 
  python-with-my-packages = python37.withPackages my-python-packages;
in


stdenv.mkDerivation rec {
	version ="0.9.9";
	name="gdl";
	nativeBuildInputs =[cmake ];
	buildInputs = [plplot openmpi ncurses zlib libpng readline gsl imagemagick wxGTK30 libgeotiff netcdf hdf5 fftw eigen ];
	src = fetchurl {
		url = "https://github.com/gnudatalanguage/gdl/archive/v${version}.tar.gz";
		sha256="ad5de3fec095a5c58b46338dcc7367d2565c093794ab1bbcf180bba1a712cf14";
	};
	enableParallelBuilding =true;
	cmakeFlags =[ "-DHDF=OFF" "-DFFTW=false" "-DPSLIB=OFF" "-DPYTHON=false"];
	meta = {
		description = "A free and open-source IDL/PV-WAVE compiler";
		homepage = "https://github.com/gnudatalanguage/gdl";
		licence = stdenv.lib.licences.lgpl2;
		plateforms = stdenv.lib.plateforms.all;
	};

}
