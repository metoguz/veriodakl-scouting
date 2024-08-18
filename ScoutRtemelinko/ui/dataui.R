tabPanel("Data",
         # 17.17
         fluidRow(
           
           column(width = 12,
                  
                  tabsetPanel(
                    
                    type = 'pills',
                    
                    tabPanel("Database",
                             
                             hr(),
                             
                             dataTableOutput("player_database"),
                             # numerik input slider icin
                             tags$style(type= "text/css", ".noUi-connect {background: #fcb914;}"),
                             # DT sutun renk ayari
                             tags$head(tags$style("#player_database thead th{background-color: #fcb914; color: #231f20;}")),
                             # satir sutun cizgileri
                             tags$head(tags$style("#player_database tbody td{border-top: 0.1px solid grey;border-left: 0.1px solid grey;border-right: 0.1px solid grey}"))
                    ),
                    
                    tabPanel("Distance",
                             
                             hr(),
                             
                             dataTableOutput("player_distance"),
                             # numerik input slider icin
                             tags$style(type= "text/css", ".noUi-connect {background: #fcb914;}"),
                             # DT sutun renk ayari
                             tags$head(tags$style("#player_distance thead th{background-color: #fcb914; color: #231f20;}")),
                             # satir sutun cizgileri
                             tags$head(tags$style("#player_distance tbody td{border-top: 0.1px solid grey;border-left: 0.1px solid grey;border-right: 0.1px solid grey}"))
                             
                    )
                    
                  )
                  
           )
           
         )
         
)