source("scripts/1_libraries.R")
source("scripts/2_data.R")
source("scripts/3_plot_functions.R")



ui <- fluidPage(
  
  tags$head(tags$style(HTML('* {font-family: "Times New Roman"}'))),
  
  titlePanel("Earthquake Map Shiny App"),
  
  sidebarLayout(
    
    sidebarPanel(
      width = 2,
      selectInput("year",
        "Select Year:",
        choices = c(min_year:max_year),
        selected = min_year
      )
    ),
    
    mainPanel(
      width = 10,
      h3(htmlOutput("dynamic_header")),
      leafletOutput("map_plot"),
      plotOutput("eq_count_plot")
    )
  )
)


server <- function(input, output, session) {
  
  output$dynamic_header <- renderText({
    paste0("<b>Top 10 strongest earthquakes in ", input$year, "</b>")
  })

  map_df_reactive <- reactive({
    df <- map |>
      filter(year == input$year) |>
      distinct(id, .keep_all = TRUE) |>
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

  output$map_plot <- renderLeaflet({
    generate_map(map_df_reactive())
  })

  output$eq_count_plot <- renderPlot({
    generate_graph(graph_df_reactive(), input$year)
  })
}

shinyApp(ui, server)
