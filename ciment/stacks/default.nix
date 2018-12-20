{ stdenv, fetchurl, zlib }:
    
stdenv.mkDerivation rec {
  name = "stacks-${version}";
  version = "2.2";
  src = fetchurl {
    url = "http://catchenlab.life.illinois.edu/stacks/source/stacks-${version}.tar.gz";
    sha256 = "1cmab1zcghn4hq677q9i44wjqkfn7dpki47s4sb1rmnxiciw3p57";
  };

  buildInputs = [ zlib ];

  meta = {
    description = "Software pipeline for building loci from short-read sequences";
    homepage = http://catchenlab.life.illinois.edu/stacks/;
    license = stdenv.lib.licenses.gpl3;
  };
}
