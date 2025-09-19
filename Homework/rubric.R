# Creating rubric object that can be used site-wide

library(tidyverse)
library(gt)

## homework

rubric_table <- tibble(Evaluation = c("Didn't turn anything in.", 
                                "Turned in but low effort, <br> ignoring many directions.", 
                                "Decent effort, followed directions <br> with some minor issues.", 
                                "Nailed it!") |> str_wrap(width = 50), 
                 Points = 0:3)

rubric <- rubric_table |>  
  gt() |> 
  tab_options(table.font.names = c("Quattrocento", "Raleway")) |>
  cols_align(align = "center") |> 
  # Color each evaluation
  tab_style(style = list(cell_fill(color = "#f15a30"), 
                         cell_text(color = "white", size = "large")),
            locations = cells_body(rows = Points == 0)) |> 
  tab_style(style = list(cell_fill(color = "#8b835b"), 
                         cell_text(color = "white", size = "large")),
            locations = cells_body(rows = Points == 1)) |> 
  tab_style(style = list(cell_fill(color = "#5a82b3"), 
                         cell_text(color = "white", size = "large")),
            locations = cells_body(rows = Points == 2)) |> 
  tab_style(style = list(cell_fill(color = "#9a72aa"), 
                         cell_text(color = "white", size = "large")),
            locations = cells_body(rows = Points == 3)) |> 
  # make column labels bold
  tab_style(style = cell_text(weight = "bolder", size = "x-large", stretch = "expanded"), 
            locations = cells_column_labels(columns = everything())) |>
  # Adding border around label row
  tab_style(style = cell_borders(sides = "top",  weight = px(2)),
            locations = cells_column_labels()) |> 
  tab_style(style = cell_borders(sides = "left",  weight = px(2)),
            locations = list(cells_column_labels(columns = "Evaluation"),
                             cells_body(columns = "Evaluation"))) |> 
  tab_style(style = cell_borders(sides = "right",  weight = px(2)),
            locations = list(cells_column_labels(columns = "Points"), 
                             cells_body(columns = "Points"))) |> 
  tab_style(style = cell_borders(sides = "bottom",  weight = px(2)),
            locations = cells_body(rows = Points == 3)) |> 
  fmt_markdown(columns = everything()) |> 
  cols_width(Points ~ pct(10), 
             Evaluation ~ pct(25)) |> 
  opt_vertical_padding(scale = 1.15)

## peer review

peer_review_table <- tibble(Evaluation = c("Didn't follow all peer-review instructions.", 
                                           "Peer review is at least several sentences long, 
                                           mentions any and all key issues from the assignment, 
                                           and points out at least one positive thing in your 
                                           peer’s work (and hopefully more!)."),
                            Points = 0:1)

peer_review_rubric <- peer_review_table |> 
  gt() |> 
  tab_options(table.font.names = c("Quattrocento", "Raleway")) |>
  cols_align(align = "center") |> 
  # Specify column widths
  # Color each evaluation
  tab_style(style = list(cell_fill(color = "#4e1d4c"), cell_text(color = "white")),
            locations = cells_body(rows = Points == 1)) |> 
  tab_style(style = list(cell_fill(color = "#f99d1b"), cell_text(color = "black")),
            locations = cells_body(rows = Points == 0)) |> 
  # make column labels bold
  tab_style(style = cell_text(weight = "bolder", size = "x-large", stretch = "expanded"), 
            locations = cells_column_labels(columns = everything())) |>
  # Adding border around label row
  tab_style(style = cell_borders(sides = "top",  weight = px(2)),
            locations = cells_column_labels()) |> 
  tab_style(style = cell_borders(sides = "left",  weight = px(2)),
            locations = list(cells_column_labels(columns = "Evaluation"),
                             cells_body(columns = "Evaluation"))) |> 
  tab_style(style = cell_borders(sides = "right",  weight = px(2)),
            locations = list(cells_column_labels(columns = "Points"), 
                             cells_body(columns = "Points"))) |> 
  tab_style(style = cell_borders(sides = "bottom",  weight = px(2)),
            locations = cells_body(rows = Points == 1)) |> 
  fmt_markdown(columns = everything()) |> 
  cols_width(Points ~ pct(10), 
             Evaluation ~ pct(25)) |> 
  opt_vertical_padding(scale = 1.25)

