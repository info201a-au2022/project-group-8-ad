library(shiny)
library(ggplot2)

source("data_vis_mustafa.R")

shinyServer(function(input, output) {
  
  output$co2_map <- renderLeaflet({
    get_filtered_flight_data_map(input$map_slider)
  })
  output$flight_bar <- renderPlot({
    get_flight_chart(input$flight_count_slider[2],input$flight_count_slider[1])
  })
    output$co2_bar <- renderPlot({
      get_co2_chart(input$flight_count_slider[2],input$flight_count_slider[1])
  })
})