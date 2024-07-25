library(shiny)
library(ggplot2)

# Load data globally
study_hours <- read.csv("E://1st Sem/PROGRAMMING/Study hours dataset/Study hours .csv")

# Define UI
ui <- fluidPage(
  titlePanel("Study Hours Analysis"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Histogram", plotOutput("histPlot")),
        tabPanel("Scatter Plot", plotOutput("scatterPlot"))
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$histPlot <- renderPlot({
    bins <- seq(min(study_hours$Scores), max(study_hours$Scores), length.out = input$bins + 1)
    ggplot(study_hours, aes(x = Scores)) +
      geom_histogram(breaks = bins, fill = "green", color = "black") +
      ggtitle("Histogram of Scores") +
      xlab("Scores") +
      ylab("Frequency")
  })
  
  output$scatterPlot <- renderPlot({
    ggplot(study_hours, aes(x = Hours, y = Scores)) +
      geom_point(color = "purple") +
      ggtitle("Scatter Plot of Study Hours vs. Scores") +
      xlab("Study Hours") +
      ylab("Scores")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)