
source("weather.r")

shinyServer(
  function(input, output) {
    observeEvent(input$goButton, {
      output$error <- renderUI({})
      output$tmax <- renderUI({})
      output$tmin <- renderUI({})
      output$snow <- renderUI({})
        
      longitude <- as.numeric(input$longitude)
      latitude <- as.numeric(input$latitude)
      month <- input$month
      radius <- input$radius
      df <- data.frame(longitude, latitude, month, radius, stringsAsFactors=FALSE)
      w <- weather(df)

      if ( !is.na(w$c) ) {
        if ( w$c == "United States of America") {
          output$tmax <- renderUI({HTML(paste("<b>Maximum Temperature:</b> ", format(round(w$tmax,0), nsmall=0), " F"))})
          output$tmin <- renderUI({HTML(paste("<b>Minimum Temperature:</b> ", format(round(w$tmin,0), nsmall=0), " F"))})
          output$snow <- renderUI({HTML(paste("<b>Snowfall:</b> ", format(round(w$snow,2), nsmall=2), " inches"))})
        }
        else {
          output$error <- renderUI({HTML(paste("The longitude and latitude point is in ", w$c, ".<br>It needs to be within the United States of America"))})
        }
      }
      else
      {
        output$error <- renderUI({HTML(paste("The longitude and latitude point is not in the United States of America"))})
      }
    })
  }
)

