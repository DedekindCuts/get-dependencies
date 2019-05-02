# script for offline installing a list of packages from pre-downloaded binaries

# type of binaries to be installed (one of "win.binary" (for Windows) or "source" (for Mac))
bin.type <- "win.binary"

# the location of the package files
bin.path <- "TARGET_FOLDER"

# change to the target directory
setwd(bin.path)

# Read the package filenames and install
pkgFilenames <- read.csv("pkgFilenames.csv", stringsAsFactors = FALSE)[, 1]
install.packages(pkgFilenames, repos = NULL, type = bin.type)
