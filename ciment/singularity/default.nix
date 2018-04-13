{ stdenv
, fetchFromGitHub
, autoreconfHook 
, python27 
, coreutils
, gnugrep }:

stdenv.mkDerivation rec {
  name = "singularity-${version}";
  version = "2.4.5";

  src = fetchFromGitHub { 
    owner = "singularityware";
    repo = "singularity";
    rev = version;
    sha256 = "0wz2in07197n5c2csww864nn2qmr925lqcjsd1kmlwwnrhq6lzl3";
  };

  buildInputs = [ autoreconfHook python27 ];

  preConfigure = ''
    substituteInPlace bin/singularity.in --replace PATH=\"/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin\"  PATH="${stdenv.lib.makeBinPath [ coreutils python27 gnugrep ]}"
    substituteInPlace etc/init --replace SINGULARITYENV_PATH=\"/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin\" SINGULARITYENV_PATH="${stdenv.lib.makeBinPath [ coreutils python27 gnugrep ]}"
    export NIX_LDFLAGS="$NIX_LDFLAGS -rpath $out/lib/singularity"
  '';

  # Manually fix the RPATH (contains references to /tmp/nix-build*)
  dontPatchELF = true;
  preFixup = ''
    echo "preFixup..."
    for i in $out/libexec/singularity/bin/*
    do 
      newRpath=$(patchelf --print-rpath $i | sed -r 's|(.*)(/tmp/nix-build-.*/.libs:?)(.*)|\1\3|g')
      newRpath=$(echo $newRpath | sed -r 's|(.*)(/tmp/nix-build-.*/.libs:?)(.*)|\1\3|g')
      echo "  Fixing RPATH of $i -> $newRpath"
      patchelf --set-rpath $out/lib/singularity:$newRpath $i
    done
  '';

  meta = with stdenv.lib; {
    homepage = http://singularity.lbl.gov/;
    description = "Designed around the notion of extreme mobility of compute and reproducible science, Singularity enables users to have full control of their operating system environment";
    license = "BSD license with 2 modifications";
    platforms = platforms.linux;
    maintainers = with maintainers ; [ jbedo bzizou ];
  };
}
