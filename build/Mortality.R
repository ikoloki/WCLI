library(rvest)
library(purrr)
library(stringr)

Dom <- read_html('../resources/Mortality/Mortality.???')
state_names <- Dom |>
    html_nodes('td[style="text-align:left"]') |>
    html_text() |>
    map(function(state_name) {
        # That is not an underscore its some werid unicode char
        # DO NOT TOUCH
        gsub(" | \\*",'',state_name)  
    })


ui <- dashboardPage(
    dashboardHeader(title = "Abortion Data Plot"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Abortion Data", tabName = "abortion", icon = icon("tree")),
            menuItem("README", tabName = "readme", icon = icon("book"))
        )
  ),
  dashboardBody(
    tabItems(
      tabItem("abortion", 
              box(
                plotOutput("plot"), 
                width = 8),
              box(
                selectInput(inputId = "var_y", 
                            label = "Select Y:", 
                            choices = colnames(x)[State]),
                width = 8
              )
      ),
      tabItem("readme",
              fluidPage(
                h1("Information"),
                textOutput("readme_info")
              )
      )
    )
  )
)

state_data <- html_nodes(Dom, xpath = "\\td), '\\d+\\.\\d+')]")
