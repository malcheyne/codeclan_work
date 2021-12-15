

ui <- fluidPage(
  selectInput("region", "Which Region?", unique(whisky$Region)),
  leafletOutput("map")
)
