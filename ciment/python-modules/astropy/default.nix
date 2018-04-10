{ stdenv, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "astropy";
  version = "3.0.1";
  name = "${pname}-${version}";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0rqhvpsw99v6rxhfd8g94xkkk19xbww1bj3w83rcmpsdq4rl8py3";
  };

}
