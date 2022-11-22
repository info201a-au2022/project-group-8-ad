
library(tidyverse)



#lowest_in_each_state <- counties %>% 
#group_by(state)%>%
#  filter(date == max(date, na.rm = TRUE)) %>% 
#  filter(deaths == min(deaths, na.rm = TRUE)) %>% 
#  pull (location)

#View(lowest_in_each_state)


Co2_Dataset <- read.csv("/Users/rmjos/Downloads/AIRTRANS_CO2.csv")

View(Co2_Dataset)


adjusted_co2 <- Co2_Dataset %>% 
  group_by(Country) %>% 
  filter(Flight.type == "Passenger flights", na.rm = TRUE) %>% 
  summarize(
    Country, 
    Flight.type,
    TIME,
    SOURCE,
    Source.of.emissions
    )

View(adjusted_co2)

passenger_dataset <- read.csv("/Users/rmjos/Downloads/International_Report_Passengers.csv")

View(passenger_dataset)


passenger_dataset <- passenger_dataset %>% 
  rename(
    "usg_apt_id" == "US Gateway Airport ID",
    "usg_apt" == "Gateway Airport ID",
    "usg_wac" == "World Gateway code"
  )




adjusted_passenger_dataset <- passenger_dataset %>% 
  group_by(Year) %>% 
  summarize(
    Year,
    type,
    Charter,
    Total
  )

View(adjusted_passenger_dataset)


departure_dataset <- read.csv("/Users/rmjos/Downloads/International_Report_Departures.csv")

View(departure_dataset)




