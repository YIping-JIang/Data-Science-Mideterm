library(tidyverse)

con = "China"

sub_data = data %>% filter(country == con) %>% select(year, Urban_Population)
ggplot(sub_data) + geom_line(aes(y=Urban_Population,x = year))

data = read.csv("data.csv")
f = function(x){
  con = x
  sub_data = data %>% filter(country == con) %>% select(year, Urban_Population)
  ggplot(sub_data) + geom_line(aes(y=Urban_Population,x = year))
}

library(shiny)

ui <- fluidPage(
  titlePanel("Year V.S. Urban_Population"),
  sidebarLayout(
    sidebarPanel(
      selectInput("country", label = "Choose a country to display",choices = unique(data$country))
    ),
    mainPanel(
      plotOutput("Plot")
    )
  )
)

server <- function(input, output,session) {
  output$Plot = renderPlot({
    f(input$country)
  })
}

shinyApp(ui, server)
