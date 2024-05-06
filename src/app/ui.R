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