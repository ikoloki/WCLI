#!/usr/bin/env Rscript
library(dplyr)
library(purrr)

new_tibble = tibble()
state_data <- read.csv("..//resources//Clean//clean-Abortion.csv")
View(state_data)
for (state_data in split_data) {
    state_last_row <- map(state_data, ~tail(., n = 1))
    new_tibble <- bind_rows(new_tibble, state_last_row)
}
View(new_tibble)
# write.csv(new_tibble, "..//resources//Clean//clean-Abortion.csv")