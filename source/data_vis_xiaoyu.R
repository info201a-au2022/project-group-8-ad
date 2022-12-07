airtransportation <- read.csv("../data/AIRTRANS_CO2.csv")

library("dplyr")
library("ggplot2")

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

year <- c(2019, 2020, 2021, 2022)
CO2_emissions <- c(sum19, sum20, sum21, sum22)

df1 <- data.frame(year, CO2_emissions)

# First chart:
data_visualization_1 <- ggplot(data = df1) +
  geom_col(mapping = aes(x = year, y = CO2_emissions)) +
  labs(x = "Years", y = "CO2 Emissions", title = "Changes in CO2 Emissions during COVID-19")
data_visualization_1

#passengers_data %>%
#  drop_na()

# Count the total number of flights for each country.
country_flight_numbers <- airtransportation %>%
  group_by(Country) %>%
  summarise(count = sum(Time < 2019), total = n())
country_flight_numbers

country_flight_numbers <- select(country_flight_numbers, -3)
country_flight_numbers

# xiaoyu's first funtion for total number of flights chart.
get_flight_numbers <- function(upper_count, lower_count) {
  flight_numbers <- country_flight_numbers %>%
    group_by(Country) %>%
    filter(count > lower_count & count < upper_count)
  return(flight_numbers)
  
}
test <- get_flight_numbers(140, 130)
test


flight_numbers_greater_150 <- country_flight_numbers %>%
  group_by(Country) %>%
  filter(count > 110 & count < 130)
flight_numbers_greater_150

# Rename 'China(People's Republic of)', that shows in flight_numbers_greater_100,to 'China'
flight_numbers_greater_150 <- flight_numbers_greater_150 %>%
  mutate(Country = as.character(Country)) %>%
  mutate(Country = replace(Country, Country == "China (People's Republic of)", 'China'))
flight_numbers_greater_150


# total co2 emission value caused by air transportation for each country from 2014 to 2018 (airtansportation dataset).
country_emission_value <- airtransportation %>%
  group_by(Country) %>%
  summarise(sum(Value[Time < 2019]))
country_emission_value

#total co2 emission value cased by all transportation for each country from 2014 to 2018 (historical emissions dataset).
historical_emissions <- read.csv("../data/historical_emissions.csv")

country_emission_all <- historical_emissions %>%
  rowwise() %>%
  mutate(sum = sum(X2018, X2017, X2016,X2015, X2014, na.rm = TRUE))
country_emission_all

country_emission_all <- select(country_emission_all, -2:-34)
country_emission_all

# bar chart of country flight numbers.(Third chart)
flight_bar_chart <- ggplot(data = test) +
  geom_col(mapping = aes(x = Country, y = count), color = "white", fill = "orange") +
  labs(x = "Countries", y = "Numbers of flights", title = "Total number of Flights by Country from 2014 to 2018")
flight_bar_chart

flight_bar_chart <- flight_bar_chart + coord_flip()
flight_bar_chart

# xiaoyu's function for total number of flights chart
get_flight_chart <- function(upper_count, lower_count) {
  flight_numbers <- get_flight_numbers(upper_count, lower_count)
  flight_bar_chart <- ggplot(data = flight_numbers) +
    geom_col(mapping = aes(x = Country, y = count), color = "white", fill = "orange") +
    labs(x = "Countries", y = "Numbers of flights", title = "Total number of Flights by Country from 2014 to 2018")
  
  flight_bar_chart <- flight_bar_chart + coord_flip()
  return(flight_bar_chart)
}
test_2 <- get_flight_chart(160, 130)
test_2

# Change the country name of 'Turkey'(in country_emission_all) to 'Türkiye'
country_emission_all <- country_emission_all %>%
  mutate(Country = as.character(Country)) %>%
  mutate(Country = replace(Country, Country == 'Turkey', 'Türkiye'))
country_emission_all

# change the name china(people' republic of) to china (country_emission_value)
country_emission_value <- country_emission_value %>%
  mutate(Country = as.character(Country)) %>%
  mutate(Country = replace(Country, Country == "China (People's Republic of)", 'China'))
country_emission_value

