source("~/Documents/R/EQ_map/scripts/1_libraries.R")
source("~/Documents/R/EQ_map/scripts/2_data.R")
source("~/Documents/R/EQ_map/scripts/3_plot_functions.R")

ui <- fluidPage(
  titlePanel('Earthquake Map Shiny App'),
  sidebarLayout(
      sidebarPanel(width = 2,
                   selectInput('year',
                               'Select Year:',
                               choices = c(2014:2024),
                               selected = 2014)),
      mainPanel(width = 10,
          plotOutput('mapPlot'),
          plotOutput('magnitudePlot')
      )
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)