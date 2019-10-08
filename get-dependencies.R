# script for downloading a list of R packages and their dependencies

# 
# Configuration
# -----------------------------------------------------------------------------

# type of packages to download (one of "source", "mac.binary", 
# "mac.binary.el-capitan", or "win.binary"––see README for more information)
type <- "mac.binary.el-capitan"

# list of package names
packs <- c("data.table")

# where to save the packages
pkg.path <- "./downloads/"

# 
# Download packages
# -----------------------------------------------------------------------------

#' get package dependencies
#'
#' @param packs A string vector of package names
#'
#' @return A string vector with packs plus the names of any dependencies
getDependencies <- function(packs){
  dependencyNames <- unlist(
    tools::package_dependencies(packages = packs, db = available.packages(), 
                                which = c("Depends", "Imports"),
                                recursive = TRUE))
  packageNames <- union(packs, dependencyNames)
  packageNames
}

# get list of needed packages and all dependencies
print("Getting dependencies...")
packages <- getDependencies(packs)

# remove any core packages
core.packages <- c("base", "compiler", "datasets", "graphics", "grDevices", 
                   "grid", "methods", "parallel", "splines", "stats", "stats4", 
                   "tcltk", "tools", "utils")
packages <- setdiff(packages, core.packages)

# download the packages to the working directory (package names and filenames 
# are returned in a matrix)
print("Downloading packages...")
pkgInfo <- download.packages(pkgs = packages, destdir = pkg.path, 
                             type = type, quiet = TRUE)

# save just the package file names (basename() strips off the full paths 
# leaving just the filename)
write.csv(file = paste0(pkg.path, "pkgFilenames.csv"), basename(pkgInfo[, 2]), 
          row.names = FALSE)
