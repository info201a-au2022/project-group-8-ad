library(dplyr)
library(ggplot2)
library(plotly)
library(tidyverse)
library(tidyr)


airtransportation <- read.csv("../data/AIRTRANS_CO2.csv")

airtransportation <- select(airtransportation, -15)
airtransportation

CO2_emissions19 <- airtransportation %>%
  filter(Time == 2019) %>%
  select(Value)

sum19 <- sum(CO2_emissions19)

CO2_emissions20 <- airtransportation %>%
  filter(Time == 2020) %>%
  select(Value)

sum20 <- sum(CO2_emissions20)

sum21 <- airtransportation %>%
  filter(Time == 2021) %>%
  select(Value) %>%
  sum()

sum22 <- airtransportation %>%
  filter(Time == 2022) %>%
  select(Value) %>%
  sum()

year <- c("2019", "2020", "2021", "2022")
CO2_emissions <- c(sum19, sum20, sum21, sum22)

df1 <- data.frame(year, CO2_emissions)


get_year_data <- function(years){
  filter(df1, year == years)
}


data_visualization_1 <- function(years) {

  CO2_emissions_df <- get_year_data(years)
 
  CO2_emissions_chart <- 
  ggplot(data = CO2_emissions_df) +
  geom_col(mapping = aes(x = year, y = CO2_emissions), color = "orange", fill = "orange") + 
  labs(x = "Years", y = "CO2 Emissions", title = "Changes in CO2 Emissions during COVID-19") 

return(CO2_emissions_chart)

}
test <- data_visualization_1 (2019)
test


passengers_data <- read.csv("../data/Air_Travel_Passengers.csv")

passengers_data <- select(passengers_data, -6:-7)


passengers_data$X2019 <- gsub(",", "", passengers_data$X2019)
passengers_data$X2019 <- as.numeric(as.character(passengers_data$X2019))
passengers_data$X2020 <- gsub(",", "", passengers_data$X2020)
passengers_data$X2020 <- as.numeric(as.character(passengers_data$X2020))
passengers_data$X2021 <- gsub(",", "", passengers_data$X2021)
passengers_data$X2021 <- as.numeric(as.character(passengers_data$X2021))
passengers_data$X2022 <- gsub(",", "", passengers_data$X2022)
passengers_data$X2022 <- as.numeric(as.character(passengers_data$X2022))

count_19 <- passengers_data %>%
  select(X2019) %>%
  sum()

count_20 <- passengers_data %>%
  select(X2020) %>%
  sum()

count_21 <- passengers_data %>%
  select(X2021) %>%
  sum()

count_22 <- passengers_data %>%
  select(X2022) %>%
  drop_na() %>%
  sum()

numbers_of_passengers <- c(count_19, count_20, count_21, count_22)

df2 <- data.frame(year, numbers_of_passengers)

get_year_data_2 <- function(years){
  filter(df2, year == years)
}

data_visualization_2 <- function(years) {
  passengers_data_df <- get_year_data_2(years)
  
  passengers_chart <- 
  ggplot(data = passengers_data_df) +
  geom_col(mapping = aes(x = year, y = numbers_of_passengers), color = "blue", fill = "blue") +
  labs(x = "Years", y = "Numbers of Passengers", title = "Changes in numbers of passengers during COVID-19")
  return(passengers_chart)
}

test <- data_visualization_2(2019)
test
