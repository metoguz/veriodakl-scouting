output$wolver_database <- renderDataTable({
  
  
  temp <- database() %>%
    filter(club_name == "Wolverhampton Wanderers") %>%
    mutate(
      player_face_url = paste0('<center><img src="', player_face_url, '" height="80"></img></center>'),
      nation_flag_url = paste0('<center><img src="', nation_flag_url, '" height="30"></img></center>'),
      club_logo_url = paste0('<center><img src="', club_logo_url, '" height="60"></img></center>'),
      club_flag_url = paste0('<center><img src="', club_flag_url, '" height="30"></img></center>')
    ) %>% 
    rename_all(., list(~str_remove_all(str_to_title(gsub("[[:punct:]]", " ", .)), "Url")))
  
  datatable(temp,
            
            class = "display nowrap compact", # Satir Yuksekligi
            escape = FALSE, # html icin 
            filter = "top",
            rownames = FALSE, # satir isimleri
            
            options = list(
              
              scrollX = TRUE,
              
              # HyperLink targets indeksi 0dan baslar
              columnDefs = list(
                
                list(targets = 3, render = JS(hyperlink), searchable = T),
                list(targets = 2, visible = FALSE)
              )
              
            )
            
  )
  
})