# filter out 28 countries that has more than 150 flights from 'country_emission_value.'
airtrans_greater_150 <- country_emission_value[c(178, 177, 176, 171, 166, 157, 155, 145, 138, 123, 119, 113, 107, 100, 85, 82, 80, 79, 74, 63, 60, 51, 35, 34, 33, 30, 22, 8), ]
airtrans_greater_150

# filter out 28 countries that has more than 150 flights from 'country_emission_all.'
all_greater_150 <- country_emission_all[c(3, 20, 32, 19, 24, 28, 17, 15, 8, 35, 38, 56, 16, 21, 125, 7, 22, 58, 5, 10, 25, 26, 37, 2, 85, 12, 9, 18), ]
all_greater_150

# filter out 20 countries that the flights number between 130-150 from 'country_emission_value.'
airtrans_between_130_150 <- country_emission_value[c(183, 175, 170, 165, 162, 135, 133, 129, 120, 84, 83, 75, 73, 59, 57, 50, 46, 43, 15, 1), ]
airtrans_between_130_150
country_df <- data.frame(test_2$data$Country)
colnames(country_df)[1] <- "Country"
country_emissions <- left_join(country_df, country_emission_value, by = "Country")
country_emission_values <- left_join(country_emissions, country_emission_all, by = "Country")


# filter out 20 countries that the flights number between 130-150 from 'country_emission_all.'
all_between_130_150 <- country_emission_all[c(27, 36, 90, 51, 79, 65, 40, 115, 99, 29, 92, 6, 159, 64, 69, 55, 81, 46, 47, 136), ]
all_between_130_150

#create a dataset that combines 'airtrans_greater_150' and 

colnames(airtrans_between_130_150)[2] ="CO2 by airtrans"
colnames(all_between_130_150)[2] ="CO2 by all trans"


column_2 <- test_2$data$Country
column_2

airplane <- airtrans_between_130_150$`CO2 by airtrans`
airplane


all_transportation <- all_between_130_150$`CO2 by all trans`
all_transportation

# convert mtco2 to tco2
all_transportation <- 1.10231 * (all_transportation)
all_transportation

# trans_all_comparsion <- data.frame(column_2, airplane, all_transportation)
# trans_all_comparsion

#install.packages("reshape")
#install.packages("reshape2")
library("reshape")
library("reshape2")

# trans_all_comparsion.melt <- reshape2::melt(trans_all_comparsion, id ="column_2")
# trans_all_comparsion.melt

get_flight_numbers <- function(upper_count, lower_count) {
  flight_numbers <- country_flight_numbers %>%
    group_by(Country) %>%
    filter(count > lower_count & count < upper_count)
  return(flight_numbers)
  
}

get_flight_chart <- function(upper_count, lower_count) {
  flight_numbers <- get_flight_numbers(upper_count, lower_count)
  flight_bar_chart <- ggplot(data = flight_numbers) +
    geom_col(mapping = aes(x = Country, y = count), color = "white", fill = "orange") +
    labs(x = "Countries", y = "Numbers of flights", title = "Total number of Flights by Country from 2014 to 2018")
  
  flight_bar_chart <- flight_bar_chart + coord_flip()
  return(flight_bar_chart)
}
get_co2_chart <- function(upper_count, lower_count) {
  test_2 <- get_flight_chart(upper_count, lower_count)
  country_df <- data.frame(test_2$data$Country)
  colnames(country_df)[1] <- "Country"
  country_emissions <- left_join(country_df, country_emission_value, by = "Country")
  country_emission_values <- left_join(country_emissions, country_emission_all, by = "Country")

  country_emission_values.melt <- reshape2::melt(country_emission_values, id = "Country")

  chart_3 <- ggplot(data = country_emission_values.melt, aes(x = Country, y = value, fill = variable))
  chart_3 <- chart_3 + geom_col(position = "dodge")
  chart_3 <- chart_3 + theme_classic()
  chart_3 <- chart_3 + labs(title = "CO2 Emissions: Airplanes vs. all Possible Factors"
                            , subtitle = "Emissions value from 2014 to 2018"
                            , fill = "Sources of CO2 emissions"
                            , x = "Countries"
                            , y = "CO2 Emissions") 
  chart_3 <- chart_3 + scale_y_log10()

  chart_3 <- chart_3 + coord_flip()
  return(chart_3)
}

