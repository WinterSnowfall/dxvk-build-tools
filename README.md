# dxvk-build-tools

A collection of scripts and tools for constructing docker images to build dxvk/d8vk/dxvk-tests/vkd3d-proton. Are you on Debian & derivatives or some other obscure distro and are tired of shuffling MinGW versions? Forget about your worries and build your dxvk/d8vk/dxvk-tests using Arch based docker containers (much like the dxvk GitHub CI is doing).

## What do I need?

Docker and dependencies (containerd, runc etc.), in whatever form it comes with your distro. As a note, on Debian and friends the docker package is very intuitively called `docker.io`.

And also git, in case that wasn't already painfully obvious.

## How do I use these things?

* After installing docker you'll need to add your user to the docker group.  
  
    `sudo usermod -aG docker <your_username>`  
  
    Will do the trick, afterwards you'll need a restart of the docker demon (or your system).  

* Secondly, you need to make sure all the .sh scripts have their execute permissions set, otherwise nothing will work. Note that execute permissions also need to be added to the script that are in the `source` folder.  

* Now you're set to fetch the latest Arch docker image and construct your build containers. To do that simply run:  
  
    `./docker_dxvk_build.sh`  
    `./docker_vkd3d-proton_build.sh`  
    `./docker_dxvk-tests_build.sh`  
  
    You may skip the latter if you're not interested in building dxvk-tests.  

* You're now ready to launch the build images and enjoy your builds! Or are you? Well, no, you're not. Before that you'll need to use git to clone the repos locally. Each repo (be it dxvk, d8vk, dxvk-tests or vkd3d-proton) needs its own folder inside of the `source` directory. Simply use:  
  
    `cd source; ./git_clone_repos.sh; cd ..`  
  
    And follow the prompts. If you don't know what's being asked of you, you probably shouldn't be using this build toolset in the first place. Rinse and repeat if you want to fetch multiple repos.  

* OK, now you **are** ready to launch your build containers. Use:  
  
    `./dxvk_build_runner.sh <project_name> [<build_name>]`  
    `./vkd3d-proton_build_runner.sh [<build_name>]`  
    `./dxvk-tests_build_runner.sh`  
  
    Where `<project_name>` can be either dxvk or d8vk (or really whatever name your source directory has). You can optionally also specify a `<build_name>`, otherwise it will default to `devel`.  
  
    Run the above whenever you need to build/rebuild dxvk/d8vk/dxvk-tests/vkd3d-proton. Note that the scripts will delete the previously compiled binaries if you use the same parameters. Back up any folders in the `output` directory if you want to keep older versions around.  

## An undocumented DXVK_MAX_PERFORMANCE shell variable??? I knew it, the conspiracy theories are real!

It only exists within the confines of these unholy build scripts, I'm afraid. There's no free performance lunch to be had.

If you set `DXVK_MAX_PERFORMANCE=1`™ before launching any of the runner scripts above, it will ensure d8vk/dxvk/dxvk-tests/vkd3d-proton are built using `-march=native`.

**This compiler flag is for meme and testing purposes only** and will maybe at best give you a microgram of extra performance with dxvk in some cases, assuming you have an AVX capable processor. More details here, straight from the horse's mouth: https://github.com/doitsujin/dxvk/pull/3591#issuecomment-1656720927

There's really no reason to bother with this unless you want to do comparative performance testing and see for yourself that it doesn't do much, since it will make your builds less portable. Also note that once you've used it there's no going back to defaults unless you `git reset` affected repos or undo the changes manually.

Consider yourself warned.

## What about dxvk-native?

That's not covered here, sorry. My aim is to provide an easy way to build Wine/Proton/Windows ready dlls for quick testing and development work. That being said it should be pretty easy to create a dxvk-native docker builder image retrofitting the existing scripts.

## I don't like your scripts at all, they're so bad it makes me sick. What should I do?

Not use them. Or change them however you like if something irks you, just don't expect me to do it unless you can convince me your way of doing things is in fact better.

