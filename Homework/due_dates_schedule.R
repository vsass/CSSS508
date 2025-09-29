
# Creating base schedule table function for CSSS 508

library(gt)
library(tidyverse)

schedule_fall <- tibble(Homework = c(1:9), 
                             Due_Date = c("7 October", "14 October", "21 October", "28 October", "11 November", "18 November", "25 November", "2 December", "9 December"), 
                             Peer_Due_Date = c("12 October", "19 October", "26 October", "2 November", "16 November", "23 November", "30 November", "7 December", "14 December"))

schedule_spring <- tibble(Homework = c(1:9), 
                               Due_Date = c("2 April", "9 April", "16 April", "23 April", "30 April", "7 May", "14 May", "21 May", "28 May"), 
                               Peer_Due_Date = c("7 April", "14 April", "21 April", "28 April", "5 May", "12 May", "19 May", "26 May", "2 June"), 
)

make_due_date_table_fall <- function(week){
  due_dates_table <- schedule_fall |> 
    gt() |> 
    cols_align(align = "center") |> 
    cols_label(Homework = "#",
               Due_Date = "Homework Due",
               Peer_Due_Date = "Peer Review Due") |> 
    # aligning table on page, picking font, increasing overall table size
    tab_options(table.align = "center", table.font.names = c("Quattrocento", "Raleway"), 
                table.font.size = pct(100), table.border.top.style = "hidden") |>
    # make column labels bold
    tab_style(style = cell_text(weight = "bolder", size = "large"), 
              locations = cells_column_labels(columns = everything())) |>
    # Adding color to column names and due date row
    tab_style(style = cell_fill(color = "#c7cdac"),
              locations = list(cells_column_labels(columns = c(Due_Date)), 
                               cells_body(columns = c(Due_Date), 
                                          rows = Homework == week))) |> 
    tab_style(style = list(cell_fill(color = "#99a486"), cell_text(color = "white")),
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
                                     columns = Peer_Due_Date)) |> 
    cols_width(Homework ~ pct(10), 
               contains("Date") ~ px(45)) |> 
    tab_options(table.width = pct(65), table.font.size = pct(105)) 
  return(due_dates_table)
}  

make_due_date_table_spring <- function(week){
  due_dates_table <- schedule_spring |> 
    gt() |> 
    cols_align(align = "center") |> 
    cols_label(Homework = "#",
               Due_Date = "Homework Due",
               Peer_Due_Date = "Peer Review Due") |> 
    # make column labels bold
    tab_style(style = cell_text(weight = "bolder", size = "large"), 
              locations = cells_column_labels(columns = everything())) |>
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
