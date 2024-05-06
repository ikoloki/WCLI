#!/usr/bin/env Rscript

data <- read.table(file("stdin"), header = TRUE, sep = ",", na.strings = "NA")
data_numeric <- data[, 4:ncol(data)]
data$WQLI <- rowSums(data_numeric, na.rm = TRUE)
write.csv(data, file = "../resources/Clean/tmp.csv", row.names = FALSE)
