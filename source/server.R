library(shiny)
library(ggplot2)

source("data_vis_mustafa.R")

shinyServer(function(input, output) {
  
  output$co2_map <- renderLeaflet({
    get_filtered_flight_data_map(input$map_slider)
  })
  
})