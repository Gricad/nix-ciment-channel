{ stdenv, fetchurl, glibc, perl, python, xorg, zlib, gcc45, fontconfig, freetype, glib, libselinux, libxml2, sqlite, expat, bzip2, libkrb5, gdbm, e2fsprogs, coreutils, nettools, gawk, bash }:

stdenv.mkDerivation rec {
  version = "4.2";
  name = "casa-${version}";

   src = fetchurl {                                                   
      url = "https://svn.cv.nrao.edu/casa/distro/linux/old/casapy-42.2.30986-pipe-1-64b.tar.gz";
      sha256 = "0hax0f8niplwd35d1bbq2050hg1ggwv8sclxckkb161fnhd7raig"; 
    };                                                                 

  nativeBuildInputs = [ glibc perl python xorg.libSM xorg.libICE xorg.libX11 xorg.libXext xorg.libXi xorg.libXrender xorg.libXrandr xorg.libXfixes xorg.libXcursor xorg.libXinerama xorg.libXft zlib gcc45 fontconfig glib freetype libselinux libxml2 sqlite expat xorg.libxcb bzip2 libkrb5 gdbm e2fsprogs coreutils nettools gawk bash ];

  phases = [ "unpackPhase" "installPhase" "fixupPhase" "installCheckPhase" "distPhase" ];

  # We do this manually in the custom postFixup phase
  dontStrip = true;
  dontPatchELF = true;
  dontPatchShebangs = true;

  # Symlinks already exists
  dontMoveSbin = true;
  dontMoveLib64 = true;

  installPhase = ''
     cd .. && cp -a $sourceRoot $out
  '';

  postFixup = ''
    echo "Fixing rights..."
    chmod u+w -R $out
    echo "Patching rpath and interpreter..."
    find $out -type f ! -name "libgomp.*" ! -name "_hashlib.so" ! -name "libssl.so.6" ! -name "libcrypto.so.6" ! -name "*_debug.so*" -exec $SHELL -c "patchelf --set-rpath ${glibc}/lib:$out/lib64:${gcc45.cc}/lib:${gcc45.cc.lib}/lib:${zlib}/lib:${glib}/lib:${freetype}/lib:${xorg.libSM}/lib:${xorg.libICE}/lib:${xorg.libX11}/lib:${xorg.libXext}/lib:${xorg.libXi}/lib:${xorg.libXrender}/lib:${xorg.libXrandr}/lib:${xorg.libXfixes}/lib:${xorg.libXcursor}/lib:${xorg.libXinerama}/lib:${xorg.libxcb}/lib:${xorg.libXft}/lib:${fontconfig.lib}/lib:${libselinux}/lib:${libxml2.out}/lib:${sqlite.out}/lib:${expat}/lib:$out/etc/carta/lib:${bzip2.out}/lib:${libkrb5}/lib:${gdbm}/lib:${e2fsprogs.out}/lib '{}' 2>/dev/null" \;
    find $out -type f -exec $SHELL -c "patchelf --set-interpreter $(echo ${glibc}/lib/ld-linux*.so.2) '{}' 2>/dev/null" \;
    patchelf --set-rpath $out/lib64 $out/lib64/python2.7/lib-dynload/_hashlib.so
    echo "Patching casa wrapper..."
    patchelf --print-rpath $out/lib64/libaatm.so.2  > ldpath.txt
    sed -e "s,LD_LIBRARY_PATH=,LD_LIBRARY_PATH=`cat ldpath.txt`:," -i $out/casa
    sed -e "s,LD_LIBRARY_PATH=,LD_LIBRARY_PATH=`cat ldpath.txt`:," -i $out/casapy
    echo "Fixing path into scripts..."
    for file in `grep -l -r "$sourceRoot" $out`
    do
      sed -e "s,$sourceRoot,$out,g" -i $file
    done 
    find $out -maxdepth 1 -type f -exec $SHELL -c "sed -e 's,:/usr/bin:/usr/X11R6/bin,${coreutils}/bin:${nettools}/bin:${gawk}/bin:${bash}/bin,' -i '{}'" \;
    find $out -maxdepth 1 -type f -exec $SHELL -c "sed -e 's,:/lib64:/usr/lib64,,' -i '{}'" \;
    echo "Patching shebangs..."
    patchShebangs $out
    sed -e 's,/bin/sh,${bash}/bin/sh,' -i $out/lib64/python2.7/popen2.py
    sed -e 's,/bin/sh,${bash}/bin/sh,' -i $out/lib64/python2.7/subprocess.py 
    sed -e 's,/bin/sh,${bash}/bin/sh,' -i $out/lib64/python2.7/pipes.py
    sed -e 's,/bin/sh,${bash}/bin/sh,' -i $out/lib64/python2.7/site-packages/numpy/distutils/exec_command.py 
    sed -e 's,/bin/sh,${bash}/bin/sh,' -i $out/lib64/python2.7/site-packages/twisted/conch/scripts/cftp.py
    sed -e 's,/bin/sh,${bash}/bin/sh,' -i $out/lib64/python2.7/_sysconfigdata.py
    sed -e 's,/bin/sh,${bash}/bin/sh,' -i $out/lib64/python2.7/site-packages/twisted/conch/unix.py
    sed -e 's,/bin/sh,${bash}/bin/sh,' -i $out/lib64/python2.7/site-packages/twisted/scripts/tap2deb.py
    sed -e 's,/bin/sh,${bash}/bin/sh,' -i $out/lib64/python2.7/site-packages/twisted/scripts/tap2rpm.py
    sed -e 's,/bin/sh,${bash}/bin/sh,' -i $out/lib64/python2.7/site-packages/twisted/runner/procmon.py
    sed -e 's,/bin/sh,${bash}/bin/sh,' -i $out/lib64/python2.7/site-packages/IPython/kernel/scripts/ipcluster.py
    sed -e 's,/bin/sh,${bash}/bin/sh,' -i $out/lib64/python2.7/site-packages/setuptools/command/bdist_egg.py
    sed -e 's,/bin/sh,${bash}/bin/sh,' -i $out/lib64/python2.7/site-packages/setuptools/command/easy_install.py
  '';

  meta = {
    description = "Casa binary distribution";
    maintainers = [ stdenv.lib.maintainers.bzizou ];
    platforms = stdenv.lib.platforms.linux;
  };
}

