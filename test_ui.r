library('shiny')
#runGitHub(repo = 'shiny_geolocation', username = 'AugustT', subdir = 'simple_example')

ui <- shinyUI(
  fluidPage(
    titlePanel("Using Geolocation"),
    
    tags$script(
      '$(document).ready(function() {
        navigator.geolocation.getCurrentPosition(onSuccess,onError);
      
        function onError (err) {
          Shiny.onInputChange("geolocation", false);
        }
      
        function onSuccess (position) {
          setTimeout(function () {
            var coords = position.coords;
            console.log(coords.latitude + ", " + coords.longitude);
            Shiny.onInputChange("geolocation", true);
            Shiny.onInputChange("lat", coords.latitude);
            Shiny.onInputChange("lon", coords.longitude);
          },1100)
        }
      });
      '
    ),
    
    #show a plot of the generated distribution
    fluidRow(
      column(
        width = 2,
        verbatimTextOutput("lat"),
        verbatimTextOutput("lon"),
        verbatimTextOutput("geolocation")
      )
    )
  )
)

server <- shinyServer(
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
  }
)

shinyApp(ui = ui, server = server)