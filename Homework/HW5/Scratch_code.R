
# Random code tried and abandoned -----------------------------------------

billboard_tidy <- billboard |> 
  pivot_longer(starts_with("wk"), 
               names_to = "week", 
               values_to = "rank", 
               values_drop_na = TRUE, 
               names_prefix = "wk", 
               names_transform = list(week = as.integer)) |> 
  janitor::clean_names() 


billboard_tidy3 <- billboard_tidy2 |> 
  mutate(date = if_else(week == 1, 
                        date_entered, 
                        date_entered + weeks(x = week)))


# top 3 artist w/ most songs in top 100 in 2003 - ranks of their songs plotted over time
billboard_tidy4 <- billboard_tidy3 |> 
  distinct(artist, track) |> 
  summarize(n = n(), 
            .by = artist) |> 
  filter(n > 2) |> 
  slice_max(n = 3, order_by = n)

billboard_tidy5 <- billboard_tidy3 |> 
  filter(artist %in% c("Jay-Z", "Dixie Chicks, The", "Houston, Whitney")) |> 
  mutate(artist = case_when(artist == "Dixie Chicks, The" ~ "The Dixie Chicks", 
                            artist == "Houston, Whitney" ~ "Whitney Houston", 
                            artist == "Jay-Z" ~ "Jay-Z"))
ggplot(billboard_tidy5, aes(date, rank, color = artist, group = track)) + 
  geom_textpath(aes(label = track)) + 
  geom_hline(yintercept = 1, color = "yellow")

# overall charting #1 songs in context of all songs
billboard_tidy6 <- billboard_tidy3 %>%
  mutate(`weeks_at_1` = sum(rank == 1),
         `peak_rank`   = ifelse(any(rank == 1), # <1> 
                                "Hit #1",
                                "Didn't hit #1"), 
         .by = c(artist, track)) 
ggplot(billboard_tidy6, aes(date, rank, group = track, color = peak_rank)) + 
  geom_line(aes(size = peak_rank), alpha = 0.4) +
  geom_label_repel(data = billboard_tidy6 |>  filter(peak_rank == "Hit #1") |>  slice_min(date, by = artist), aes(label = artist)) +
  #geom_label_repel(data = billboard_tidy6 |>  filter(peak_rank == "Hit #1") |>  slice_min(date, by = artist), aes(label = artist), nudge_y = 4, nudge_x = 2) +
  theme_tufte() +
  xlab("Date") + ylab("Rank") +
  scale_color_manual("Peak Rank", values = c("black", "red")) +
  scale_size_manual("Peak Rank", values = c(0.25, 1)) +
  theme(legend.position = c(0.1, 0.15),
        legend.background = element_rect(fill = "transparent"))

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




library(tidyverse)
inspections <- read_csv("Food_Establishment_Inspection_Data_20231028.csv")
# problems(inspections)

# read in only the variables that correspond to restaurant name, inspection date, inspection type, inspection result, and grade
inspections <- read_csv("Food_Establishment_Inspection_Data_20231028.csv", 
                        col_select = c("Name", "Inspection Date", "Inspection Type", "Inspection Result", "Grade"))

inspections_clean <- inspections |> 
  janitor::clean_names() |> 
  mutate(inspection_date = mdy(inspection_date), 
         inspection_type = fct(inspection_type), 
         inspection_result = fct(inspection_result)) |> 
  filter(year(inspection_date) == "2020")



ggplot(inspections_clean, aes(x = inspection_date, y = grade, color = grade, group = name)) +
  geom_jitter() + 
  geom_line()


