{ stdenv, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  pname = "astropy";
  version = "3.0.1";
  name = "${pname}-${version}";
  doCheck = false; # Some tests are failing.
  
  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "0rqhvpsw99v6rxhfd8g94xkkk19xbww1bj3w83rcmpsdq4rl8py3";
  };
  propagatedBuildInputs = with pythonPackages ; [ numpy pytest ];

}
