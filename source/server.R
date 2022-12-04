library(shiny)
library(ggplot2)

source("data_vis_mustafa.R")

shinyServer(function(input, output) {

  output$co2_map <- renderLeaflet({
      value_map
  })
})
