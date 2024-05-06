library(shiny)
library(shinydashboard)
library(shinythemes)
library(tidyverse)
library(ggplot2)

data <- read.csv("../resources/Clean/clean-master-data.csv")

ui <- navbarPage(
  title = "WQLI - Women's Quality Of Life Index",
  tabPanel(
      title = "Visualize Data", icon = icon("bar-chart"),
      mainPanel(
          plotOutput("plot")
      ),
),

  tabPanel(
    title = "Correlation Plot", icon = icon("chart-simple"),
    sidebarLayout(
        sidebarPanel(
            selectInput("corr_plot_x", "Select X axis", choices = colnames(data)),
            selectInput("corr_plot_y", "Select Y axis", choices = colnames(data))
        ),
      mainPanel(
        plotOutput("correlation_plot")
      )
    )
  ),

  tabPanel(
    title = "Learn More", icon = icon("book"),
    textOutput("Learn")
  ),

  tabPanel(
    title = "Sources", icon = icon("archive"),
    uiOutput("Sources")
  ),

  inverse = FALSE,
  theme = shinytheme("spacelab")
)

server <- function(input, output) {

map_data <- map_data("state")
# Merge your data with map_data based on State names
merged_data <- merge(map_data, data, by.x = "region", by.y = "State", all.x = TRUE)

# Plot the map
output$plot <- renderPlot({
    ggplot(data, aes(x = reorder(State, -WQLI), y = WQLI)) +
        geom_bar(stat = "identity", fill = "skyblue") +
        labs(x = "State", y = "WQLI", title = "Women's Quality of Life Index (WQLI) by State") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
})
    
  output$correlation_plot <- renderPlot({
      
  })
  
    output$Sources <- renderUI({
        tags$ul(
                 tags$li(
                          tags$a("Abortion Data:", href = "https://lawatlas.org/datasets/abortion-bans?")
                      ),
                 tags$a("Abortion Data:", href = "https://lawatlas.org/datasets/abortion-bans?"),
                 tags$a("Abortion Data:", href = "https://lawatlas.org/datasets/abortion-bans?")
             )
    })
  
    output$Learn <- renderText({
        "Women in this country are maltreated"
  })
}



shinyApp(ui, server)


