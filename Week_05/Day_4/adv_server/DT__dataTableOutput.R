


library(shiny)
library(tidyverse)
library(CodeClanData)



ui <- fluidPage(
  
    radioButtons("handed_input",
                 "Handness",
                 choices = unique(students_big$handed),
                 inline = TRUE
    ),
  
    DT::dataTableOutput("table_output")
  
)

server <- function(input, output) {
  
  output$table_output <- DT::renderDataTable({
      students_big %>% 
      filter(handed == input$handed_input) 
    
  })
  
}

shinyApp(ui, server)