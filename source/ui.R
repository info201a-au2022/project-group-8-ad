library(shiny)
library(ggplot2)
library(DT)

page_one <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  
  mainPanel(
    h4("What is the problem domain?"),
    p("add text here..."),
    p(),
    h4("What are the research questions?"),
    p("add text here..."),
    p(),
    h4("What data was analyzed?"),
    p("add text here..."),
    p(),
    h4("What are the key findings?"),
    p("add text here..."),
    p()
  )
)

page_two <- tabPanel(
  "Interactive Panel One", 
  headerPanel("Interactive Panel One"),
  sidebarPanel(
    h2(strong("Widgets go here..."))
  ),
  mainPanel(
    leafletOutput("co2_map")
  )
)

page_three <- tabPanel(
  "Interactive Panel Two", 
  headerPanel("Interactive Panel Two"),
  sidebarPanel(
    h2(strong("Widgets go here..."))
  ),
  mainPanel(
    p("Charts go here...")
  )
)

page_four <- tabPanel(
  "Interactive Panel Three", 
  headerPanel("Interactive Panel Three"),
  sidebarPanel(
    h2(strong("Widgets go here..."))
  ),
  mainPanel(
    p("Charts go here...")
  )
)

page_five <- tabPanel(
  "Summary",
  titlePanel("Summary"),
  
  mainPanel(
    h4("Takeaway #1"),
    p("add text here..."),
    p(),
    h4("Takeaway #2"),
    p("add text here..."),
    p(),
    h4("Takeaway #3"),
    p("add text here...")
  )
)

page_six <- tabPanel(
  "Report",
  titlePanel("Report"),
  
  mainPanel(
    p("add text here...")
  )
)

ui <- fluidPage( 
  navbarPage (
    "Flight CO2 Exploration",
    page_one,
    navbarMenu (
      "Interactive Pages",
      page_two,
      page_three,
      page_four
    ),
    page_five,
    page_six
  )
) 
