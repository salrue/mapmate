library(shiny)
library(mapmate)
data(borders)
borders <- dplyr::mutate(borders, frameID=1)
id <- "frameID"

ui <- shinyUI(fluidPage(
  fluidRow(
    column(5,
      titlePanel("Orthographic projection example"),
      h4("Wait a moment for map to load. It may lag behind slider input changes."),
      sliderInput("lon", "Longitude (lon)", min=-180, max=180, value=0, width="100%"),
      sliderInput("lat", "Latitude (lat)", min=-90, max=90, value=0, width="100%"),
      sliderInput("orientation", "Orientation (rotation.axis)", min=0, max=360, value=24, width="100%")
    ),
    column(7, plotOutput("orthoMap", width="100%"))
  )
))

server <- shinyServer(function(input, output) {
   output$orthoMap <- renderPlot({
     save_map(borders, id=id, lon=input$lon, lat=input$lat, col="black", type="maplines", rotation.axis=input$orientation, save.plot=FALSE, return.plot=TRUE)
   })
})

shinyApp(ui, server, options=list(height=500))
