# Read in data
eq_data <- read.csv("~/Documents/R/EQ_map/eq_mag5plus_2014_2024.csv")


# Clean data

eq_data$time <- ymd_hms(eq_data$time)

eq_year_data <- eq_data |> 
    mutate(year = year(time),
           country = case_when(
               str_detect(place, ",") ~ str_extract(place, "[^,]+$"),
               str_detect(place, "Fiji region") ~ "Fiji",
               str_detect(place, "Kuril Islands") ~ "Kuril Islands",
               str_detect(place, "Taiwan") ~ "Taiwan",
               str_detect(place, "South Sandwich Islands") ~ "Sandwich Islands",
               str_detect(place, "Kermadec Islands") ~ "Kermadec Islands",
                TRUE ~ place),
           #
           country = case_when(
               grepl("Japan", place) ~ "Japan",
               grepl("Mariana Islands", place) ~ "Mariana Islands",
               grepl('Loyalty Islands', place) ~ "Loyalty Islands",
               grepl('New Zealand', place) ~ "New Zealand",
               TRUE ~ country
            ),
           country = str_trim(country))

min_year <- min(eq_year_data$year)
max_year <- max(eq_year_data$year)




# convert to sf object
map <- st_as_sf(eq_year_data, coords = c('longitude', 'latitude'), crs = 4326)




# df <- eq_data |> 
#     filter(year(time) == '2015') |> 
#     distinct(id, .keep_all = TRUE) |> 
#     arrange(desc(mag)) |> 
#     top_n(10, mag)
# 
# leaflet(df) |> 
#     addTiles() |> 
#     addCircleMarkers(
#         data = map,
#         label = vars(place),
#         radius = 5,
#         color = 'red'
#     )
# 
# # Function to call map data
# data <- function(input_year, data){
#     
#     df <- data |> 
#         filter(year(time) == input_year) |> 
#         distinct(id, .keep_all = TRUE) |> 
#         arrange(desc(mag)) |> 
#         top_n(10, mag)
#     
#     return(df)
#     
# }
# 
# # Function to call bar data

