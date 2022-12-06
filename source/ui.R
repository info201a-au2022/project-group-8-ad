library(shiny)
library(ggplot2)
library(DT)

source("data_vis_mustafa.R")

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
    p("The United States, China, and the UAE are shown to have the highest CO2 emissions. 
    All three of these countries are major contributors when it comes to international trade. 
    This could point to trade being a bigger aspect of CO2 emissions than previously thought. 
    Through this lens, experts can reframe efforts in reducing emissions and focus on where the greatest CO2 emissions are in international trading. 

  In 2020 the amount of passengers dramatically decreased in the wake of covid. Even several years since the start of the pandemic, the passenger rates have not returned to pre covid levels. 
  The decreased passenger levels could indicate that CO2 emissions have decreased because of lower passenger rates. 
  
  In comparing flight transportation with over all transportation per country, countries with higher flight emissions also lead with overall transportation CO2 emissions. 
  The finding also showed that emissions from flights did not make up over half of overall emissions from the countries analyzed. 
  Although air transportation makes up a substantial part of CO2 emissions, there are still other major factors in CO2 emissions outside of flights. 
"),
    p()
  )
)

page_two <- tabPanel(
  "Interactive Panel One", 
  headerPanel("Interactive Panel One"),
  sidebarPanel(
    sliderInput("map_slider", label = h3("Select Year"), min = 2014, 
                max = 2022, value = 2014)
  ),
  mainPanel(
    leafletOutput("co2_map"),
    h4("Chart Summary"),
    p("One of our research questions aimed to determine which countries were producing the
      most/least CO2 from flights. The choropleth map allows us to do just that. The map
      displays labels for every country and its corresponding name making the data easy to
      view. The map is binned by color which makes it easy to pinpoint which countries are
      producing the most/least CO2. For example, to find the greatest CO2 producer we would
      look at the greatest bin and search for countries highlighted in that color on the
      map. From there we compare the countries and find the greatest CO2 producer, the USA.
      The same method can be used to find the lowed flight CO2 producers. Overall, this map
      allows us to effectively pin point the most/least flight CO2 producers and answer our
      research question.")
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