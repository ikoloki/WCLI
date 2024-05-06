server <- function(input, output) {

map_data <- map_data("state")

merged_data <- merge(map_data, data, by.x = "region", by.y = "State", all.x = TRUE)

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
