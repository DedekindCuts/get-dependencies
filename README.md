Installing R Packages without Internet
=============================

Scripts for: 
1. downloading R packages and their dependencies
2. installing R packages from downloaded files without needing an internet connection

## Instructions

While connected to the internet, use *get-packages.R* to download any desired R packages and all their dependencies.

1. Make sure to appropriately set everything in the "Configuration" section:
    1. Choose the package type `type` needed for the destination machine (see [Binary Packages](#binary-packages)).
    2. Specify the desired packages using `packs`.
    3. Set the destination for the downloaded packages using `pkg.path`.
2. Run *get-packages.R* to download the packages.

Then use *install-packages.R* to install the packages from the downloaded files.

1. Make sure to appropriately set everything in the "Configuration" section:
    1. Choose the type `type` of the downloaded packages (see [Binary Packages](#binary-packages)).
    2. Specify the source folder containing the downloaded packages using `pkg.path`.
2. Run *install-packages.R* to install the packages.

## Binary Packages

From the [R documentation](https://www.rdocumentation.org/packages/utils/versions/3.6.1/topics/install.packages#l_sections) for `utils::install.packages`:

> R packages are primarily distributed as *source* packages, but *binary* packages (a packaging up of the installed package) are also supported, and the type most commonly used on Windows and by the CRAN builds for macOS.  This function can install either type, either by downloading a file from a repository or from a local file.
> 
> Possible values of `type` are (currently) `"source"`, `"mac.binary"`, `"mac.binary.el-capitan"` and `"win.binary"`: the appropriate binary type where supported can also be selected as `"binary"`.

> Using packages with `type = "source"` always works provided the package contains no C/C++/Fortran code that needs compilation. Otherwise,
> 
> **on Windows** you will need to have installed the Rtools collection as described in the 'R for Windows FAQ' *and* you must have the `PATH` environment variable set up as required by Rtools.
> 
> **On Unix-alikes**, when the package contains C/C++/Fortran code that needs compilation, on macOS you need to have installed the 'Command-line tools for Xcode' (see the 'R Installation and Administration Manual') and if needed by the package a Fortran compiler, and have them in your path.

## Notes

The code in `get-packages.R` and `install-packages.R` is slightly modified from [this code](https://github.com/MangoTheCat/blog_installing_packages) from Graham Parsons.

In *get-packages.R*, core R packages are ignored when making the list of packages to download.
To include them, comment out the line `packages <- setdiff(packages, core.packages)`.

Similarly, *install-packages.R* ignores already-installed packages when installed the downloaded packages.
To install them anyway, comment out the line `downloaded <- setdiff(downloaded, installed)`.
