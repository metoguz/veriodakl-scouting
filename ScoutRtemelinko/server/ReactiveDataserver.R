database <- reactive({
  read.csv("data/database.csv") %>%
    select(-nation_logo_url, -long_name, -club_team_id, 
           -nationality_id, -nation_team_id, -real_face, -X) %>%
    select(
      sofifa_id, player_face_url, player_url, short_name, age, dob, 
      nationality_name, nation_flag_url, club_name, club_logo_url, 
      club_flag_url, league_name, league_level, height_cm, weight_kg, 
      overall, potential, player_positions, club_position, preferred_foot, 
      weak_foot, skill_moves, international_reputation, work_rate, body_type, 
      value_eur, wage_eur, release_clause_eur, club_joined, club_loaned_from,
      club_contract_valid_until, pace:defending_sliding_tackle, player_tags, 
      player_traits)
})

distance <- reactive({
  read.csv("data/distance.csv")
})