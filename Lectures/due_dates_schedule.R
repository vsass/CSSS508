
# Creating base schedule table for CSSS 508

library(gt)
library(tidyverse)

schedule <- tibble(Homework = c(1:9), 
                   Due_Date_AA = c("10 October", "17 October", "24 October", "31 October", "7 November", "14 November", "21 November", "28 November", "5 December"), 
                   Peer_Due_Date_AA = c("15 October", "22 October", "29 October", "5 November", "12 November", "19 November", "26 November", "3 November", "10 December"), 
                   Due_Date_AB = c("12 October", "19 October", "26 October", "2 November", "9 November", "16 November", "23 November", "30 November", "7 December"), 
                   Peer_Due_Date_AB = c("17 October", "24 October", "31 October", "7 November", "14 November", "21 November", "28 November", "5 November", "12 December"))

base_schedule <- schedule |> 
  gt() |> 
  # Group sections AA and AB together
  tab_spanner(label = md("**Section AA**"),
              columns = vars(Due_Date_AA, Peer_Due_Date_AA)) |> 
  tab_spanner(label = md("**Section AB**"),
              columns = vars(Due_Date_AB, Peer_Due_Date_AB), 
              id = "AB") |> 
  cols_align(align = "center") |> 
  cols_label(Homework = "#",
             Due_Date_AA = "Homework Due",
             Peer_Due_Date_AA = "Peer Review Due",
             Due_Date_AB = "Homework Due",
             Peer_Due_Date_AB = "Peer Review Due") |> 
  # aligning table on page, picking font, increasing overall table size
  tab_options(table.align = "center", table.font.names = c("Quattrocento", "Raleway"), 
              table.font.size = pct(100), table.border.top.style = "hidden", table.border.bottom.style = "hidden") |>
  # Adding color to column names
  tab_style(style = cell_fill(color = "#c7cdac"),
            locations = cells_column_labels(columns = c(Due_Date_AA, Due_Date_AB))) |> 
  tab_style(style = cell_fill(color = "#99a486"),
            locations = cells_column_labels(columns = c(Peer_Due_Date_AA, Peer_Due_Date_AB)))
