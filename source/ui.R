library(shiny)
library(ggplot2)
library(markdown)

source("data_vis_mustafa.R")
source("data_vis_antong.R")
source("data_vis_xiaoyu.R")

page_one <- tabPanel(
  "Introduction",
  titlePanel(img(src = "plane.jpg")),
  
  headerPanel("Introduction"),
  
  mainPanel(
    p("Almost every year over 22 million flights occur worldwide (Salas, 2022) with nearly 90 million people (Aviation Beyond Borders) working together to achieve this goal. 
    Although air travel is seen as one of the safest and most efficient ways of travel, it comes at a cost of byproducts such as CO2 emissions. "),
    p(),
    h4("What is the problem domain?"),
    p("With climate change harming the planet, one of the main concerns with air travel is how much CO2 is produced. CO2 is directly linked to warming the atmosphere, shrinking the ozone layer, and eroding the earth’s natural protection against harmful UV rays from the sun. Some of the negative can be seen through melting glaciers that contribute to rising sea levels. 
      The outcome comes at a cost of damaging, engulfing, and even submerging natural ecosystems and pacific islands. 
      Government officials from all over the world have pledged their efforts to stop and reverse climate change in response to the research."),
    p(),
    h4("What are the research questions?"),
    p("In our research project, we examined patterns of air traffic in the US and globally through 3 questions:  
  
  What countries produce the  highest and lowest CO2 emissions?
  How did COVID-19 play a role in affecting CO2 emissions?
  Does the number of domestic and international flights in a country impact total CO2 emissions?"),
    p(),
    h4("What data was analyzed?"),
    p("The first dataset is titled “Air Transport CO2 Emissions,” and is published on the
      OECD Statistics. The Organisation for Economic Co-operation and Development (OCED) is
      an international organizations that supports economic and free market growth through
      its work supported by 38 countries globally. This information was compiled by the
      International Civil Aviation Organization (ICAO), an agency of the United Nations.
      This dataset provides information about the CO2 emissions of countries from 2014 to 2018."),
    p(),
    p("The second dataset we used is titled “TSA Checkpoint travel numbers”. This dataset was
      compiled by the Transportation Safety Administration (TSA) in response to the COVID-19
      pandemic, collecting data on how air travel was impacted. The Transportation Safety
      Administration is an agency of the US federal government who oversees all transportation
      in and out of the US. The dataset has been compiling data related to passenger influx
      since December of 2021 and continues to stay updated to date on a daily basis."),
    p(),
    p("Finally, our third dataset is titled “Carbon Dioxide Emissions of the World” . The data 
      was compiled by Ankan Hore, a data analyst from India with the source being from Climate
      Watch Data. Climate Watch Data is seen as a leader in the climate change space and is
      partnered with global organizations and corporations to aid in their efforts. The dataset
      provides information regarding CO2 emissions for countries around the world from 1990 to
      2018."),
    p(),
    h4("What are the key findings?"),
    p("1. The United States, China, and the UAE are shown to have the highest CO2 emissions. 
    All three of these countries are major contributors when it comes to international trade. 
    This could point to trade being a bigger aspect of CO2 emissions than previously thought. 
    Through this lens, experts can reframe efforts in reducing emissions and focus on where the greatest CO2 emissions are in international trading."),   
    
    p("2. In 2020 the amount of passengers dramatically decreased in the wake of covid. Even several years since the start of the pandemic, the passenger rates have not returned to pre covid levels. 
  The decreased passenger levels could indicate that CO2 emissions have decreased because of lower passenger rates."),  
    
    p("3. In comparing flight transportation with over all transportation per country, countries with higher flight emissions also lead with overall transportation CO2 emissions. 
  The finding also showed that emissions from flights did not make up over half of overall emissions from the countries analyzed. 
  Although air transportation makes up a substantial part of CO2 emissions, there are still other major factors in CO2 emissions outside of flights."),
    p()
  )
)

page_two <- tabPanel(
  "Interactive Panel One", 
  headerPanel("What countries produce the lowest/highest CO2 emissions?"),
  sidebarPanel(
    sliderInput("map_slider", label = h3("Select Year"), min = 2014, 
                max = 2022, value = 2014),
    p("Data from: AIRTRANS_CO2.csv")
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
  headerPanel("How does the number of aircraft flights affect co2 emissions?"),
  sidebarPanel(
    sliderInput("flight_count_slider", label = h3("flight count"), min = 100, max = 200, value = c(140, 160)),
    p("Data from: AIRTRANS_CO2.csv, historical_emissions.csv")
  ),
  mainPanel(
    plotOutput("flight_bar", height = "650px"),
    plotOutput("co2_bar", height = "650px"),
    h4("Chart Summary"),
    p("Then, regarding our second research question, which aims to investigate ‘whether the
      number of aircraft flights in a country determines its total level of CO2 emissions,’
      we present information from two perspectives, showing the total number of flights in
      each country from 2014 to 2018 and the comparison of CO2 emissions between aircraft and
      all factors that can generate CO2 gases. And to deepen the criticality of the studied
      relationship between flights and CO2 emissions, which is the main objective of this issue,
      we as page designers set up a slider range capable of controlling the number of flights
      so that one can simultaneously view the countries corresponding to any number range
      between 100 and 200 for this number of flights and their corresponding total air
      transport and CO2 emissions (generated by all possible factors). Overall, this page is
      intended to provide ease of observation and to highlight the impact of aircraft
      activation on CO2 emissions.")
  )
)
page_four <- tabPanel(
  "Interactive Panel Three", 
  headerPanel("How did passengers and CO2 emissions change during 2019 to 2022?"),
  sidebarPanel(
    checkboxGroupInput("yearcheckGroup", label = h3("Year Checkbox"), 
                       choices = list("2019" = 2019, "2020" = 2020, "2021" = 2021, "2022" = 2022),
                       selected = 2019),
    p("Data from: AIRTRANS_CO2.csv, Air_Travel_Passengers.csv")
  ),
  mainPanel(
    plotOutput("CO2_emissions"), 
    plotOutput("number_passengers"),
    h4("Chart summary"),
    p("Finally, for our last research question, we would like to investigate
      ‘How did the number of flights during COVID-19 play a role in changing CO2 emissions.’
      Therefore, here we compared the number of passengers in the U.S. with the value of CO2
      emissions during the pandemic, that is, from 2019 to 2022. In this section, we made two
      charts showing CO2 emissions data and airplane passenger numbers respectively.
      To give the viewer a better visual representation of how the pandemic affects and
      determines the trends in the number of flights and CO2 emissions, in this section
      there is a ‘Year Checkbox’ that one can select from a range of 2019 to 2022 to check
      the data for a single year or for multiple years. Overall, the “Year checkbox” allows
      us to see the flow of changes more clearly in these two data.")
  )
)


page_five <- tabPanel(
  "Summary",
  titlePanel("Summary"),
  
  mainPanel(
    h4("Takeaway #1"),
    p("The countries who were leaders in high CO2 emissions were consistently leading on our other datasets.
      Countries such as the United States, China, and the UAE were consistently high in overall CO2 rates and flight emissions. 
      There was no significant difference between the 2 sets when it came to leaders in emission levels. "),
    p(),
    h4("Takeaway #2"),
    p("COVID-19 impacted the airline industry significantly. Even before pandemic, the US can be seen as leaders in all out datasets when it comes to CO2 emissions. 
      When the pandemic occurred, US passenger levels fell significantly in 2020 and have yet to return in 2022. 
      Even the borders opening up globally, passengers haven’t returned in the volume they had before the pandemic."),
    p(),
    h4("Takeaway #3"),
    p("Economic world leaders had a tendency to emit more CO2 emissions. 
      Economic superpowers such as the US and China were shown to emit the most CO2 levels. 
      As the biggest contributors, climate change efforts should be concentrated in these countries. 
      These countries are seen as developed countries with resources and international leverage to create lasting and impactful. 
      Their efforts in reducing CO2 emissions in the airline industry would help reduce CO2 emissions worldwide and provide an example for countries whose CO2 emissions are lower.")
  )
)

page_six <- tabPanel(
  "Report",
  
  mainPanel(
    includeMarkdown("../docs/p01-proposal.md")
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


