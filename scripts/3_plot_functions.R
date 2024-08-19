# Generate Map function
generate_map <- function(df){
    
    
    leaflet() |> 
        addTiles() |> 
        # addCircleMarkers(
        #     data = df,
        #     label = 
        #     radius = 5,
        #     color = "red")
        addMarkers(data = df,
                   popup = ~paste0("Area: ", country, "</br>",
                                   "Magnitude: ", mag))
        
}

generate_map(map)

a <- map |>
    filter(year == 2023) |>
    distinct(id, .keep_all = TRUE) |>
    arrange(desc(mag)) |>
    top_n(10, mag)
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
            title = paste0("Top 10 Countries with the highest number of Earthquakes in ", input_year),
            x = '',
            y = ''
        )+
        theme_minimal(base_size = 15)+
        theme(
            panel.grid.minor = element_blank(),
            legend.position = 'none',
            plot.title = element_markdown(face = "bold"),
            plot.title.position = 'plot'
        )+
        geom_label(aes(label = n), color = 'black')
    
}

x <- map |>
    filter(year == 2015) |>
    group_by(country) |>
    count() |> 
    arrange(desc(n)) |>
    top_n(10, n)
    
generate_graph(x, '2015')
