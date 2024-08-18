output$candidates_table <- renderTable({
  
  if(str_count(input$candidates) > 0){
    candidates <- distance() %>% select(ID, NAME, CLUB) %>% distinct() %>%
      mutate(ID = as.character(ID))
    
    candidates <- candidates %>% filter(
      grepl(input$candidates, NAME)
    ) %>% 
      left_join(database() %>% mutate(ID = as.character(sofifa_id)) %>% select(ID, overall) %>% rename("OVERALL" = "overall")) %>%
      arrange(-OVERALL)
  }
  
  
})



observeEvent(input$select_player,{
  
  temp <- database() %>% filter(sofifa_id == input$playerid)
  
  if(nrow(temp) > 0){
    
    
    output$player_info <- renderUI({
      
      tagList(
        div(
          div(style = "display:inline-block;float:left", tags$img(src = temp$player_face_url, width = 150)),
          div(style = "display:inline-block;float:left;margin-left:25px;",
              h2(paste0(temp$short_name, ", ", temp$club_name)),
              h4(paste0("Nationality: ", temp$nationality_name)),
              h4(paste0("Age / Dob: ", temp$age, " / ", temp$dob)),
              h4(paste0("Height / Weight: ", temp$height, " cm / ", temp$weight_kg, " kg")),
              h4(paste0("Position: ", temp$player_positions))
          )
        )
        
      )
      
      
      
    })
    #Plot Similarity
    player_distance <- distance() %>% 
      filter(ID == as.character(input$playerid)) %>%
      mutate(
        Var2 = paste0(NAME2, " | ", CLUB2)
      )
    
    output$player_similarity <- renderPlot({
      
      ggplot(player_distance, aes(fct_reorder(Var2, desc(value)), value, fill = value))+
        geom_col()+
        scale_fill_gradient(high = "#fcb914", low = "#231f20")+
        coord_flip()+
        labs(y = "Distance", x = NULL, fill = NULL, title = "Distance Matrix")+
        theme_minimal()+
        facet_wrap(~paste0(NAME, " | ", CLUB))+
        theme(strip.background = element_rect(fill="grey",color="black"),
              strip.text.x = element_text(size = 20, colour = "black", face = "bold.italic"),
              axis.text = element_text(size = 15)
        )
    })
    
    # Table Similarity
    # Tüm adaylarla birlikte idleriin seçimi
    ids <- c(input$playerid, distance() %>% 
               filter(ID == as.character(input$playerid)) %>% 
               head(5) %>% pull(ID2))
    
    output$table_similarity <- renderDataTable({
      
      ##Hyperlink
      hyperlink <- c(
        "function(data, type, row){",
        "  if(type === 'display'){",
        # row[0]: 1. değişkende URL olduğunu söyler. URL değişkeni neredeyse indeksi ona göre ayarlamak lazım
        "    var a = '<a href=\"' + row[2] + '\">' + data + '</a>';",
        "    return a;",
        "  } else {",
        "    return data;",
        "  }",
        "}"
      )
      
      
      # Adaylarla data frame incelemesi
      comp <- database() %>% filter(sofifa_id %in% ids) %>% 
        mutate(
          player_face_url = paste0('<center><img src="',player_face_url,'" height="60"></img></center>'),
          nation_flag_url = paste0('<center><img src="',nation_flag_url,'" height="30"></img></center>'),
          club_logo_url = paste0('<center><img src="',club_logo_url,'" height="52"></img></center>'),
          club_flag_url = paste0('<center><img src="',club_flag_url,'" height="30"></img></center>')
        ) %>% 
        rename_all(., list(~str_remove_all(str_to_title(gsub("[[:punct:]]", " ", .)), " Url")))
      
      datatable(comp,
                escape = FALSE, # htmller için
                filter = "top",  # değişken filtreleri
                class = "display nowrap compact",  # Satır yüksekliği
                rownames = FALSE, # satır isimleri
                # Datatable ayarları
                options = list(
                  scrollX = TRUE,
                  searching = TRUE,
                  
                  # Hyperlink: targets indeksi 0'dan başlar
                  columnDefs = list(
                    list(targets = 3, render = JS(hyperlink), searchable = T),
                    list(targets = 2, visible = FALSE)
                  )
                )
      )
    })
    
    # Radar
    plotly_addtrace <- function(plot, playerid){
      player <- database() %>% filter(sofifa_id == playerid) %>% select(short_name, pace:physic)
      
      plot %>% add_trace(
        r = c(player %>% pull(pace),player %>% pull(shooting), player %>% pull(passing ), 
              player %>% pull(dribbling ), player %>% pull(defending ), player %>% pull(physic)),
        theta = c('PAC','SHO','PAS', 'DRI', "DEF", 'PHY'),
        name = player$short_name
      )
    }
    
    output$plotly_similarity <- renderPlotly({
      
      p <-plot_ly(
        type = 'scatterpolar',
        fill = 'toself'
      )
      
      plotly_addtrace(p, ids[1]) %>%
        plotly_addtrace(ids[2]) %>%
        plotly_addtrace(ids[3]) %>%
        plotly_addtrace(ids[4])
    })
    
    x <- database() %>% filter(sofifa_id %in% ids[2:6]) %>% select(sofifa_id, short_name, club_name)
    
    y <- x$sofifa_id
    names(y) <- paste0(1:5, ". ", x$short_name, ", ", x$club_name)
    
    updateSelectInput(session, "comp_select", choices = y, selected = y[1])
    
    output$comp_similarity <- renderPlot({
      
      players <- database() %>%
        filter(sofifa_id %in% c(ids[1], input$comp_select)) %>%
        # unite name & club variables
        mutate(Name = paste0(short_name, ", ", club_name)) %>%
        # selection abilities of the players
        select(Name,attacking_crossing:defending_sliding_tackle) %>%
        gather(Skill, Exp, attacking_crossing:defending_sliding_tackle, -Name) %>%
        # correction of the punctuation
        # rename_all(funs(gsub("[[:punct:]]", " ", .)))
        rename_with(~ gsub("[[:punct:]]", " ", .))
      
      # becerilere gore futbolcularin birlikte gorsellestirilmesi
      ggplot(players, aes(Skill, Exp, fill = Name))+
        geom_col(position = "fill")+
        coord_flip()+
        scale_fill_manual(values = c("#fcb914", "#231f20"))+
        geom_hline(yintercept = 0.5, color = "white", linewidth = 1, linetype = 2)+
        theme(
          legend.position = "top",
          legend.text = element_text(size = 20),
          axis.text.x = element_blank(),
          plot.title = element_text(hjust = 0.5),
          axis.text = element_text (size = 15))+
        labs(fill = NULL, x = NULL, y = NULL)+
        scale_y_reverse()
    })
    
    oyuncu_isimleri <- player_distance$Var2  # Oyuncu isimlerini saklayın
    
    hiy <- hclust(dist(player_distance$value))
    
    output$dendrogram <- renderPlot({
      plot(hiy, labels = oyuncu_isimleri, main = paste("Dendrogram for:", temp$short_name, "|", temp$club_name), xlab="", sub="", cex=0.8)
      rect.hclust(hiy, k=7, border="orange")
    }, width = 1400, height = 500)
    
    
  }
  else{
    sendSweetAlert(session = session, type = "warning", 
                   title = "Please enter a valid player name!",closeOnClickOutside = FALSE)
  }
  
})







