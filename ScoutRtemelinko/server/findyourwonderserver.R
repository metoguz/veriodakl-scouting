observe({
  
  req(database())
  
  minimum <- as.integer(min(database()[, "age"], na.rm = TRUE))
  maximum <- as.integer(max(database()[, "age"], na.rm = TRUE))
  
  updateSliderInput(session, "wk_age", min = 18, max = 25, value = c(18, 25))
  
  
  
})

observe({
  
  req(database())
  
  minimum <- as.integer(min(database()[, "overall"], na.rm = TRUE))
  maximum <- as.integer(max(database()[, "overall"], na.rm = TRUE))
  
  updateSliderInput(session, "wk_overall", min = 65, max = 90, value = c(65, 90))
  
  
  
})

observe({
  
  req(database())
  
  minimum <- as.integer(min(database()[, "potential"], na.rm = TRUE))
  maximum <- as.integer(max(database()[, "potential"], na.rm = TRUE))
  
  updateSliderInput(session, "wk_potential", min = 75, max = 99, value = c(75, 99))
  
  
  
})

observe({
  
  req(database())
  
  league <- sort(unique(database()[, "league_name"]))
  league <- league[str_count(league) > 1]
  
  updatePickerInput(session, "wk_league", choices = league, selected = league[1:5])
  
})

observe({
  
  req(database())
  
  pos <- sort(unique(database()[, "club_position"]))
  pos <- pos[str_count(pos) > 1]
  
  updatePickerInput(session, "wk_position", choices = pos, selected = pos)
  
  
})

output$wonderkid <- renderDataTable({
  
  
  temp <- database() %>% 
    filter(
      # Age
      age >= min(input$wk_age), age <= max(input$wk_age),
      # Overall
      overall >= min(input$wk_overall), overall <= max(input$wk_overall),
      # Potential
      potential >= min(input$wk_overall), overall <= max(input$wk_overall),
      # foot
      preferred_foot %in% input$wk_foot,
      # League
      league_name %in% input$wk_league,
      # Position
      club_position %in% input$wk_position
    ) %>% mutate(
      player_face_url = paste0('<center><img src="',player_face_url,'" height="60"></img></center>'),
      nation_flag_url = paste0('<center><img src="',nation_flag_url,'" height="30"></img></center>'),
      club_logo_url = paste0('<center><img src="',club_logo_url,'" height="52"></img></center>')
    ) %>%
    select(-nation_flag_url) %>%
    select(sofifa_id:club_name, overall, potential, preferred_foot, league_name, club_position) %>%
    rename_all(., list(~str_remove_all(str_to_title(gsub("[[:punct:]]", " ", .)), " Url"))) 
  
  datatable(
    temp,
    escape = FALSE, # htmller için
    # Tablonun başındaki filtreleme seçeneği
    filter = list(position = 'top', clear = TRUE, plain = F),  # değişken filtreleri
    class = "display nowrap compact",  # Satır yüksekliği
    rownames = FALSE, # satır isimleri
    #selection = "multiple", #satır seçimi
    # Datatable ayarları
    options = list(
      scrollX = TRUE,
      searching = TRUE,
      dom = 'rtip',
      # Hyperlink: targets indeksi 0'dan başlar
      columnDefs = list(
        list(targets = 3, render = JS(hyperlink), searchable = T),
        list(targets = 2, visible = FALSE)
      )
    )
  )
})

