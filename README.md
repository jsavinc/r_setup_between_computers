# r_setup_between_computers

I'll keep this updated with the list of packages I use at work, so that I can setup a new instance of R & RStudio when changing computers easily.

The main inspiration comes from [Tom Jemmett's gist here](https://gist.github.com/tomjemmett/5033cdf5ca078e3d254db803b7b65f7a), but also from this [NHS-R community post](https://nhsrcommunity.com/blog/a-simple-function-to-install-and-load-packages-in-r/).

## Usage

To save the list of packages, run `install_list_of_packages.r` - this compiles all `CRAN` and `GitHub`-installed packages. If there is an existing `packages_to_install.rds` file from before, the list of packages will be merged between the existing file and the currently installed packages.

To install packages, run `install_list_of_packages.r`.
