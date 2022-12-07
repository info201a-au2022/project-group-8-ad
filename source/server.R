library(shiny)
library(ggplot2)

source("data_vis_mustafa.R")

shinyServer(function(input, output) {
  
  output$co2_map <- renderLeaflet({
    get_filtered_flight_data_map(input$map_slider)
  })
  output$CO2_emissions <- renderPlot({
    data_visualization_1(input$yearcheckGroup)
  })
  output$number_passengers <- renderPlot({
    data_visualization_2(input$yearcheckGroup)
  })
})

