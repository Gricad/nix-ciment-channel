# GRICAD contributions to NIX

| Package name / version | Status          | Developper(s)           | Informations / Links                                                                                     |
|------------------------|-----------------|-------------------------|----------------------------------------------------------------------------------------------------------|
| irods                  | Merged   | Bruno Bzeznik           | To iterate: https://github.com/NixOS/nixpkgs/pull/19898                                                  |
| intel 2016             | Ciment   | Bruno Bzeznik           | https://ciment.ujf-grenoble.fr/wiki/index.php/NIX_packaging_WIP#Compilateurs_et_libs_Intel_2016          |
| elmer                  | TODO      | Laure Tavard            |                                                                                                          |
| cdo                    | Merged   | Laure Tavard            | https://github.com/NixOS/nixpkgs/tree/master/pkgs/development/libraries/cdo                                                                                                         |
| gmt                    | Ciment   | Laure Tavard            | 	To be tested: nix-env -i -A ciment-channel.ciment.gmt   |
| gmtsar                 | WIP      | Laure Tavard            |    https://github.com/ltavard/nix-ciment-channel/tree/gmtsar/ciment/gmtsar                                                                                                      |
| paraview               | Upgraded | Yves Rogez              | https://ciment.ujf-grenoble.fr/wiki/index.php/NIX_packaging_WIP#Paraview                                 |
| gildas                 | PR      | Bruno Bzeznik           |  https://github.com/NixOS/nixpkgs/pull/27138               |
| scotch                 | Merged   | Bruno Bzeznik           | |
| kanif                  | Merged   | Bruno Bzeznik           | |
| taktuk                 | Merged   | Bruno Bzeznik           | |
| libibverbs mlx4 support| Merged   | Bruno Bzeznik           | |
| nco                    | Merged   | Bruno Bzeznik           | |
| libdap                 | Merged   | Bruno Bzeznik           | |
| netcdf-fortran         | Merged   | Bruno Bzeznik           | |
| libmatheval            | Merged   | Bruno Bzeznik           | |
| siconos                | WIP      | Franck Pérignon         | http://siconos.gforge.inria.fr/
| hysop                  | WIP      | Franck Pérignon         | |
| linbox                 | WIP      | Franck Pérignon         |  http://www.linalg.org
| OCE + pythonocc        | WIP      | Franck Pérignon         |  https://github.com/tpaviot/oce, http://www.pythonocc.org
| Openfoam               | WIP      | Bruno Bzeznik           |  https://github.com/Gricad/nix-ciment-channel/tree/openfoam |
| SedFoam                | TODO     |                         | https://github.com/SedFoam/sedfoam |
| Intel 2017             | WIP      | Bruno Bzeznik           |  https://github.com/Gricad/nix-ciment-channel/tree/intel |
| NCL                    | TODO     |                         |  http://www.ncl.ucar.edu/current_release.shtml (opendap) |
| Obspy                  | TODO     |                         | https://github.com/obspy/obspy/wiki |
| Grads                  | TODO     |                         | http://cola.gmu.edu/grads/ |
| Biogeme/PythonBiogeme  | TODO     |                         | http://biogeme.epfl.ch/install.html |
| R-open                 | TODO     |                         | https://mran.revolutionanalytics.com/rro/ |
| Hypre                  | WIP      | P. Beys, F. Roch        | https://computation.llnl.gov/projects/hypre-scalable-linear-solvers-multigrid-methods|
| Siesta                 | WIP      | P. Beys, F. Roch        | http://departments.icmab.es/leem/siesta/ |
| PETSC openmpi support  | WIP      | P. Beys                 | several compil options, cf Froggy|
| IOR                    | Merged   | Bruno Bzeznik           | https://github.com/NixOS/nixpkgs/tree/master/pkgs/tools/system/ior |
| pluto                  | TODO     |                         | http://plutocode.ph.unito.it/Download.html |
| OTB                    | TODO     |                         | https://www.orfeo-toolbox.org/download/ |
| OpenMPI 2              | Ciment   | Bruno Bzeznik           | To be tested: nix-env -i -A ciment-channel.ciment.openmpi2 |
| Surpi                  | TODO     |                         | http://chiulab.ucsf.edu/surpi/ |
| Singularity 2.2 -> 2.3 | WIP      | Bruno Bzeznik           | see singularity branch |
| Mumps                  | TODO     |                         | Dependency for PETSC usage on Froggy (N. Schaeffer)|
| Casa                   | Ciment   | Bruno Bzeznik           | Binaries packaging https://casa.nrao.edu/casa_obtaining.shtml |
| Seismic Unix           | WIP      | Laure Tavard            | http://www.cwp.mines.edu/cwpcodes/ | 
| ParMETIS               | WIP      | Laure Tavard            |  |
| Scalapack              | WIP      | Laure Tavard            |  | 



> Legend:
>
> * **TODO**: needed package (dep or user application), but no work done for the moment
> * **WIP**: Work in progress, check the link to the devel branch if any
> * **PR**: Pull request opened at nixpkgs
> * **Merged**: Pushed and merged into the official nixpkgs repository
> * **Ciment**: Pushed into the local ciment channel (nix-ciment-channel repository)
