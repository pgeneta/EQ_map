source("~/Documents/R/EQ_map/scripts/1_libraries.R")
source("~/Documents/R/EQ_map/scripts/2_data.R")
source("~/Documents/R/EQ_map/scripts/3_plot_functions.R")

ui <- fluidPage(
  titlePanel('Earthquake Map Shiny App'),
  sidebarLayout(
      sidebarPanel(width = 2,
                   selectInput('year',
                               'Select Year:',
                               choices = c(min_year:max_year),
                               selected = min_year)),
      mainPanel(width = 10,
          leafletOutput('mapPlot'),
          plotOutput('magnitudePlot')
      )
  )
)


server <- function(input, output, session) {
 
  map_df_reactive <- reactive({
    
    df <- map |> 
      filter(year == input$year) |> 
      distinct(id, .keep_all = TRUE) |> 
      arrange(desc(mag)) |> 
      top_n(10, mag)
    
    return(df)
    
  })
  
  graph_df_reactive <- reactive({
    
    df <- map |> 
      filter(year == input$year) |> 
      group_by(country) |> 
      count() |> 
      arrange(desc(n)) |> 
      top_n(10, n)
    
    return(df)
    
  })
  
  output$mapPlot <- renderLeaflet({
    
    generate_map(map_df_reactive())
    
  })
  
  output$magnitudePlot <- renderPlot({
    
    generate_graph(graph_df_reactive(), input$year)
    
  })
   
}

shinyApp(ui, server)