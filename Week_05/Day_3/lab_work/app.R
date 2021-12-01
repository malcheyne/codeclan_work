library(shiny)
library(tidyverse)
library(shinythemes)
olympics_overall_medals <- read_csv("data/olympics_overall_medals.csv")

ui <- fluidPage(
  theme = shinytheme("superhero"),
  
  titlePanel(tags$h1("Five Country Medal Comparison")
  ),
  tabsetPanel(
    tabPanel("Main Page",
             sidebarLayout(
               sidebarPanel(
                 radioButtons("season_id", 
                              "Which season?",
                              choices = c("Summer",
                                          "Winter")
                 ),
                 
                 radioButtons("medal_type", 
                              "Which medal?",
                              choices = c("Gold",
                                          "Silver",
                                          "Bronze")
                 )
               ),
               mainPanel(
                 plotOutput("medal_plot")
               )
             )
    ),
    
    tabPanel("Website",
             br(),
             br(),
             br(),
             tags$h1(
                 tags$b(           # Make it BOLD
                    tags$a("Olympics Website",         
                        href = "https://www.olympics.org/"
                        )
                )
             )
    )
  )
)


server <- function(input, output) {
  
  output$medal_plot <- renderPlot ({
    olympics_overall_medals %>%
      filter(team %in% c("United States",
                         "Soviet Union",
                         "Germany",
                         "Italy",
                         "Great Britain")) %>%
      filter(medal == input$medal_type) %>%
      filter(season == input$season_id) %>%
      ggplot() +
      aes(x = team, y = count, fill = medal) +
      geom_col() +
      scale_fill_manual(values = c("Gold" = "Gold",
                                   "Silver" = "#c0c0c0",
                                   "Bronze" = "#b08d57"))
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)





