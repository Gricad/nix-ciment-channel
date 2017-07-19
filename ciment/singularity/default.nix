{ stdenv
, fetchurl
, autoreconfHook 
, python27 
, coreutils
, gnugrep }:

stdenv.mkDerivation rec {
  name = "singularity-${version}";
  version = "2.3.1";

  src = fetchurl { 
    url = "https://github.com/singularityware/singularity/releases/download/${version}/singularity-${version}.tar.gz";
    sha256 = "1mrcxwlmi93vxggf3776kbajsi2rzg035scl5ha0smbsysgsxk6w";
  };

  patches = [ ./chk_mode.patch ];

  buildInputs = [ autoreconfHook python27 ];

  preConfigure = ''
    substituteInPlace bin/singularity.in --replace PATH=\"/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin\"  PATH="${stdenv.lib.makeBinPath [ coreutils python27 gnugrep ]}"
    substituteInPlace etc/init --replace SINGULARITYENV_PATH=\"/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin\" SINGULARITYENV_PATH="${stdenv.lib.makeBinPath [ coreutils python27 gnugrep ]}"
    export NIX_LDFLAGS="$NIX_LDFLAGS -rpath $out/lib/singularity"
  '';

  # Don't shrink the RPATH, otherwise singularity does not find the libraries specified above
  dontPatchELF = true;

  meta = with stdenv.lib; {
    homepage = http://singularity.lbl.gov/;
    description = "Designed around the notion of extreme mobility of compute and reproducible science, Singularity enables users to have full control of their operating system environment";
    license = "BSD license with 2 modifications";
    platforms = platforms.linux;
    maintainers = [ maintainers.jbedo ];
  };
}
