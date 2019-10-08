# script for offline installing a list of packages from pre-downloaded binaries

# 
# Configuration
# -----------------------------------------------------------------------------

# type of packages (one of "source", "mac.binary", "mac.binary.el-capitan", or 
# "win.binary"––see README for more information)
type <- "mac.binary.el-capitan"

# the location of the package files
pkg.path <- "./downloads/"

# 
# Install packages
# -----------------------------------------------------------------------------

# change to the target directory
starting.wd <- getwd()
setwd(pkg.path)

# read the package filenames
pkgFilenames <- read.csv("pkgFilenames.csv", stringsAsFactors = FALSE)[, 1]

# check against already installed packages
extensions <- list(
  "source" = ".tar.gz", 
  "mac.binary" = ".tgz", 
  "mac.binary.el-capitan" = ".tgz", 
  "win.binary" = ".zip"
)

downloaded <- gsub(extensions[[type]], "", pkgFilenames, fixed = TRUE)
installed <- installed.packages()
installed <- paste0(installed[, 1], "_", installed[, 3])
downloaded <- setdiff(downloaded, installed)

# install
if(length(downloaded) > 0){
  print("Installing packages...")
  install.packages(paste0(downloaded, extensions[[type]]), repos = NULL, 
                   type = type, quiet = TRUE)
} else {
  print("Desired packages already installed.")
}

# change back to the starting directory
setwd(starting.wd)
