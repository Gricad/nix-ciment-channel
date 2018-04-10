{ stdenv, buildPythonPackage, fetchPypi, astropy3 }:

buildPythonPackage rec {
  pname = "spectral-cube";
  version = "0.4.3";
  name = "${pname}-${version}";

  propagateBuildInputs= [ astropy3 ];

  src = fetchPypi {
    inherit pname version;
    sha256 = "057g3mzlg5cy4wg2hh3p6gssn93rs6i7pswzhldvcq4k8m8hsl3b";
  };

}
