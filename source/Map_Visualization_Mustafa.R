#Load Libraries
library("dplyr")
library("leaflet")
library("RColorBrewer")
library("rgdal")
library("ggplot2")
library("maps")
library("sp")

#Read Flight Data
flight_data <- read.csv("../data/AIRTRANS_CO2.csv", stringsAsFactors = F)

#Read Shape Data
world_spdf <- readOGR( 
  dsn= paste0(getwd(),"/world_shape_file/") , 
  layer="TM_WORLD_BORDERS_SIMPL-0.3",
  verbose=FALSE
)

#Filter Flight Data
filtered_flight_data <- flight_data %>% 
  group_by(Country) %>% 
  filter(Value == max(Value)) %>% 
  distinct(Value)

#Combine dataframes
colnames(filtered_flight_data)[1] <- "NAME"
world_spdf_with_values <- sp::merge(world_spdf, filtered_flight_data, by = "NAME", all=F)

#Create Map
mybins <- c(0,500000,1000000,5000000, 10000000,50000000,250000000)
mypalette <- colorBin( palette="YlOrBr", domain=world_spdf_with_values@data$Value, na.color="transparent", bins = mybins)

mytext <- paste(
  "Country: ", world_spdf_with_values@data$NAME,"<br/>", 
  "Value: ", world_spdf_with_values@data$Value,
  sep="") %>%
  lapply(htmltools::HTML)

value_map <- leaflet(world_spdf_with_values) %>% 
  addTiles()  %>% 
  setView( lat=10, lng=0 , zoom=2) %>%
  addPolygons( 
    fillColor = ~mypalette(Value), 
    stroke=TRUE, 
    fillOpacity = 0.9, 
    color="white", 
    weight=0.3,
    label = mytext,
    labelOptions = labelOptions( 
      style = list("font-weight" = "normal", padding = "3px 8px"), 
      textsize = "13px", 
      direction = "auto"
    )
  ) %>%
  addLegend( pal=mypalette, values=~Value, opacity=0.9, title = "Value", position = "bottomleft" )

value_map

