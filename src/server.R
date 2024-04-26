server <- function(input, output) {
  
    output$plot <- renderPlot({
        ggplot(data = cleaned_abortion_data, aes_string(x = "State", y = input$var_y)) + 
            geom_point() +
            labs(y = input$var_x, x = input$var_y) +
            theme_bw() +
            theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
  })
  
  output$readme_info <- renderText({
    "This app is used to visualize data from the abortion dataset. Use the menu to select the X and Y variables."
  })
}
