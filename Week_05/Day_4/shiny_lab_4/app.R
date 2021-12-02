
library(CodeClanData)
library(shiny)
library(tidyverse)



ui <- fluidPage(
  
  titlePanel("Comparing Importance of Internet Access VS. Reducing Pollution"),
  
    sidebarLayout(
      # Sidebar with Inputs
        sidebarPanel(
          # Gender input
            selectInput("gender_input",
                        "Gender",
                        choices = unique(students_big$gender)
            ),
          # Region input  
            selectInput("region_input",
                        "Region",
                        choices = unique(students_big$region)
            ),
          
          
          # ADD AN ACTION BUTTON IN HERE
            actionButton("update", "Generate Polts and Table"
            )
        ),
      # Main bar with tabs and out puts  
        mainPanel(
            tabsetPanel(
            # plot Tab
              tabPanel("Plot",
                # Fluid row
                  fluidRow(
                    # 1st Plot
                      column(6,
                          plotOutput("access_plot"),
                      ),
                    # 2nd Plot 
                      column(6,
                          plotOutput("pollution_plot")
                      )
                  )
                
              ),
            # Data Tab  
              tabPanel("Data",
                       
                    # data table which displays the result of these choices
                       DT::dataTableOutput("table_output")
                       
              )
              
            )
          
        )  
    )
)
  
  
#names(students_big)


server <- function(input, output) {
  
  
  filtered_data <- eventReactive(input$update, {
    students_big %>% 
      select(region, gender, 
             importance_internet_access, 
             importance_reducing_pollution) %>% 
      filter(gender == input$gender_input,
             region == input$region_input)
    
  })
  
  output$access_plot <- renderPlot({
    ggplot(filtered_data()) +
      geom_histogram(aes(x = importance_internet_access))
  })
  
  output$pollution_plot <- renderPlot({
    ggplot(filtered_data()) +
      geom_histogram(aes(x = importance_reducing_pollution))
  })
  
  
  output$table_output <- DT::renderDataTable({
    filtered_data()
    
  })
  
}

shinyApp(ui, server)


