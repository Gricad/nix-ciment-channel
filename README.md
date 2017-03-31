CIMENT NIX channel
==================

Intended to be used as a channel to add specific custom packages without modifying the upstream nixpkgs.

Usage:

* Clone this branch
    git clone https://github.com/Gricad/nix-ciment-channel.git

* Clone the nixpkgs repository in a submodule
    cd nix-ciment-channel
    git submodule add https://github.com/Gricad/nixpkgs.git

* You can test a package
    nix-build . -A ciment.hello

* Create the channel
    * Push your package into the binary-cache
    nix-push --dest /scratch/nix.cache $(nix-build -A ciment.hello)
    * Create the channel tarball
    tar cjf /var/www/nix/nixexprs.tar.bz2 nixpkgs/ --exclude-vcs
