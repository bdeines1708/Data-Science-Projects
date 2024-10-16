# Load necessary libraries
library(shiny)
library(ggplot2)



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
  
  # Ocean Proximity Plot
  output$oceanPlot <- renderPlot({
    ggplot(housing_data, aes(x = ocean_proximity)) +
      geom_bar(fill = "lightblue") +
      labs(title = "Homes by Ocean Proximity", x = "Ocean Proximity", y = "Number of Homes") +
      theme_minimal()
  })
  
  # Population vs Households Scatter Plot
  output$popHousePlot <- renderPlot({
    ggplot(housing_data, aes(x = population, y = households)) +
      geom_point(color = "blue", alpha = 0.5) +
      labs(title = "Population vs Households", x = "Population", y = "Households") +
      theme_minimal()
  })
  
  # Total Rooms vs Total Bedrooms Scatter Plot
  output$roomBedroomPlot <- renderPlot({
    ggplot(housing_data, aes(x = total_rooms, y = total_bedrooms)) +
      geom_point(color = "red", alpha = 0.5) +
      labs(title = "Total Rooms vs Total Bedrooms", x = "Total Rooms", y = "Total Bedrooms") +
      theme_minimal()
  })
}

# Run the application
shinyApp(ui = ui, server = server)

