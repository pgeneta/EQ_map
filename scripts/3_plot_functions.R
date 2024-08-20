# Generate Map function
generate_map <- function(df){
    
    
    leaflet() |> 
        addTiles() |> 
        setView(lng = 0,
                lat = 0,
                zoom = 1.2) |>
        # setMaxBounds(lng1 = 1.2 + 0.05,
        #              lat1 = 1.2 + 0.05,
        #              lng2 = 1.2 - 0.05,
        #              lat2 = 1.2 - 0.05) |> 
        addCircleMarkers(
            data = df,
            popup = ~paste0("Area: ", country, "</br>",
                            "Magnitude: ", mag, "</br>",
                            "Depth: ", depth),
            radius = ~mag * 2.5,
            color = "red",
            fillOpacity = 0.3)
        # addMarkers(data = df,
        #            popup = ~paste0("Area: ", country, "</br>",
        #                            "Magnitude: ", mag, "</br>",
        #                            "Depth: ", depth))
        
}

# generate_map(map)
# 
# a <- map |>
#     filter(year == 2023) |>
#     distinct(id, .keep_all = TRUE) |>
#     arrange(desc(mag)) |>
#     top_n(10, mag)
# 
# generate_map(a)

# Generate bar graph function
# generate_graph <- function(df, input_year){
#     
#     df |> 
#         ggplot(aes(x = reorder(id, mag),
#                    y = mag,
#                    fill = id))+
#         geom_bar(stat = 'identity') +
#         coord_flip() + 
#         scale_x_discrete(labels = df$Country) +
#         labs(
#             y = "Magnitude",
#             x = "",
#             title = paste0("Top 10 Earthquakes by Magnitude in ", input_year)
#         )+
#         scale_fill_manual(values = c(met.brewer(name = 'Pissaro', n = 12)))+
#         theme_minimal(base_size = 15)+
#         theme(
#             panel.grid.minor = element_blank(),
#             legend.position = 'none'
#         )+
#         scale_y_continuous(breaks = seq(0,10, by = 1), 
#                            limits = c(0,10))
# }

generate_graph <- function(df, input_year){
    
    df |> 
        ggplot(aes(x = reorder(country, n),
                   y = n))+
        geom_bar(stat = 'identity', aes(fill = country), linewidth = 1, color = "white")+
        coord_flip()+
        scale_fill_manual(values = c(met.brewer(name = 'Pissaro', n = 32)))+
        scale_y_continuous(expand = c(0,0.3),
                           breaks = seq(0, max(df$n+10),by = 10),
                           limits = c(0, max(df$n)+5))+
        labs(
            title = paste0("Top 10 Areas with the highest number of Earthquakes in ", input_year),
            x = '',
            y = 'Number of earthquakes'
        )+
        theme_minimal(base_size = 15, base_family = 'Times New Roman')+
        theme(
            panel.grid.minor = element_blank(),
            legend.position = 'none',
            plot.title = element_markdown(face = "bold"),
            plot.title.position = 'plot',
            axis.text = element_markdown(size = 17),
            axis.title = element_text(size = 20,
                                      face = 'bold')
        )+
        geom_label(aes(label = n), color = 'black', size = 5)
    
}

# x <- map |>
#     filter(year == 2015) |>
#     group_by(country) |>
#     count() |> 
#     arrange(desc(n)) |>
#     top_n(10, n)
#     
# generate_graph(x, '2015')
