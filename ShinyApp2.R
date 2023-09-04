#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(leaflet)
library(ggplot2)
library(dplyr)
library(lubridate)

# Define UI for Shiny app
ui <- fluidPage(
  titlePanel("Police Killings Data Analysis"),
  
  # Sidebar with a slider input for year selection
  sidebarLayout(
    sidebarPanel(
      sliderInput("year", "Select Year:", min = 2015, max = 2022, value = 2020)
    ),
    
    # Main panel with outputs
    mainPanel(
      tabsetPanel(
        tabPanel("Data Table", DTOutput("table")),
        tabPanel("Map", leafletOutput("map")),
        tabPanel("Race Distribution", plotOutput("race_plot")),
        tabPanel("Gender Distribution",  plotOutput("gender_plot")),
        tabPanel("Threat Level Distribution", plotOutput("threat_level_plot")),
        tabPanel("Flee Distribution",  plotOutput("flee_plot")),
        tabPanel("Age Distribution", plotOutput("age_plot")),
        tabPanel("Armed Distribution", plotOutput("armed_plot")),
        tabPanel("Top 10 Cities", plotOutput("top_cities_plot"))
      ),
      width = 9
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Read data remotely using read.csv()
  data <- reactive({
    url <- "https://github.com/washingtonpost/data-police-shootings/releases/download/v0.1/fatal-police-shootings-data.csv"
    read.csv(url, stringsAsFactors = FALSE)
  })
  
  # Filter data based on selected year
  filtered_data <- reactive({
    data() %>% filter(year(date) == input$year)
  })
  
  # Display filtered data using DT
  output$table <- renderDT({
    datatable(filtered_data())
  })
  
  # Create map using leaflet
  output$map <- renderLeaflet({
    leaflet(filtered_data() %>%
              filter(year(date) == 2020)) %>%
      addTiles() %>%
      addMarkers(~longitude, ~latitude, popup = ~paste(name, "<br>Age:", age))
    
  })
  
  # Plot distribution of race using a bar graph
  output$race_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = race)) +
      geom_bar() +
      labs(x = "Race", y = "Count", title = "Distribution of Race")
  })
  
  # Plot distribution of gender using a bar graph
  output$gender_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = gender)) +
      geom_bar() +
      labs(x = "Gender", y = "Count", title = "Distribution of Gender")
  })
  
  # Plot distribution of threat level using a bar graph
  output$threat_level_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = threat_level)) +
      geom_bar() +
      labs(x = "Threat Level", y = "Count", title = "Distribution of Threat Level")
  })
  
  # Plot distribution of flee using a bar graph
  output$flee_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = flee)) +
      geom_bar() +
      labs(x = "Flee", y = "Count", title = "Distribution of Flee")
  })
  
  # Plot distribution of age using a histogram
  output$age_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = age)) +
      geom_histogram() +
      labs(x = "Age", y = "Count", title = "Distribution of Age")
  })
  
  # Plot distribution of armed using a bar graph
  output$armed_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = armed)) +
      geom_bar() +
      labs(x = "Armed", y = "Count", title = "Distribution of Armed")
  })
  
  # Plot top 10 cities with most victims using a bar graph
  output$top_cities_plot <- renderPlot({
    top_cities <- filtered_data() %>%
      group_by(city) %>%
      summarise(count = n()) %>%
      arrange(desc(count)) %>%
      head(10)
    
    ggplot(top_cities, aes(x = reorder(city, count), y = count)) +
      geom_bar(stat = "identity") +
      labs(x = "City", y = "Count", title = "Top 10 Cities with Most Victims")
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
