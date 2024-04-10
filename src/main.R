library(shiny)
library(shinydashboard)
library(tidyverse)
library(ggplot2)

data <- iris
x <- read.csv("../resources/Abortion/Clean/SumAborition.csv")
cleaned_abortion_data <- x

# Specify the UI for the app
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
                            choices = colnames(x)[-1]),
                width = 2
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

# Specify how R should run code / display output
server <- function(input, output) {
  
  output$plot <- renderPlot({

    ggplot(data = cleaned_abortion_data, aes_string(x = "State", y = input$var_y)) + 
  geom_point() +
  labs(y = input$var_x, x = input$var_y) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))

    
 #      ggplot(data = cleaned_abortion_data, aes_string(x = "State", y = input$var_y)) + 
#  geom_point() +
#  labs(y = input$var_x, x = input$var_y) +
#  theme_bw() +
#  theme(axis.text.x = element_text(angle = 90, hjust = 1))

    
    # ggplot(data = cleaned_abortion_data, aes_string(x = "State", y = input$var_y)) + 
#      geom_point() +
#      labs(y = input$var_x, x = input$var_y) +
 #     theme_bw()
  })
  
  output$readme_info <- renderText({
    "This app is used to visualize data from the abortion dataset. Use the menu to select the X and Y variables."
  })
}

app <- shinyApp(ui, server)