library(shiny)

months <- c("January" = "jan", "February" = "feb", "March" = "mar", "April" = "apr", "May" = "may", 
            "June" = "jun", "July" = "jul", "August" = "aug", "September" = "sep", "October" = "oct", 
            "November" = "nov", "December" = "dec")
shinyUI(fluidPage(
  
  titlePanel("Weather Monthly"),
  
  helpText("1. Identify a location by its longitude and latitude coordinates."),
  helpText("2. Select a radius in miles to identify a circle around that point."),
  helpText("3. Select the month you are interest in."),
  helpText("4. Click on Search"),
  
  sidebarLayout(
    sidebarPanel(
      textInput('latitude', 'Latitude:'),
      textInput('longitude', 'Longitude:'),
      numericInput('radius', 'Radius (miles):', 50, min = 10, max = 1000, step = 1),
      selectInput('month', 'Month:', months),
      actionButton("goButton", "Search")
    ),
    
    mainPanel( 
      tags$style(".span12 {background-color: black;}"),
      htmlOutput("error"),
      htmlOutput("tmax"),
      htmlOutput("tmin"),
      htmlOutput("snow")
    )
  ),
  helpText("Note: Information is based on US Climate Normals over 30 years datasets from National Oceanic and Atmospheric Administration")
))