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

## if there is an existing file from before, merge the previous and current packages
if (file.exists("./packages_to_install.rds")) {
  list_of_existing_packages_to_install <- readRDS("./packages_to_install.rds")
  
  packages_to_install <-
    bind_rows(
      packages_to_install,
      tibble::tibble(package = list_of_existing_packages_to_install$CRAN, source = "CRAN", s = "CRAN") |> mutate(p=package),
      tibble::enframe(list_of_existing_packages_to_install$GitHub, name = "package", value = "source") |> mutate(s="GitHub", p=source)
    ) %>%
    distinct
}

packages_to_install |>
  group_by(s) |>
  summarise(across(p, list)) |>
  (\(.x) set_names(.x$p, .x$s))() |>
  saveRDS("./packages_to_install.rds")

## nuclear option - if something's gone wrong, uncomment below
# file.remove("./packages_to_install.rds")