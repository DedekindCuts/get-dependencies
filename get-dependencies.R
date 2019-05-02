# script for downloading binaries for a list of R packages and their dependencies

# type of binaries to download (one of "win.binary" (for Windows) or "source" (for Mac))
bin.type <- "win.binary"

# list of package names
packs <- c(
  "SAMPLE_PACKAGE_NAME_1", 
  "SAMPLE_PACKAGE_NAME_2"
)

# where to save the binaries
dest.path <- "DESTINATION_FOLDER"

#' Get package dependencies
#'
#' @param packs A string vector of package names
#'
#' @return A string vector with packs plus the names of any dependencies
getDependencies <- function(packs){
  dependencyNames <- unlist(
    tools::package_dependencies(
      packages = packs, db = available.packages(), 
      which = c("Depends", "Imports"),
      recursive = TRUE
    )
  )
  packageNames <- union(packs, dependencyNames)
  packageNames
}

packages <- getDependencies(packs)

# Download the packages to the working directory.
# Package names and filenames are returned in a matrix.
pkgInfo <- download.packages(pkgs = packages, destdir = dest.path, type = bin.type)
# Save just the package file names (basename() strips off the full paths leaving just the filename)
write.csv(file = paste0(dest.path, "pkgFilenames.csv"), basename(pkgInfo[, 2]), row.names = FALSE)
