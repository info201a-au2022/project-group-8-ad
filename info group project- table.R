

library(tidyverse)



#Co2 Dataset
Co2_Dataset <- read.csv("/Users/rmjos/Downloads/AIRTRANS_CO2.csv")

View(Co2_Dataset)

Co2_Dataset <- Co2_Dataset %>% 
  rename("Year" = Time )

View(Co2_Dataset)


adjusted_co2 <- Co2_Dataset %>% 
  group_by(Country) %>% 
  filter(Flight.type == "Passenger flights", na.rm = TRUE) %>%
  filter(Country == "United States", na.rm = TRUE) %>% 
  subset(Year> "2016" & Year < "2021") %>% 
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

small_co2 <- head(adjusted_co2, 200)

View(small_co2)



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

passenger_dataset_1 <- passenger_dataset %>% 
  summarize(
    Year,
    type,
    Charter,
    Total
  ) %>% 
  subset(Year> "2016" & Year < "2021")
  
  View(passenger_dataset_1)

passenger_dataset_smol <- head(passenger_dataset_1, 200)


#US Departures

departure_dataset <- read.csv("/Users/rmjos/Downloads/International_Report_Departures.csv")

View(departure_dataset)



departure_dataset <- departure_dataset %>% 
  rename(
    "US_gateway_Code" = usg_apt,
    "Gateway_world_areacode" = usg_wac,
    "US_Airport_ID" = usg_apt_id,
    "Foreign_gateway_ID" = fg_apt_id,
    "Foreign_gateway_world_code" = fg_wac,
    "Foreign_Airport_code" = fg_apt
  )

departure_dataset_1 <- departure_dataset %>% 
  summarize(
    Year,
    type,
    Charter,
    Total
  ) %>% 
  subset(Year> "2016" & Year < "2021")
  
View(departure_dataset_1)

departure_dataset_smol <- head(departure_dataset_1, 200)

View(departure_dataset_smol)


#combining


smol_combined_partial <- 
  merge(
    x = passenger_dataset_smol,
    y = departure_dataset_smol,
    by = "Year"
  )

smol_all_combined <- 
  merge(
    x = smol_combined_partial,
    y = small_co2,
    by = "Year"
  )

View(smol_all_combined)












