# Kutuphane
library(shiny)
library(DT)
library(tidyverse)
library(plotly)
library(shinyWidgets)
library(openxlsx)
library(dplyr)
library(ggplot2)
library(forcats)
library(cluster)
library(dendextend)
library(factoextra)

# Globals
source("global.R")


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # 3.1 CSS
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "ScoutRtemelinko.css")
  ),
  # 3.2 JavaScript
  tags$head(tags$script(type = "text/javascript", src = "ScoutRremelinko.js")),
  # 3.3 Navbar
  navbarPage(
    
    title = tagList(
      tags$img(src = "wolverhampton.png", width = 70, style = "margin-top: -10px;display:inline;"),
      h3("Wolverhampton App", style = "display:inline;"),
      tags$script(
        HTML("
      $(document).ready(function(){
        $('.navbar .container-fluid').append('<img src=\"premierleague.png\" width=\"90px\" style=\"float: right;\">');
      });
    ")
      )
    ),
    
    source("ui/dataui.R", local = TRUE, encoding = "UTF-8")$value,
    source("ui/ourteamui.R", local = TRUE, encoding = "UTF-8")$value,
    source("ui/scoutingui.R", local = TRUE, encoding = "UTF-8")$value,
    source("ui/transferlistui.R", local = TRUE, encoding = "UTF-8")$value,
    source("ui/findyourwonderui.R", local = TRUE, encoding = "UTF-8")$value
    
    
    
  )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  source(file.path("server", "ReactiveDataserver.R"), local = TRUE, encoding = "UTF-8")$value
  source(file.path("server", "ourteamserver.R"), local = TRUE, encoding = "UTF-8")$value
  source(file.path("server", "dataserver.R"), local = TRUE, encoding = "UTF-8")$value
  source(file.path("server", "scoutingserver.R"), local = TRUE, encoding = "UTF-8")$value
  source(file.path("server", "transferlistserver.R"), local = TRUE, encoding = "UTF-8")$value
  source(file.path("server", "findyourwonderserver.R"), local = TRUE, encoding = "UTF-8")$value
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)
