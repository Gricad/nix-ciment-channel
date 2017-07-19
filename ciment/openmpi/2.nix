{stdenv, fetchurl, gfortran, perl, libibverbs, python27

# Enable the Sun Grid Engine bindings
, enableSGE ? false

# Pass PATH/LD_LIBRARY_PATH to point to current mpirun by default
, enablePrefix ? false
}:

with stdenv.lib;

let
  majorVersion = "2.1";

in stdenv.mkDerivation rec {
  name = "openmpi-${majorVersion}.1";

  src = fetchurl {
    url = "http://www.open-mpi.org/software/ompi/v${majorVersion}/downloads/${name}.tar.bz2";
    sha256 = "05jdbsdpada4iryshjlmx5bvj0z0dkpa0g3z1n649yiszzaasyxx";
  };

  buildInputs = [ gfortran ]
    ++ optional (stdenv.isLinux || stdenv.isFreeBSD) libibverbs;

  nativeBuildInputs = [ perl python27 ];

  configureFlags = []
    ++ optional enableSGE "--with-sge"
    ++ optional enablePrefix "--enable-mpirun-prefix-by-default"
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
    maintainers = [ stdenv.lib.maintainers.mornfall ];
    platforms = platforms.unix;
  };
}
