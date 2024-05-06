library(shiny)
library(shinydashboard)
library(shinythemes)
library(tidyverse)
library(ggplot2)

data <- read.csv("./clean-master-data.csv")

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

output$plot <- renderPlot({
    ggplot(data, aes(x = reorder(State, -WQLI), y = WQLI)) +
        geom_bar(stat = "identity", fill = "skyblue") +
        labs(x = "State", y = "WQLI", title = "Women's Quality of Life Index (WQLI) by State") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
})
    
  output$correlation_plot <- renderPlot({
      ggplot(data, aes_string(x = input$corr_plot_x, y = input$corr_plot_y)) +
        geom_point() +
        labs(x = input$corr_plot_x, y = input$corr_plot_y, title = "Correlation Plot") +
          theme_minimal() + theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
    output$Sources <- renderUI({
        tags$li(tags$a("Abortion Data", href = "https://lawatlas.org/datasets/abortion-bans?"),
                tags$a("Happiness Data", href = "https://wallethub.com/edu/happiest-states/6959?"),
                tags$a("Life Expectancy", href = "https://data.cdc.gov/api/views/a5a8-jsrq/rows.csv?accessType=DOWNLOAD&bom=true&format=true"),
                tags$a("Pregnancy", href = "https://www.cdc.gov/nchs/data/databriefs/db21_table2.pdf"))
        })
  
    output$Learn <- renderText({
        "to fight for gender equality it is very important to keep up todate with the latests statistics of womens rights across the nation"
  })
}

shinyApp(ui, server)