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