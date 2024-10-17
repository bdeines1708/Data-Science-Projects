# Load necessary libraries
library(shiny)
library(ggplot2)
library(dplyr)


# Load the data
housing_data <- read.csv("/Users/bensmacbook/housing.csv")

# Define UI
ui <- fluidPage(
  titlePanel("Housing Data Dashboard"),
  sidebarLayout(
    sidebarPanel(
      helpText("Explore housing data by ocean proximity, population, households, total rooms, and total bedrooms.")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Ocean Proximity", plotOutput("oceanPlot")),
        tabPanel("Population vs Households", plotOutput("popHousePlot")),
        tabPanel("Rooms vs Bedrooms", plotOutput("roomBedroomPlot"))
      )
    )
  )
)

# Define Server
server <- function(input, output) {
  
  # Ocean Proximity Pie Chart
  output$oceanPlot <- renderPlot({
    housing_data %>%
      count(ocean_proximity) %>%
      ggplot(aes(x = "", y = n, fill = ocean_proximity)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar("y", start = 0) +
      labs(title = "Homes by Ocean Proximity", fill = "Ocean Proximity") +
      theme_minimal()
  })
  
  # Population vs Households Density Plot
  output$popHousePlot <- renderPlot({
    ggplot(housing_data, aes(x = population, y = households)) +
      geom_density_2d_filled() +
      labs(title = "Density of Population vs Households", x = "Population", y = "Households") +
      theme_minimal()
  })
  
  # Rooms vs Bedrooms Boxplot
  output$roomBedroomPlot <- renderPlot({
    ggplot(housing_data, aes(x = as.factor(total_rooms), y = total_bedrooms)) +
      geom_boxplot() +
      labs(title = "Rooms vs Bedrooms Boxplot", x = "Total Rooms", y = "Total Bedrooms") +
      theme_minimal()
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)


