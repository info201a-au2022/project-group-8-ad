library(shiny)
library(ggplot2)

source("data_vis_mustafa.R")

shinyServer(function(input, output) {
  
  output$co2_map <- renderLeaflet({
    get_filtered_flight_data_map(input$map_slider)
  })
<<<<<<< HEAD
  output$CO2_emissions <- renderPlot({
    data_visualization_1(input$yearcheckGroup)
  })
  output$number_passengers <- renderPlot({
    data_visualization_2(input$yearcheckGroup)
  })
})

=======
  output$flight_bar <- renderPlot({
    get_flight_chart(input$flight_count_slider[2],input$flight_count_slider[1])
  })
    output$co2_bar <- renderPlot({
      get_co2_chart(input$flight_count_slider[2],input$flight_count_slider[1])
  })
})
>>>>>>> 5ec4f7a880b13574a5f2e366c6d94859845e1764
