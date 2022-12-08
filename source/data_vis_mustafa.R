#Load Libraries
library("dplyr")
library("leaflet")
library("RColorBrewer")
library("rgdal")
library("ggplot2")
library("sp")

#Read Flight Data
flight_data <- read.csv("../data/AIRTRANS_CO2.csv", stringsAsFactors = F)

flight_data$Country[flight_data$Country == "China (People's Republic of)"] <- "China"
flight_data$Country[flight_data$Country == "Cabo Verde"] <- "Cape Verde"
flight_data$Country[flight_data$Country == "Côte d'Ivoire"] <- "Cote d'Ivoire"
flight_data$Country[flight_data$Country == "Democratic People's Republic of Korea"] <- "Korea, Democratic People's Republic of"
flight_data$Country[flight_data$Country == "Eswatini"] <- "Swaziland"
flight_data$Country[flight_data$Country == "Iran"] <- "Iran (Islamic Republic of)"
flight_data$Country[flight_data$Country == "Korea"] <- "Korea, Republic of"
flight_data$Country[flight_data$Country == "Libya"] <- "Libyan Arab Jamahiriya"
flight_data$Country[flight_data$Country == "Micronesia"] <- "Micronesia, Federated States of"
flight_data$Country[flight_data$Country == "Moldova"] <- "Republic of Moldova"
flight_data$Country[flight_data$Country == "Myanmar"] <- "Burma"
flight_data$Country[flight_data$Country == "North Macedonia"] <- "The former Yugoslav Republic of Macedonia"
flight_data$Country[flight_data$Country == "Slovak Republic"] <- "Slovakia"
flight_data$Country[flight_data$Country == "Tanzania"] <- "United Republic of Tanzania"
flight_data$Country[flight_data$Country == "Türkiye"] <- "Turkey"

#Read Shape Data
world_spdf <- readOGR( 
  dsn= paste0("world_shape_file/") , 
  layer="TM_WORLD_BORDERS_SIMPL-0.3",
  verbose=FALSE
)

get_filtered_flight_data <- function(year) {
  filtered_flight_data <- flight_data %>% 
    group_by(Country) %>% 
    filter(TIME == year) %>% 
    filter(Value == max(Value)) %>% 
    distinct(Value)
  return(filtered_flight_data)
}

get_filtered_flight_data_map <- function(year) {
  filtered_flight_data <- get_filtered_flight_data(year)
  
  colnames(filtered_flight_data)[1] <- "NAME"
  world_spdf_with_values <- sp::merge(world_spdf, filtered_flight_data, by = "NAME", all=F)
  
  #Create Map
  mybins <- c(0,500000,1000000,5000000, 10000000,50000000,250000000)
  mypalette <- colorBin( palette="YlOrBr", domain=world_spdf_with_values@data$Value, na.color="transparent", bins = mybins)
  
  mytext <- paste(
    "Country: ", world_spdf_with_values@data$NAME,"<br/>", 
    "Value: ", round(world_spdf_with_values@data$Value),
    sep="") %>%
    lapply(htmltools::HTML)
  
  value_map <- leaflet(world_spdf_with_values) %>% 
    addTiles()  %>% 
    setView( lat=10, lng=0 , zoom=1) %>%
    addPolygons( 
      fillColor = ~mypalette(Value), 
      stroke=TRUE, 
      fillOpacity = 0.9, 
      color="black", 
      weight=0.9,
      label = mytext,
      labelOptions = labelOptions( 
        style = list("font-weight" = "normal", padding = "3px 8px"), 
        textsize = "13px", 
        direction = "auto"
      )
    ) %>%
    addLegend( pal=mypalette, values=~Value, opacity=0.9, title = "Value", position = "bottomleft" )
  
  value_map
}