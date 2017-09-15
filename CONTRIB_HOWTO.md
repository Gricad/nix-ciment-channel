How to contribute to the CIMENT Nix channel
===========================================

Fork nix-ciment-channel
-----------------------
From github, fork the nix-ciment-channel repository into your profile. Go to ```https://github.com/Gricad/nix-ciment-channel``` and click on the *Fork* button.


Clone your fork and nixpkgs
---------------------------
Into a directory of your choice:

* Clone your fork:
    ```git clone git@github.com/<user>/nix-ciment-channel.git```
* Clone nixpkgs of the Gricad fork:
    ```git clone git@github.com/Gricad/nixpkgs```
* Go into the nixpkgs branch we are currently using:
```
  cd nixpkgs
  git checkout release-17.09
```
* Go back into the nix-ciment-channel repository and Create a link to nixpkgs
```
  cd ../nix-ciment-channel
  ln -s ../nixpkgs
```
* Create a new branch for your work (named for example "my-new-package")
    ```git checkout -b my-new-package```


Add your package
----------------
* Your package directory can go into the ```ciment``` subdirectory. It can be exactly as if you were submitting it to the official nixpkgs repository. This allows you to test your packages on the Ciment clusters before submitting them upstream. 
* You have to create a new entry into the ```default.nix``` file, to declare the attribute(s) for your package. The entry will be probably very similar to what you will put into ```pkgs/top-level/all-packages.nix``` later if you plan to submitt your package upstream.
* Then, to build your package, simply add the ```ciment.``` prefix. For example:
    ```nix-build . -A ciment.hello```

Create a pull request
---------------------
So, you get a package that builds and run, into your local copy of the ciment-channel. Now, you can submit your work. Once again, this process is very similar to the process you'll have to follow if you plan to submit your package to the official nixpkgs repository.
* Create a single commit for your package
```
   git add ...
   git commit -a
```
* Push your branch into your forked project
    ```git push origin my-new-package```
* Create a pull request: from the github interface, go into your fork. You should directly see a new button beside your last commit. Click and fill a little comment about your request.
* If we ask you to change something (check your mailbox), you'll have to ammend your commit (```git commit --amend```) and then force-push your branch (```git push origin my-new-package -f```). This will update your pull request that should stay into a single commit.
