#!/usr/bin/env Rscript

library(tidyverse)
library(readr)
library(tools)
library(datasets)

files <- list.files("../resources/Clean/", full.names = TRUE)  # full.names = TRUE to get full file paths
csv_files <- files[grepl("\\.csv$",files)]
csv_files <- csv_files[!grepl("clean-master-data.csv",csv_files)]

st <- tibble(State = state.name, Region = state.region)
loaded_files <- lapply(csv_files, read.csv)
loaded_files <- append(loaded_files, list(st))

merged_table <- Reduce(function(x, y) {merge.data.frame(x, y, by = "State", all = TRUE)}, loaded_files)

write.csv(merged_table, '../resources/Clean/clean-master-data.csv')
