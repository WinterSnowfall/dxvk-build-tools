# dxvk-build-tools

A collection of scripts and tools for constructing a docker image to build dxvk, dxvk-ags, dxvk-nvapi, dxvk-tests, vkd3d-proton and nvidia-libs. Are you on Debian & derivatives or some other obscure distro and are tired of shuffling MinGW versions? Forget about your worries and build dxvk, dxvk-ags, dxvk-nvapi, dxvk-tests, vkd3d-proton and nvidia-libs using an Arch based docker container (much like the dxvk GitHub CI is doing).

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

* Finally, you're now ready to launch the build container and enjoy your builds! Use:
  
    `./repo_build_runner.sh <repo_name> [<build_name>]`
  
    Where `<repo_name>` can be either dxvk, dxvk-ags, dxvk-nvapi, dxvk-tests, vkd3d-proton or nvidia-libs. You can optionally also specify a `<build_name>`, otherwise it will default to `devel`.
  
    Run the above whenever you need to build/rebuild dxvk, dxvk-ags, dxvk-nvapi, dxvk-tests, vkd3d-proton or nvidia-libs. Note that the scripts will delete the previously compiled binaries if you use the same parameters. Back up any folders in the `output` directory if you want to keep older versions around.

## What about dxvk-native?

That's not covered here, sorry. My aim is to provide an easy way to build Wine/Proton/Windows ready dlls for quick testing and development work. That being said it should be pretty easy to create a dxvk-native docker builder image retrofitting the existing scripts.

