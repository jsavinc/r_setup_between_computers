## cribbed from Tom Jemmett
## https://gist.github.com/tomjemmett/5033cdf5ca078e3d254db803b7b65f7a#file-reinstall_packages-r

library(tidyverse)

figure_out_repository <- function(package) {
  pd <- packageDescription(package)
  
  if (!is.null(pd$Repository)) return (pd$Repository)
  
  if (!is.null(pd$GithubRepo)) return (paste(pd$GithubUsername, pd$GithubRepo, sep = "/"))
  
  as.character(NA)
}

packages_to_install <- tibble(package = installed.packages(priority = "NA")[,"Package"]) |>
  mutate(source = map_chr(package, figure_out_repository)) |>
  filter(!is.na(source)) |>
  mutate(s = ifelse(source == "CRAN", source, "GitHub"),
         p = ifelse(source == "CRAN", package, source))
  
packages_to_install |>
  group_by(s) |>
  summarise(across(p, list)) |>
  (\(.x) set_names(.x$p, .x$s))() |>
  saveRDS("./packages_to_install.rds")

# once R has reinstalled

p <- readRDS("./packages_to_install.rds")
install.packages(p$CRAN)
devtools::install_github(p$GitHub)