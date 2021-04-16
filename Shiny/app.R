
#' Load in libraries
library(shiny)
library(shinythemes)
library(tidyverse)

#' Load in Halloween data
spooky <- read.csv("spooky_data.csv") # Could also use read_csv (tidyverse version)

#' Create a blank user interface:
ui <- fluidPage()

#' Create the user interface for app:
ui <- fluidPage(
    titlePanel("I am adding a title!"),
    sidebarLayout(
        sidebarPanel("put my widgets here",
                     selectInput(inputId = "state_select",
                                 label = "Choose a state",
                                 choices = unique(spooky$state)),
                     radioButtons(inputId = "region_select",
                                  label = "Choose region:",
                                  choices = unique(spooky$region_us_census))),
        mainPanel("put my outputs here",
                  p("State's top candies:"),
                  tableOutput(outputId = "candy_table"),
                  p("Region's top costumes:"),
                  plotOutput(outputId = "costume_graph")
        )))

#' Create a blank server function:
server <- function(input, output) {}

#' Subsetting dataset to just what user wants (on server side now):
server <- function(input, output) {
    state_candy <- reactive({ # Reactive object: input from user interface
        spooky %>%
            filter(state == input$state_select) %>% # Interactive objects need to be
            # wrapped in reactive function
            select(candy, pounds_candy_sold)})
    output$candy_table <- renderTable({
        state_candy()})
    region_costume <- reactive({
        spooky %>%
            filter(region_us_census == input$region_select) %>%
            count(costume, rank)
    })
    
    
    output$costume_graph <- renderPlot({
        ggplot(region_costume(), aes(x = costume, y = n)) +
            geom_col(aes(fill = rank)) +
            coord_flip() +
            scale_fill_manual(values = c("black","purple","orange")) +
            theme_minimal()
    })
}



#' Combine them into an app:
shinyApp(ui = ui, server = server)
