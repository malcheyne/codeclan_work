library(shiny)
library(shinythemes)
library(tidyverse)

olympics_overall_medals <- read_csv("data/olympics_overall_medals.csv")
all_teams <- unique(olympics_overall_medals$team)

ui <- fluidPage(
  
  theme = shinytheme("superhero"),
  titlePanel("Olympic Medals"),
  
  plotOutput("medal_plot"),
  
  fluidRow(
    
    column(4,
           radioButtons("season_input",
                        "Summer or Winter Olympics?",
                        choices = c("Summer", "Winter")
            )
           
    ),
    
    column(4,
           selectInput("team_input",
                       "Which team?",
                       choices = all_teams)
           
           
    ),
    
    column(4,
           br(),
           tags$a("The Olympics Website"), 
           href = "https://www.Olympic.org"
             
    )
    
    
    
  )
  
  
)

server <- function(input, output) {
  
  output$medal_plot <- renderPlot({
    olympics_overall_medals %>%
      filter(team == input$team_input) %>%
      filter(season == input$season_input) %>%
      ggplot() +
      aes(x = medal, y = count, fill = medal) +
      geom_col()
  })
  
}

shinyApp(ui = ui, server = server)