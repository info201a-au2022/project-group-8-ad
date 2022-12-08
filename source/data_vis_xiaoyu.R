#Interactive panel two: chart 1
airtransportation <- read.csv("../data/AIRTRANS_CO2.csv")

library("dplyr")
library("ggplot2")

# Count the total number of flights for each country.
country_flight_numbers <- airtransportation %>%
  group_by(Country) %>%
  summarise(count = sum(Time < 2019), total = n())
country_flight_numbers <- select(country_flight_numbers, -3)


# first funtion for total number of flights chart.
get_flight_numbers <- function(upper_count, lower_count) {
  flight_numbers <- country_flight_numbers %>%
    group_by(Country) %>%
    filter(count > lower_count & count < upper_count)
  return(flight_numbers)
  
}

# second function for total number of flights chart
get_flight_chart <- function(upper_count, lower_count) {
  flight_numbers <- get_flight_numbers(upper_count, lower_count)
  flight_bar_chart <- ggplot(data = flight_numbers) +
    geom_col(mapping = aes(x = Country, y = count), color = "white", fill = "orange") +
    labs(x = "Countries", y = "Numbers of flights", title = "Total number of Flights by Country from 2014 to 2018")
  
  flight_bar_chart <- flight_bar_chart + coord_flip()
  return(flight_bar_chart)
}


# Interactive panel two: chart 2
library("reshape")
library("reshape2")

historical_emissions <- read.csv("../data/historical_emissions.csv")

# country emission value from 2014 to 2018
country_emission_value <- airtransportation %>%
  group_by(Country) %>%
  summarise(sum(Value[Time < 2019]))
country_emission_value <- country_emission_value %>%
  mutate(Country = as.character(Country)) %>%
  mutate(Country = replace(Country, Country == "China (People's Republic of)", 'China'))

#country emission value caused by all possible factors from 2014 to 2018
country_emission_all <- historical_emissions %>%
  rowwise() %>%
  mutate(sum = sum(X2018, X2017, X2016,X2015, X2014, na.rm = TRUE))
country_emission_all <- select(country_emission_all, -2:-34)
country_emission_all <- country_emission_all %>%
  mutate(Country = as.character(Country)) %>%
  mutate(Country = replace(Country, Country == 'Turkey', 'Türkiye'))

# function for the second chart
get_co2_chart <- function(upper_count, lower_count) {
  test_2 <- get_flight_chart(upper_count, lower_count)
  country_df <- data.frame(test_2$data$Country)
  colnames(country_df)[1] <- "Country"
  country_emissions <- left_join(country_df, country_emission_value, by = "Country")
  country_emission_values <- left_join(country_emissions, country_emission_all, by = "Country")
  
  colnames(country_emission_values)[2] <- "All Possible Factors"
  colnames(country_emission_values)[3] <- "Airplanes"
  
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