
library(tidyverse)



#Co2 Dataset
Co2_Dataset <- read.csv("/Users/rmjos/Downloads/AIRTRANS_CO2.csv")

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

small_co2 <- head(adjusted_co2, 10)

View(small_co2)



#historical emissions data set
historical_emissions <- read.csv("/Users/rmjos/Downloads/historical_emissions.csv")
View(historical_emissions)

adjusted_historical_emissions <- historical_emissions %>% 
  group_by(Country) %>% 
  select(-2, -3)

View(adjusted_historical_emissions)



#df1_new<-as.data.frame(t(df1))
#df1_new

#m1 <- t(df1)
#d2 <- data.frame(r1= row.names(m1), m1, row.names=NULL)

historical_emissions_new <- as.data.frame(t(adjusted_historical_emissions))

historical_emissions_new_v1 <- as.data.frame(t(historical_emissions_new))

View(historical_emissions_new)





#US passenger dataset
passenger_dataset <- read.csv("/Users/rmjos/Downloads/International_Report_Passengers.csv")

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


small_passenger_ds <- head(adjusted_passenger_dataset, 10)

View(small_passenger_ds)


#combined datasets


smol_combined <- 
  merge(
    x = small_co2,
    y = small_passenger_ds,
    by = "Year",
    all = TRUE
  )

View(smol_combined)






