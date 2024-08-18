observe({
  
  req(database())
  
  minimum <- as.integer(min(database()[, "value_eur"], na.rm = TRUE))
  maximum <- as.integer(max(database()[, "value_eur"], na.rm = TRUE))
  
  updateSliderInput(session, "tl_value", min = minimum, max = maximum, value = c(minimum, maximum))
  
  
  
})

observe({
  
  req(database())
  
  minimum <- as.integer(min(database()[, "age"], na.rm = TRUE))
  maximum <- as.integer(max(database()[, "age"], na.rm = TRUE))
  
  updateSliderInput(session, "tl_age", min = minimum, max = maximum, value = c(minimum, maximum))
  
  
  
})

observe({
  
  req(database())
  
  minimum <- as.integer(min(database()[, "overall"], na.rm = TRUE))
  maximum <- as.integer(max(database()[, "overall"], na.rm = TRUE))
  
  updateSliderInput(session, "tl_overall", min = minimum, max = maximum, value = c(minimum, maximum))
  
  
  
})


observe({
  
  req(database())
  
  end <- sort(unique(database()[, "club_contract_valid_until"]))
  
  updateNumericInput(session, "tl_contract", min = min(end, na.rm = TRUE), max = max(end, na.rm = TRUE), value = 2023, step = 1)
  
})

observe({
  
  req(database())
  
  league <- sort(unique(database()[, "league_name"]))
  league <- league[str_count(league) > 1]
  
  updatePickerInput(session, "tl_league", choices = league, selected = league[1:5])
  
})

observe({
  
  req(database())
  
  pos <- sort(unique(database()[, "club_position"]))
  pos <- pos[str_count(pos) > 1]
  
  updatePickerInput(session, "tl_position", choices = pos, selected = pos)
  
  
})


output$transferdt <- renderDataTable({
  
  
  temp <- database() %>% 
    filter(
      # Value
      value_eur >= min(input$tl_value), value_eur <= max(input$tl_value),
      # Age
      age >= min(input$tl_age), age <= max(input$tl_age),
      # Overall
      overall >= min(input$tl_overall), overall <= max(input$tl_overall),
      # Contract
      club_contract_valid_until == input$tl_contract,
      # foot
      preferred_foot %in% input$tl_foot,
      # League
      league_name %in% input$tl_league,
      # Position
      club_position %in% input$tl_position
    ) %>% 
    mutate(
      player_face_url = paste0('<center><img src="',player_face_url,'" height="60"></img></center>'),
      nation_flag_url = paste0('<center><img src="',nation_flag_url,'" height="30"></img></center>'),
      club_logo_url = paste0('<center><img src="',club_logo_url,'" height="52"></img></center>')
    ) %>%
    select(-nation_flag_url) %>%
    select(sofifa_id:club_name, overall, preferred_foot, value_eur, league_name, club_position) %>%
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
  )  %>% formatCurrency("Value Eur", currency = "€")
})


observe({
  
  req(database())
  req(input$tl_value)
  req(input$tl_age)
  req(input$tl_overall)
  req(input$tl_league)
  req(input$tl_position)
  
  temp <- database() %>% 
    filter(
      # Value
      value_eur >= min(input$tl_value), value_eur <= max(input$tl_value),
      # Age
      age >= min(input$tl_age), age <= max(input$tl_age),
      # Overall
      overall >= min(input$tl_overall), overall <= max(input$tl_overall),
      # Contract
      club_contract_valid_until == input$tl_contract,
      # foot
      preferred_foot %in% input$tl_foot,
      # League
      league_name %in% input$tl_league,
      # Position
      club_position %in% input$tl_position
    ) %>% 
    mutate(
      player_face_url = paste0('<center><img src="',player_face_url,'" height="60"></img></center>'),
      nation_flag_url = paste0('<center><img src="',nation_flag_url,'" height="30"></img></center>'),
      club_logo_url = paste0('<center><img src="',club_logo_url,'" height="52"></img></center>')
    ) %>%
    select(-nation_flag_url) %>%
    select(sofifa_id:club_name, overall, preferred_foot, value_eur, league_name, club_position) %>%
    rename_all(., list(~str_remove_all(str_to_title(gsub("[[:punct:]]", " ", .)), " Url"))) 
  
  
  fname <- paste0("transferlist", str_remove_all(as.character(Sys.time()), ":") ,".xlsx")
  
  output$download <- downloadHandler(
    
    filename = function(){fname},
    content = function(filename){write.xlsx(temp, filename)}
    
  )
})







