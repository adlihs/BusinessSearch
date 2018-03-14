
library('shiny')
#runGitHub(repo = 'shiny_geolocation', username = 'AugustT', subdir = 'simple_example')

shinyUI(
  fluidPage(
    titlePanel("Using Geolocation"),
    
    tags$script(
      '$(document).ready(function() {
      
      function getLocation(callBack){
      var options = {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0
      };
      
      navigator.geolocation.getCurrentPosition(onSuccess,onError);
      
      
      function onError (err) {
      Shiny.onInputChange("geolocation", false);
      }
      
      function onSuccess (position) {
      setTimeout(function () {
      var coords = position.coords;
      var timestamp = new Date();
      
      console.log(coords.latitude + ", " + coords.longitude + "," + coords.accuracy);
      Shiny.onInputChange("geolocation", true);
      Shiny.onInputChange("lat", coords.latitude);
      Shiny.onInputChange("lon", coords.longitude);
      Shiny.onInputChange("accuracy", coords.accuracy);
      Shiny.onInputChange("time", timestamp)
      
      console.log(timestamp);
      
      if(callback){
      callback();
      }
      },1100)
      }
      }
      var TIMEOUT = 1000;
      var started = false;
      
      function getLocationRepeat(){
      if (!started) {
      started = true;
      getLocation(getLocationRepeat);
      return;
      }
      setTimeout(function(){
      
      getLocation(getLocationReepeat);
      }, TIMEOUT);
      };
      getLocationRepeat();
      });
      '
    ),
    
    #show a plot of the generated distribution
    fluidRow(
      column(
        width = 2,
        verbatimTextOutput("lat"),
        verbatimTextOutput("lon"),
        verbatimTextOutput("geolocation"),
        verbatimTextOutput("accuracy"),
        verbatimTextOutput("time")
      )
    )
  )
)
