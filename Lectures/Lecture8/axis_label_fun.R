# https://gist.github.com/GShotwell/b19ef520b6d56f61a830fabb3454965b

library(tidyverse)
library(lubridate)

df <- tibble(
  dist1 = sort(rnorm(100, 5, 2)), 
  dist2 = sort(rnorm(100, 8, 3)),
  dist4 = sort(rnorm(100, 15, 1)),
  date = seq.Date(from = ymd("2022-01-01"), ymd("2022-04-10"), by = "day")
)

df <- pivot_longer(df, cols = -date, names_to = "dist_name", values_to = "value")

fancy_ts <- function(df, val, group) {
  labs <- df |> 
    group_by({{group}}) |> 
    summarize(breaks = max({{val}}))
  
  ggplot(df, 
         aes(
           x = date, 
           y = {{val}}, 
           group = {{group}}, 
           color = {{group}})) +
    geom_path() +
    scale_y_continuous(breaks = labs$breaks, minor_breaks = NULL) +
    theme_minimal()
}

fancy_ts(df, value, dist_name)
