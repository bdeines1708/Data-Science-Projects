library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)

# UI
ui <- dashboardPage(
  dashboardHeader(title = "Iris Data Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Visualizations", tabName = "visuals", icon = icon("dashboard")),
      menuItem("About", tabName = "about", icon = icon("info"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "visuals",
              fluidRow(
                box(title = "Sepal Length vs Sepal Width", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("sepalPlot")),
                box(title = "Petal Length vs Petal Width", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("petalPlot")),
                box(title = "Species Count", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("speciesPlot")),
                box(title = "Select Species", status = "warning", solidHeader = TRUE,
                    selectInput("speciesInput", "Choose a species:", 
                                choices = unique(iris$Species), selected = unique(iris$Species)[1])
                )
              )
      ),
      tabItem(tabName = "about",
              h2("About this Dashboard"),
              p("This dashboard provides visualizations for the iris dataset.")
      )
    )
  )
)

# Server
server <- function(input, output) {
  # Sepal Length vs Sepal Width
  output$sepalPlot <- renderPlotly({
    ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
      geom_point() +
      labs(title = "Sepal Length vs Sepal Width") +
      theme_minimal()
  })
  
  # Petal Length vs Petal Width
  output$petalPlot <- renderPlotly({
    ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
      geom_point() +
      labs(title = "Petal Length vs Petal Width") +
      theme_minimal()
  })
  
  # Species Count
  output$speciesPlot <- renderPlotly({
    species_count <- as.data.frame(table(iris$Species))
    colnames(species_count) <- c("Species", "Count")
    
    ggplot(species_count, aes(x = Species, y = Count, fill = Species)) +
      geom_bar(stat = "identity") +
      labs(title = "Count of Species") +
      theme_minimal()
  })
}

# Run the app
shinyApp(ui, server)

