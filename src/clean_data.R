library(tidyverse)
library(readr)

resource_table <- read.csv("../build/CSV/resource_link_table.csv", header = FALSE, stringsAsFactors = FALSE)
resource_table <- as.data.frame(resource_table)
