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
          plotOutput('mapPlot'),
          plotOutput('magnitudePlot')
      )
  )
)

server <- function(input, output, session) {
 
  df_reactive <- reactive({
    df <- map |> 
      filter(year(time) == input$year) |> 
      distinct(id, .keep_all = TRUE) |> 
      arrange(desc(mag)) |> 
      top_n(10, mag)
    
    return(df)
  })
  
  output$mapPlot <- renderPlot({
    
    
    
  })
  
  output$magnitudePlot <- renderPlot({
    
    
    
  })
   
}

shinyApp(ui, server)