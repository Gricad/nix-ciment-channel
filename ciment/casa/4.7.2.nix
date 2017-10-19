{ stdenv, fetchurl, glibc, perl, python, xorg, zlib, gcc, fontconfig, freetype, glib }:

stdenv.mkDerivation rec {
  version = "4.7.2";
  name = "casa-${version}";

   src = fetchurl {                                                   
      url = "https://casa.nrao.edu/download/distro/linux/release/el7/casa-release-4.7.2-el7.tar.gz";
      sha256 = "0r7ahcyaj2vkymi6r0ilxsrm1apxcdffkqf5c7cqdbf8x1q97h7c"; 
    };                                                                 

  nativeBuildInputs = [ glibc perl python xorg.libSM xorg.libICE xorg.libX11 xorg.libXext xorg.libXi xorg.libXrender xorg.libXrandr xorg.libXfixes xorg.libXcursor xorg.libXinerama zlib gcc fontconfig freetype glib ];

  phases = [ "unpackPhase" "installPhase" "fixupPhase" "installCheckPhase" "distPhase" ];

  installPhase = ''
     cd .. && cp -a $sourceRoot $out
  '';

  postFixup = ''
    echo "Fixing rights..."
    chmod u+w -R $out
    echo "Patching rpath and interpreter..."
    find $out -type f -exec $SHELL -c "patchelf --set-interpreter $(echo ${glibc}/lib/ld-linux*.so.2) --set-rpath ${glibc}/lib:$out/lib:${gcc.cc}/lib:${gcc.cc.lib}/lib:${zlib}/lib:${xorg.libSM}/lib:${xorg.libICE}/lib:${xorg.libX11}/lib:${xorg.libXext}/lib:${xorg.libXi}/lib:${xorg.libXrender}/lib:${xorg.libXrandr}/lib:${xorg.libXfixes}/lib:${xorg.libXcursor}/lib:${xorg.libXinerama}/lib:${fontconfig.lib}/lib:${freetype}/lib:${glib}/lib 2>/dev/null {}" \;
    echo "Fixing path into scripts..."
    for file in `grep -l -r "$sourceRoot" $out`
    do
      sed -e "s,$sourceRoot,$out,g" -i $file
    done 
    echo "Patching shebangs..."
    patchShebangs $out
  '';

  meta = {
    description = "Casa binary distribution";
    maintainers = [ stdenv.lib.maintainers.bzizou ];
    platforms = stdenv.lib.platforms.linux;
  };
}

