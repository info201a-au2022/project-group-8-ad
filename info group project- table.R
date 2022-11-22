
library(tidyverse)



#Co2 Dataset
Co2_Dataset <- read.csv("/Users/rmjos/Downloads/AIRTRANS_CO2.csv")

View(Co2_Dataset)


adjusted_co2 <- Co2_Dataset %>% 
  group_by(Country) %>% 
  filter(Flight.type == "Passenger flights", na.rm = TRUE) %>% 
  summarize(
    Country, 
    Flight.type,
    TIME,
    Pollutant,
    SOURCE,
    Source.of.emissions,
    Value
    )

View(adjusted_co2)




#historical emissions data set
historical_emissions <- read.csv("/Users/rmjos/Downloads/historical_emissions.csv")
View(historical_emissions)



adjusted_historical_emissions <- historical_emissions %>% 
  group_by(Country) %>% 
  select(-2, -3)

View(adjusted_historical_emissions)




#US passenger dataset
passenger_dataset <- read.csv("/Users/rmjos/Downloads/International_Report_Passengers.csv")

View(passenger_dataset)


passenger_dataset <- passenger_dataset %>% 
  rename(
    "US_Gateway_Airport_ID" = usg_apt,
    "World_Gateway_code" = usg_wac
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





