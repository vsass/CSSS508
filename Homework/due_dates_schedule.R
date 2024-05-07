
# Creating base schedule table function for CSSS 508

library(gt)
library(tidyverse)

schedule_fall <- tibble(Homework = c(1:9), 
                             Due_Date_AA = c("10 October", "17 October", "24 October", "31 October", "7 November", "14 November", "21 November", "28 November", "5 December"), 
                             Peer_Due_Date_AA = c("15 October", "22 October", "29 October", "5 November", "12 November", "19 November", "26 November", "3 November", "10 December"), 
                             Due_Date_AB = c("12 October", "19 October", "26 October", "2 November", "9 November", "16 November", "23 November", "30 November", "7 December"), 
                             Peer_Due_Date_AB = c("17 October", "24 October", "31 October", "7 November", "14 November", "21 November", "28 November", "5 November", "12 December"))

schedule_spring <- tibble(Homework = c(1:9), 
                               Due_Date = c("2 April", "9 April", "16 April", "23 April", "30 April", "7 May", "14 May", "21 May", "28 May"), 
                               Peer_Due_Date = c("7 April", "14 April", "21 April", "28 April", "5 May", "12 May", "19 May", "26 May", "2 June"), 
)

make_due_date_table_fall <- function(week){
  due_dates_table <- schedule_fall |> 
    gt() |> 
    # Group sections AA and AB together
    tab_spanner(label = md("**Section AA**"),
                columns = c(Due_Date_AA, Peer_Due_Date_AA)) |> 
    tab_spanner(label = md("**Section AB**"),
                columns = c(Due_Date_AB, Peer_Due_Date_AB), 
                id = "AB") |> 
    cols_align(align = "center") |> 
    cols_label(Homework = "#",
               Due_Date_AA = "Homework Due",
               Peer_Due_Date_AA = "Peer Review Due",
               Due_Date_AB = "Homework Due",
               Peer_Due_Date_AB = "Peer Review Due") |> 
    # aligning table on page, picking font, increasing overall table size
    tab_options(table.align = "center", table.font.names = c("Quattrocento", "Raleway"), 
                table.font.size = pct(100), table.border.top.style = "hidden") |>
    # Adding color to column names and due date row
    tab_style(style = cell_fill(color = "#c7cdac"),
              locations = list(cells_column_labels(columns = c(Due_Date_AA, Due_Date_AB)), 
                               cells_body(columns = c(Due_Date_AA, Due_Date_AB), 
                                          rows = Homework == week))) |> 
    tab_style(style = cell_fill(color = "#99a486"),
              locations = list(cells_column_labels(columns = c(Peer_Due_Date_AA, Peer_Due_Date_AB)), 
                               cells_body(columns = c(Peer_Due_Date_AA, Peer_Due_Date_AB), 
                                          rows = Homework == week))) |> 
    # adding borders around due dates
    tab_style(style = cell_borders(sides = c("bottom", "top"),  weight = px(3), color = "#1e4655"),
              locations = cells_body(rows = Homework == week)) |> 
    tab_style(style = cell_borders(sides = "left",  weight = px(3), color = "#1e4655"), 
              locations = cells_body(rows = Homework == week, 
                                     columns = Homework)) |> 
    tab_style(style = cell_borders(sides = "right",  weight = px(3), color = "#1e4655"), 
              locations = cells_body(rows = Homework == week, 
                                     columns = Peer_Due_Date_AB))
  
  return(due_dates_table)
}

make_due_date_table_spring <- function(week){
  due_dates_table <- schedule_spring |> 
    gt() |> 
    cols_align(align = "center") |> 
    cols_label(Homework = "#",
               Due_Date = "Homework Due",
               Peer_Due_Date = "Peer Review Due") |> 
    # aligning table on page, picking font, increasing overall table size
    tab_options(table.align = "center", table.font.names = c("Quattrocento", "Raleway"), 
                table.font.size = pct(100), table.border.top.style = "hidden") |>
    # Adding color to column names and due date row
    tab_style(style = cell_fill(color = "#c7cdac"),
              locations = list(cells_column_labels(columns = c(Due_Date)), 
                               cells_body(columns = c(Due_Date), 
                                          rows = Homework == week))) |> 
    tab_style(style = cell_fill(color = "#99a486"),
              locations = list(cells_column_labels(columns = c(Peer_Due_Date)), 
                               cells_body(columns = c(Peer_Due_Date), 
                                          rows = Homework == week))) |> 
    # adding borders around due dates
    tab_style(style = cell_borders(sides = c("bottom", "top"),  weight = px(3), color = "#1e4655"),
              locations = cells_body(rows = Homework == week)) |> 
    tab_style(style = cell_borders(sides = "left",  weight = px(3), color = "#1e4655"), 
              locations = cells_body(rows = Homework == week, 
                                     columns = Homework)) |> 
    tab_style(style = cell_borders(sides = "right",  weight = px(3), color = "#1e4655"), 
              locations = cells_body(rows = Homework == week, 
                                     columns = Peer_Due_Date))
  
  return(due_dates_table)
}
