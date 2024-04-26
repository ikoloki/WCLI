library(tidyverse)
library(readr)
library(tools)
library(tools)

## {
##     lst <- list()
##     for (file in list.files('../resources/Clean/')) {
##         if (file_ext(file) == 'csv') {
##             lst <- append(lst,list(read.csv(paste('../resources/Clean/',file, sep = ''))))
##         }
##     }
##     lst
## } |> reduce_left(anti_join

lst <- list()

for (file in list.files("../resources/Clean/")) {
    if (file_ext(file) == "csv") {
        lst <- append(lst, list(read_csv(paste("../resources/Clean/", file, sep = ""))))
    }
}