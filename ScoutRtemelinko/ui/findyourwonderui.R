tabPanel("Find Your Wonderkid",
         
         wellPanel(
           
           
           
           
           
           
           
           
           
           
           
           fluidRow(column(width = 5,
                           
                           
                           sliderInput("wk_age", label = "Age Range:", min=18, max=25, value=c(19,23)),
                           sliderInput("wk_overall", label = "Overall Range:", min=65, max=90, value=c(66,89)),
                           sliderInput("wk_potential", label = "Potential Range:", min=75, max=99, value=c(76,98))
                           
           ),
           column(width = 2),
           column(width = 5,
                  
                  
                  pickerInput(inputId = "wk_foot", label = "Preferred Foot:",
                              choices = c("Left", "Right"), selected = c("Left", "Right"), multiple = T, width = 250),
                  pickerInput(inputId = "wk_league", label = "League:",
                              choices = NULL, selected = NULL, multiple = T, width = 250),
                  pickerInput(inputId = "wk_position", label = "Position:", 
                              choices = NULL, selected = NULL, multiple = T, width = 250)
           )
           )  
           
         ),
         fluidRow(
           
           column(width = 12,
                  
                  
                  hr(),
                  dataTableOutput("wonderkid"),
                  
                  tags$style(type = "text/css", ".noUi-connect {background: #fcb914}"),
                  
                  tags$head(tags$style("#wonderkid thead th{background: #fcb914; color:#231f20}")),
                  
                  tags$head(tags$style("#wonderkid tbody td{boreder-top: 0.1px solid grey;border-left: 0.1px solid grey;border-right: 0.1px solid grey;}")),
                  
                  
                  
           )
         )
         
         
)
