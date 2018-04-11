{ stdenv, buildPythonPackage, fetchPypi, numpy, astropy, radio_beam }:

buildPythonPackage rec {
  pname = "spectral-cube";
  version = "0.4.3";
  name = "${pname}-${version}";

  propagateBuildInputs= [ numpy astropy radio_beam ];

  src = fetchPypi {
    inherit pname version;
    sha256 = "057g3mzlg5cy4wg2hh3p6gssn93rs6i7pswzhldvcq4k8m8hsl3b";
  };

}
