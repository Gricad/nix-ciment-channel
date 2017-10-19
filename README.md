CIMENT NIX channel
==================

A channel to add specific custom packages without modifying the upstream nixpkgs, and allowing when to update nixpkgs.

Set-up
------

* Clone this repository

    ```git clone https://github.com/Gricad/nix-ciment-channel.git```

* Clone the nixpkgs repository at the release we are currently using

    ```
    git clone https://github.com/Gricad/nixpkgs.git
    cd nixpkgs
    git checkout release-17.09
    cd ..
    ```
* Link the nixpkgs directory
    ```
    cd nix-ciment-channel
    ln -s ../nixpkgs
    ```

* You can test to build a package

    ```
    # Build
    nix-build . -A ciment.hello
    # Install
    nix-env -i ./result
    ```

* Create the channel (OPTIONAL, if you are an admin)
    * Push your package into the binary-cache
        ```
        nix-push --dest /scratch/nix.cache $(nix-build -A ciment.hello)
        ```

    * Create the channel tarball
        ```
        tar cjf /var/www/nix/nixexprs.tar.bz2 nix-ciment-channel/ --exclude-vcs --dereference --exclude result
	```

Update
------
Custom packages can be push into the ```ciment``` directory.
Upstream nixpkgs repository can be upgraded by a simple ```git pull``` from the ```nixpkgs``` directory. Then, if you're an admin , you can re-create the ```nixexprs.tar.bz2``` file, after pushing new packages into the cache if needed.

Usage
-----

* List ciment packages

    ```nix-env -qa -A ciment-channel.ciment```

* Install a package

    ```nix-env -i -A ciment-channel.ciment.hello```

* Every other official package may be installed as usual

    ```nix-env -i hello```
