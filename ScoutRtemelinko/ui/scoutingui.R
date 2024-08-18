tabPanel("Scouting",
         
         fluidRow(
           
           column(width = 12,
                  
                  tabsetPanel(
                    type ="pills",
                    
                    tabPanel("Search",
                             hr(),
                             column(width = 6,
                                    textInput("candidates", label = "Player Name", width = 250, value = "Ronaldo"),
                                    tableOutput("candidates_table")
                             ),
                             column(width = 6,
                                    div(
                                      div(
                                        style = "display:inline-block;float:left",
                                        textInput("playerid",
                                                  label = "Please enter a valid player id!",
                                                  width = 250)
                                      ),
                                      div(
                                        style = "display:inline-block;float:left;margin: 25px 10px;",
                                        actionButton("select_player", "Select Player"),
                                      ),
                                      div(style = "clear:both;")
                                    ),
                                    
                                    
                                    uiOutput("player_info")
                             )
                    ),
                    tabPanel("Similarity",
                             hr(),
                             plotOutput("player_similarity", height = "800px")
                    ),
                    tabPanel("Table",
                             hr(),
                             dataTableOutput("table_similarity"),
                             # Nümerik input slider için
                             tags$style(type = "text/css",".noUi-connect {background: #fcb914;}"), 
                             # DT sütun renk ayarı
                             tags$head(tags$style("#table_similarity thead th{background-color: #fcb914; color: #231f20;}")),
                             # Satır Sütun çizgileri
                             tags$head(tags$style("#table_similarity tbody td {border-top: 0.1px solid grey;border-left: 0.1px solid grey;border-right: 0.1px solid grey;}"))
                    ),
                    tabPanel("Radar",
                             hr(),
                             plotlyOutput("plotly_similarity")
                    ),
                    tabPanel("Comparison",
                             hr(),
                             conditionalPanel(
                               condition = "input.select_player",
                               selectInput("comp_select", label = "Select Player", choices = NULL, selected = NULL),
                               plotOutput("comp_similarity", height = "800px")
                             ),
                    ),
                    tabPanel("Hierarchical Clustering",
                             hr(),
                             plotOutput("dendrogram")
                    )
                  )
                  
                  
           )
         )
)