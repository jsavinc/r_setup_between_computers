## cribbed from Tom Jemmett
## https://gist.github.com/tomjemmett/5033cdf5ca078e3d254db803b7b65f7a#file-reinstall_packages-r

list_of_existing_packages_to_install <- readRDS("./packages_to_install.rds")
install.packages(list_of_existing_packages_to_install$CRAN)
devtools::install_github(list_of_existing_packages_to_install$GitHub)