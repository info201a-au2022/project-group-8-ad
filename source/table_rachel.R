
library(tidyverse)

memory.limit()



#Co2 Dataset
Co2_Dataset <- read.csv("../data/AIRTRANS_CO2.csv")

View(Co2_Dataset)

Co2_Dataset <- Co2_Dataset %>% 
  mutate(TIME = as.numeric(TIME)) %>% 
  rename("Year" = TIME )

View(Co2_Dataset)


adjusted_co2 <- Co2_Dataset %>% 
  group_by(Country) %>% 
  filter(Flight.type == "Passenger flights", na.rm = TRUE) %>% 
  summarize(
    Country, 
    Flight.type,
    Year,
    Pollutant,
    SOURCE,
    Source.of.emissions,
    Value
    )

View(adjusted_co2)



#historical emissions data set
historical_emissions <- read.csv("../data/historical_emissions.csv")
View(historical_emissions)

adjusted_historical_emissions <- historical_emissions %>% 
  group_by(Country) %>% 
  select(-2, -3)

View(adjusted_historical_emissions)



#df1_new<-as.data.frame(t(df1))
#df1_new

#m1 <- t(df1)
#d2 <- data.frame(r1= row.names(m1), m1, row.names=NULL)

historical_emissions_new <- as.data.frame(t(historical_emissions))

View(historical_emissions_new)

H_E_v1 <- t(historical_emissions_new[country])
H_E_v2<- data.frame(r1= row.names(H_E_v1), H_E_v1, row.names= NULL)

View(H_E_v2)

#US passenger dataset
passenger_dataset <- read.csv("../data/International_Report_Passengers.csv")

View(passenger_dataset)


passenger_dataset <- passenger_dataset %>% 
  rename(
    "US_gateway_Code" = usg_apt,
    "Gateway_world_areacode" = usg_wac,
    "US_Airport_ID" = usg_apt_id,
    "Foreign_gateway_ID" = fg_apt_id,
    "Foreign_gateway_world_code" = fg_wac,
    "Foreign_Airport_code" = fg_apt
  )

View(passenger_dataset)



adjusted_passenger_dataset <- passenger_dataset %>% 
  group_by(Year) %>% 
  summarize(
    Year,
    type,
    Charter,
    Total
  )

View(adjusted_passenger_dataset)



#combined datasets


combined_Datasets <- 
  merge(
  x = adjusted_co2,
  y = adjusted_passenger_dataset,
  by = "Year",
  all = TRUE
)





combined_datasets <- merge(adjusted_co2, adjusted_passenger_dataset)

View(combined_datasets)



