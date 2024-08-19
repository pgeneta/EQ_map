# Generate Map function
generate_map <- function(df){
    
    leaflet(data = df) |> 
        addTiles() |> 
        addCircleMarkers(
            data = df,
            label = vars(place),
            radius = 5,
            color = "red"
        )
}


# a <- map |> 
#     filter(year == 2023) |> 
#     distinct(id, .keep_all = TRUE) |> 
#     arrange(desc(mag)) |> 
#     top_n(10, mag)
# 
# generate_map(a)

# Generate bar graph function
generate_graph <- function(df){
    
    df |> 
        ggplot(aes(x = reorder(id, mag),
                   y = mag))+
        geom_bar(stat = 'identity') +
        coord_flip() + 
        scale_x_discrete()
}


