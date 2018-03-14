
library(shiny)

shinyServer(
  function(input, output) {
    
    output$lat <- renderPrint({
      input$lat
    })
    
    output$lon <- renderPrint({
      input$lon
    })
    
    output$geolocation <- renderPrint({
      input$geolocation
    })
    
    output$accuracy <- renderPrint({
      input$accuracy
    })
    
    output$time <- renderPrint({
      input$time
    })
  }
)
