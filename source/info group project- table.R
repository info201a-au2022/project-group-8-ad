

library(tidyverse)



#Co2 Dataset
Co2_Dataset <- read.csv("../data/AIRTRANS_CO2.csv")

# View(Co2_Dataset)

colnames(Co2_Dataset)[15] <- "Year"
# View(Co2_Dataset)


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

# View(adjusted_co2)

small_co2 <- head(adjusted_co2, 200)

# View(small_co2)



#US passenger dataset
passenger_dataset <- read.csv("../data/International_Report_Passengers.csv")

# View(passenger_dataset)

colnames(passenger_dataset)[4] <- "US_Airport_ID"
colnames(passenger_dataset)[5] <- "US_gateway_Code"
colnames(passenger_dataset)[6] <- "Gateway_world_areacode"
colnames(passenger_dataset)[7] <- "Foreign_gateway_ID"
colnames(passenger_dataset)[8] <- "Foreign_Airport_code"
colnames(passenger_dataset)[9] <- "Foreign_gateway_world_code"

passenger_dataset_1 <- passenger_dataset %>% 
  summarize(
    Year,
    type,
    Charter,
    Total
  ) %>% 
  subset(Year> "2016" & Year < "2021")

# View(passenger_dataset_1)

passenger_dataset_smol <- head(passenger_dataset_1, 200)


#US Departures

departure_dataset <- read.csv("../data/International_Report_Departures.csv")

# View(departure_dataset)

colnames(departure_dataset)[4] <- "US_Airport_ID"
colnames(departure_dataset)[5] <- "US_gateway_Code"
colnames(departure_dataset)[6] <- "Gateway_world_areacode"
colnames(departure_dataset)[7] <- "Foreign_gateway_ID"
colnames(departure_dataset)[8] <- "Foreign_Airport_code"
colnames(departure_dataset)[9] <- "Foreign_gateway_world_code"

departure_dataset_1 <- departure_dataset %>% 
  summarize(
    Year,
    type,
    Charter,
    Total
  ) %>% 
  subset(Year> "2016" & Year < "2021")

# View(departure_dataset_1)

departure_dataset_smol <- head(departure_dataset_1, 200)

# View(departure_dataset_smol)


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

# View(smol_all_combined)