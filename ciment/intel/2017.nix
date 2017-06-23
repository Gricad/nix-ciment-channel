{ stdenv, fetchurl, glibc, gcc,
  preinstDir ? "/scratch/intel"
}:

stdenv.mkDerivation rec {
  version = "2017";
  name = "intel-compilers-${version}";
  sourceRoot = 
    if builtins.pathExists preinstDir then
      preinstDir
    else
      abort ''

        ******************************************************************************************
        Specified preinstDir (${preinstDir}) directory not found.
        To build this package, you have to first get and install locally the Intel Parallel Studio
        distribution with the official installation script provided by Intel.
        Then, set-up preinstDir to point to the directory of the local installation.
        ******************************************************************************************
      '';

  buildInputs = [ glibc gcc ];

  phases = [ "installPhase" "fixupPhase" "installCheckPhase" "distPhase" ];

  installPhase = ''
     cp -a $sourceRoot $out
     # Fixing man path
     rm -f $out/man
     mkdir -p $out/share
     ln -s ../compilers_and_libraries/linux/man/common $out/share/man
  '';

  postFixup = ''
    echo "Fixing rights..."
    chmod u+w -R $out
    echo "Patching rpath and interpreter..."
    find $out -type f -exec $SHELL -c 'patchelf --set-interpreter $(echo ${glibc}/lib/ld-linux*.so.2) --set-rpath ${glibc}/lib:${gcc.cc}/lib:${gcc.cc.lib}/lib:$out/lib/intel64:$out/compilers_and_libraries_2017.4.196/linux/bin/intel64 2>/dev/null {}' \;
    echo "Fixing path into scripts..."
    for file in `grep -l -r "$sourceRoot" $out`
    do
      sed -e "s,$sourceRoot,$out,g" -i $file
    done 
  '';

  meta = {
    description = "Intel compilers and libraries 2017";
    maintainers = [ stdenv.lib.maintainers.bzizou ];
    platforms = stdenv.lib.platforms.linux;
  };
}

