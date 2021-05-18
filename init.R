# init.R
#
# Example R code to install packages if not already installed
#

my_packages = c("shiny", "colourpicker", "shinythemes", "thematic",
                "htmltools", "dplyr", "tidyr", "magick", "ggforce")

install_if_missing = function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {
    install.packages(p)
  }
}

system("Package Magick++ was not found in the pkg-config search path.
       Perhaps you should add the directory containing `Magick++.pc'
       to the PKG_CONFIG_PATH environment variable
       No package 'Magick++' found")
invisible(sapply(my_packages, install_if_missing))


