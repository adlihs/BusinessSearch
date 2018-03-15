library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Using Geolocation"),
  
  tags$script('
              $(document).ready(function () {
              
              function getLocation(callback){
              var options = {
              enableHighAccuracy: true,
              timeout: 5000,
              maximumAge: 0
              };
              
              navigator.geolocation.getCurrentPosition(onSuccess, onError);
              
              function onError (err) {
              Shiny.onInputChange("geolocation", false);
              }
              
              function onSuccess (position) {
              setTimeout(function () {
              var coords = position.coords;
              var timestamp = new Date();
              
              console.log(coords.latitude + ", " + coords.longitude, "," + coords.accuracy);
              Shiny.onInputChange("geolocation", true);
              Shiny.onInputChange("lat", coords.latitude);
              Shiny.onInputChange("lon", coords.longitude);
              Shiny.onInputChange("accuracy", coords.accuracy);
              Shiny.onInputChange("time", timestamp)
              
              console.log(timestamp);
              
              if (callback) {
              callback();
              }
              }, 1100)
              }
              }
              
              var TIMEOUT = 1000; //SPECIFY
              var started = false;
              function getLocationRepeat(){
              //first time only - no delay needed
              if (!started) {
              started = true;
              getLocation(getLocationRepeat);
              return;
              }
              
              setTimeout(function () {
              getLocation(getLocationRepeat);
              }, TIMEOUT);
              
              };
              
              getLocationRepeat();
              
              });
              '),
  
  # Show a plot of the generated distribution
  fluidRow(column(width = 5,
                  verbatimTextOutput("lat"),
                  verbatimTextOutput("lon"),
                  verbatimTextOutput("geolocation"),
                  verbatimTextOutput("accuracy"),
                  verbatimTextOutput("time"))
           
  )
  )
)