{stdenv, fetchurl, gfortran, perl, rdma-core, python27, psm2, libfabric

# Enable the Sun Grid Engine bindings
, enableSGE ? false

# Pass PATH/LD_LIBRARY_PATH to point to current mpirun by default
, enablePrefix ? false

# For Infiniband low latency networks support
, enableIbverbs ? false

# For Omnipath low latency networks support
# WARNING: may not work if enableIbverbs is true!
, enableFabric ? false
}:

with stdenv.lib;

let
  majorVersion = "2.1";
  minorVersion = "3";

in stdenv.mkDerivation rec {
  name = "openmpi-${majorVersion}.${minorVersion}";

  src = fetchurl {
    url = "http://www.open-mpi.org/software/ompi/v${majorVersion}/downloads/${name}.tar.bz2";
    sha256 = "1s3r9lsnk12zax4fngy6yac19ipc8dh4jx24a8ah8rzdd4m3wnr8";
  };

  buildInputs = [ gfortran ]
    ++ optional enableIbverbs rdma-core
    ++ optional enableFabric psm2
    ++ optional enableFabric libfabric
    ;

  nativeBuildInputs = [ perl python27 ];

  configureFlags = []
    ++ optional enableSGE "--with-sge"
    ++ optional enablePrefix "--enable-mpirun-prefix-by-default"
    ++ optional enableFabric "--with-psm2=${psm2}/usr --with-libfabric=${libfabric}"
    ;

  enableParallelBuilding = true;

  preBuild = ''
    patchShebangs autogen.pl
    patchShebangs config/find_common_syms
    patchShebangs config/opal_mca_priority_sort.pl
    patchShebangs ompi/tools/wrappers/mpijavac.pl.in
    patchShebangs ompi/mpi/fortran/base/gen-mpi-mangling.pl
    patchShebangs ompi/mpi/fortran/base/gen-mpi-sizeof.pl
    patchShebangs ompi/include/mpif-values.pl
    patchShebangs opal/mca/event/libevent2022/libevent/event_rpcgen.py
    patchShebangs orte/test/system/red.py
    patchShebangs orte/test/system/mapr.py
  '';

  postInstall = ''
		rm -f $out/lib/*.la
   '';

  meta = {
    homepage = http://www.open-mpi.org/;
    description = "Open source MPI-2 implementation";
    longDescription = "The Open MPI Project is an open source MPI-2 implementation that is developed and maintained by a consortium of academic, research, and industry partners. Open MPI is therefore able to combine the expertise, technologies, and resources from all across the High Performance Computing community in order to build the best MPI library available. Open MPI offers advantages for system and software vendors, application developers and computer science researchers.";
    maintainers = [ stdenv.lib.maintainers.bzizou ];
    platforms = platforms.unix;
  };
}
