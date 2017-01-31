# Debian/Ubuntu package for CP895 (Kamenicky) X fixed fonts

This repository contains scripts and Debian package specification that can be used to turn ucs-fonts (http://www.cl.cam.ac.uk/~mgk25/ucs-fonts.html) into a Debian package with CP895-encoded X fixed fonts. This can in turn be used together with dosemu (xdosemu).

It should be fairly easy to adapt (or extend) this to support more encodings you care about.

## How to build the package
The process is not fully automated. You need to run the individual steps manually.

First make sure you have the necessary tools to build the package. Required packages are:
* build-essential
* devscripts
* debhelper
* xfonts-utils
* wget

You can install these e.g. by:

    sudo apt-get install build-essential devscripts debhelper xfonts-utils wget

Then you can proceed to the individual steps.

### Get the upstream achive
Run:

     ./get_upstream_tar.sh

It should download the archive `ucs-fonts.tar.gz`.

### Repackage the upstream tar archive

The original tar archive needs to be repackaged to match the requirements of Debian packaging tools. To do so, run:

    ./repack_tar.sh

This should result in a file like `xfonts-ucs_1.115.orig.tar.xz`.

### Unpacking the orig.tar.xz file

Now unpack the orig.tar.xz:

    tar xJvf xfonts-ucs_1.115.orig.tar.xz

Its content should merge with what's already in the directory `xfonts-ucs-1.115`.

### Build the deb package

The packaging command must be run in the directory that contains the `debian` subdirectory, so change there:

    cd xfonts-ucs-1.115

and then run:

    debuild -us -uc

The resulting files should be built in the parent directory of the current directory (so, in the root of the repository). The file you care about is `xfonts-ucs-cp895_1.115-2_all.deb`.

## How to install the package

Just do:

    sudo dpkg -i xfonts-ucs-cp895_1.115-2_all.deb

And that should be it. If your X server is running run

    xset fp rehash

to make it see the new fonts. Then

    xlsfonts | grep cp895

should show you a bunch of items like:

    -misc-fixed-medium-r-normal--0-0-100-100-c-0-ibm-cp895
    -misc-fixed-medium-r-normal--0-0-75-75-c-0-ibm-cp895
    ...

To make dosemu use the font, put something like the following in `/etc/dosemu/dosemu.conf`:

    $_X_font = "-misc-fixed-*-20-*-cp895"

Good luck!
