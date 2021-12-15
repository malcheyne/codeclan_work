

server <- function(input, output) {
  
  output$map <- renderLeaflet({
    
    whisky %>% 
      filter(Region == input$region) %>%
      leaflet() %>% 
      addTiles() %>%
      addCircleMarkers(lat = ~Longitude, lng = ~Latitude, popup = ~Distillery)
    
  })
}
