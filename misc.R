#Libraries
library(tidyverse)
library(leaflet)
library(sf)
library(ggplot2)

#read data
eq_data <- read.csv("~/Documents/R/Interview-shiny/eq_mag5plus_2014_2024.csv")

#Convert to date
eq_data$time <- ymd_hms(eq_data$time)

#Separate year to make shiny app dynamic?
x <- eq_data |> 
    mutate(year = year(time))

min_year <- min(x$year)
max_year <- max(x$year)



#bar graph
df <- eq_data |> 
    filter(year(time) == "2016") |> 
    # group_by(id) |> 
    distinct(id, .keep_all = TRUE) |> 
    # ungroup() |> 
    arrange(desc(mag)) |> 
    top_n(10, mag)

ggplot(df, aes(x = reorder(id, mag), y = mag))+
    geom_bar(stat = 'identity') + coord_flip()
    #scale_x_discrete(labels = df$place)


#Map data
map <- st_as_sf(df, coords = c('longitude', 'latitude'), crs =4326)

leaflet() |> 
    addTiles() |> 
    addCircleMarkers(
        data=map,
        label = ~place,
        radius = 5,
        color = 'red'
    )

