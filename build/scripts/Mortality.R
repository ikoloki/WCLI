library(rvest)
library(purrr)
library(stringr)

Dom <- read_html('../resources/Mortality/Mortality.???')
state_names <- Dom |>
    html_nodes('td[style="text-align:left"]') |>
    html_text() |>
    map(function(state_name) {
        ## That is *NOT* an underscore its some werid unicode char
        ## DO NOT TOUCH
        gsub(" | \\*",'',state_name)  
    })

state_data <- html_nodes(Dom, xpath = "\\td), '\\d+\\.\\d+')]")
