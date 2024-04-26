library(shiny)
library(shinydashboard)
library(tidyverse)
library(ggplot2)

x <- read.csv("../resources/Clean/clean-Happiness.csv")
cleaned_abortion_data <- x