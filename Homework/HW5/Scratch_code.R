
# Random code tried and abandoned -----------------------------------------



# Make data to visualize all songs charting in top 3 for longest by month
billboard_top3_month <- billboard_tidy_date |> 
  mutate(month = month(date), 
         year = year(date),
         top3 = if_else(rank <= 3 & year == 2000, 1, 0)) |> 
  mutate(peak_weeks = sum(top3), 
         .by = c(month, artist, track)) |> 
  filter(any(top3 == 1), 
         .by = c(track, artist)) |> 
  mutate(max_peak = max(peak_weeks), 
         .by = month) |> 
  filter(any(peak_weeks == max_peak), 
         .by = c(track, artist)) |> 
  mutate(max_month = if_else(peak_weeks == max_peak, month, NA)) |> 
  group_by(artist, track) |> 
  fill(max_month, .direction = "updown") |> 
  ungroup()

# visualization
ggplot(billboard_top3_month, aes(date, rank, group = track, color = artist)) +
  geom_line() +
  geom_label_repel(data = billboard_top3_month |> slice_min(date, by = c(max_month, track)), aes(label = track)) +
  facet_wrap(vars(max_month), nrow = 4, ncol = 3) 



