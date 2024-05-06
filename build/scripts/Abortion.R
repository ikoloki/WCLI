#!/usr/bin/env Rscript
library(dplyr)
library(purrr)

state_data <- read.csv("..//resources//Clean//clean-Abortion.csv", stringsAsFactors = FALSE)
state_data <- state_data |>
    rename(Effective_Date = Effective.Date)

state_data <- state_data |>
    rename(Valid_Through_Date = Valid.Through.Date)

state_data$Effective_Date <- as.Date(state_data$Effective_Date, format = "%Y/%m/%d")
state_data$Valid_Through_Date <- as.Date(state_data$Valid_Through_Date, format = "%Y/%m/%d")


state_data <- state_data[order(state_data$State, state_data$Effective_Date, decreasing = TRUE),]

recent_state_data <- distinct(state_data, State, .keep_all = TRUE)
# View(recent_state_data)
write.csv(recent_state_data,"..//resources//Clean//clean-Abortion.csv")