﻿# dxvk-build-tools

A collection of scripts and tools for constructing a docker image to build dxvk, dxvk-ags, dxvk-nvapi, d8vk, dxvk-tests and vkd3d-proton. Are you on Debian & derivatives or some other obscure distro and are tired of shuffling MinGW versions? Forget about your worries and build dxvk, dxvk-ags, dxvk-nvapi, d8vk, dxvk-tests and vkd3d-proton using an Arch based docker container (much like the dxvk GitHub CI is doing).

## What do I need?

Docker and dependencies (containerd, runc etc.), in whatever form it comes with your distro. As a note, on Debian and friends the docker package is very intuitively called `docker.io`.

And also git, in case that wasn't already painfully obvious.

## How do I use these things?

* After installing docker you'll need to add your user to the docker group.  
  
    `sudo usermod -aG docker <your_username>`  
  
    Will do the trick, afterwards you'll need a restart of the docker demon (or your system).  

* Secondly, you need to make sure all the .sh scripts have their execute permissions set, otherwise nothing will work. Note that execute permissions also need to be added to the scripts that are in the `source` and `misc` folders.  

* Now you're set to fetch the latest Arch docker image and construct your build containers. To do that simply run:  
  
    `./docker_build.sh`  

* You're now ready to launch the build images and enjoy your builds! Or are you? Well, no, you're not. Before that you'll need to use git to clone the repos locally. Each repo (be it dxvk, d8vk, dxvk-nvapi, dxvk-tests or vkd3d-proton) needs its own folder inside of the `source` directory. Simply use:  
  
    `cd source; ./repo_git_clone.sh; cd ..`  
  
    And follow the prompts. If you don't know what's being asked of you, you probably shouldn't be using this build toolset in the first place. Rinse and repeat if you want to fetch multiple repos.  

* OK, now you **are** ready to launch your build containers. Use:  
  
    `./repo_build_runner.sh <repo_name> [<build_name>]`  
  
    Where `<repo_name>` can be either dxvk, dxvk-ags, dxvk-nvapi, d8vk, dxvk-tests or vkd3d-proton. You can optionally also specify a `<build_name>`, otherwise it will default to `devel`.  
  
    Run the above whenever you need to build/rebuild dxvk, dxvk-ags, dxvk-nvapi, d8vk, dxvk-tests or vkd3d-proton. Note that the scripts will delete the previously compiled binaries if you use the same parameters. Back up any folders in the `output` directory if you want to keep older versions around.  

## What about dxvk-native?

That's not covered here, sorry. My aim is to provide an easy way to build Wine/Proton/Windows ready dlls for quick testing and development work. That being said it should be pretty easy to create a dxvk-native docker builder image retrofitting the existing scripts.

## I don't like your scripts at all, they're so bad it makes me sick. What should I do?

Not use them. Or change them however you like if something irks you, just don't expect me to do it unless you can convince me your way of doing things is in fact better.

