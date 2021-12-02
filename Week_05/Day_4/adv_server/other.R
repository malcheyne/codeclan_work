


library(shiny)
library(tidyverse)
library(CodeClanData)



ui <- fluidPage(
  
  fluidRow(  
    
        column(4,
            radioButtons("handed_input",
                         "Handness",
                         choices = unique(students_big$handed),
                         inline = TRUE)
        ), 
        
        column(4,
            selectInput("region_input", label = h3("Select Region"), 
                        choices = unique(students_big$region), 
                        selected = 1)
        ), 
        
        column(4,
               selectInput("gender_input", label = h3("Select Gender"), 
                           choices = unique(students_big$gender), 
                           selected = 1)
        ), 
    
    
        DT::dataTableOutput("table_output")
  )
)

server <- function(input, output) {
  
  output$table_output <- DT::renderDataTable({
      students_big %>% 
      filter(handed == input$handed_input,
             region == input$region_input,
             gender == input$gender_input) 
    
  })
  
}

shinyApp(ui, server)