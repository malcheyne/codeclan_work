
library(tidyverse)
library(shiny)
library(CodeClanData)

ui <- fluidPage(
  
  fluidRow(
      # choose which gender of dog
      column(2,  
        radioButtons("gender_input",
                     "Which Gender",
                     choices = unique(nyc_dogs$gender))
      ),
      # choose which colour of dog
      column(2,  
             selectInput("colour_input",
                          "Which Colour",
                          choices = unique(nyc_dogs$colour))
      ),
      # choose which borough the dog is from
      column(2,  
             selectInput("borough_input",
                         "Which Borough",
                         choices = unique(nyc_dogs$borough))
      ),
      # choose which breed of dog
      column(3,  
             selectInput("breed_input",
                         "Which Breed ",
                         choices = unique(nyc_dogs$breed))
      ),
      # ADD AN ACTION BUTTON IN HERE
      column(2,
             br(),
      actionButton("update", "Update dashboard")
      )
      
  ),
  # data table which displays the result of these choices
  DT::dataTableOutput("table_output")
  
)

server <- function(input, output) {
  
  # Filter data from inputs
  filtered_data <- eventReactive(input$update, {
    nyc_dogs %>% 
      filter(gender == input$gender_input,
             colour == input$colour_input,
             borough == input$borough_input,
             breed == input$breed_input)
    
  })
  
  output$table_output <- DT::renderDataTable({
    filtered_data()
    
  })
  
}

shinyApp(ui, server)