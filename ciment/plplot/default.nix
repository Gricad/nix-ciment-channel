{ stdenv, fetchurl, cmake, python }:

 stdenv.mkDerivation rec {

     version = "5.13";
     name = "plplot";

     src = fetchurl {
       url = "https://sourceforge.net/projects/plplot/files/plplot/5.13.0%20Source/plplot-5.13.0.tar.gz";
       sha256 = "0asxn9hwyb8wk6mb2gmmb7jn0ma1qdyqzn4giz4x3n83igpbndpc";
     };

     nativeBuildInputs = [ cmake ];


     meta = {
        description = "PLplot is a cross-platform software package for creating scientific plots";
        homepage = "http://plplot.sourceforge.net/";
        license = stdenv.lib.licenses.lgpl2;
        platforms = stdenv.lib.platforms.all;
     };
 }
