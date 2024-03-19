# Creating rubric object that can be used site-wide

library(tidyverse)
library(gt)

## homework

rubric_table <- tibble(Evaluation = c("Didn't turn anything in.", 
                                "Turned in but low effort, ignoring many directions.", 
                                "Decent effort, followed directions with some minor issues.", 
                                "Nailed it!"), 
                 Points = 0:3)

rubric <- rubric_table |>  
  gt() |> 
  tab_options(table.font.names = c("Quattrocento", "Raleway")) |>
  cols_align(align = "center") |> 
  # Color each evaluation
  tab_style(style = cell_fill(color = "#e15759"),
            locations = cells_body(rows = Points == 0)) |> 
  tab_style(style = cell_fill(color = "#f28e2c"),
            locations = cells_body(rows = Points == 1)) |> 
  tab_style(style = cell_fill(color = "#76b7b2"),
            locations = cells_body(rows = Points == 2)) |> 
  tab_style(style = cell_fill(color = "#4e79a7"),
            locations = cells_body(rows = Points == 3)) |> 
  # Change label font style
  cols_label(Evaluation = md("**Evaluation**"), 
             Points = md("**Points**")) |> 
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
            locations = cells_body(rows = Points == 3))

## peer review

peer_review_table <- tibble(Evaluation = c("Didn't follow all peer-review instructions.", 
                                           "Peer review is at least several sentences long, <br> 
                                           mentions any and all key issues from the assignment, <br> 
                                           and points out at least one positive thing in your <br> 
                                           peer’s work (and hopefully more!)."),
                            Points = 0:1)

peer_review_rubric <- peer_review_table |> 
  gt() |> 
  tab_options(table.font.names = c("Quattrocento", "Raleway")) |>
  cols_align(align = "center") |> 
  # Color each evaluation
  tab_style(style = cell_fill(color = "#59a14f"),
            locations = cells_body(rows = Points == 1)) |> 
  tab_style(style = cell_fill(color = "#edc949"),
            locations = cells_body(rows = Points == 0)) |> 
  # Change label font style
  cols_label(Evaluation = md("**Evaluation**"), 
             Points = md("**Points**")) |> 
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
  fmt_markdown(columns = TRUE)
