########################
### Lecture 8 R Code ###
########################

# Note: Anything behind a # that isn't a comment (like this) is code that is 
# interactive or won't fully run. To see what that code does simply remove the 
# leading # and run it as normal or highlight the code directly and run it 
# any of the ways we discussed in lecture. 

# loading necessary packages for code to run
{
  library(tidyverse)
}


# Function Basics -----------------------------------------------------------------

df <- tibble(
  a = rnorm(5),
  b = rnorm(5),
  c = rnorm(5),
  d = rnorm(5)
)
df

df |> mutate(
  a = (a - min(a, na.rm = TRUE)) / 
    (max(a, na.rm = TRUE) - min(a, na.rm = TRUE)),
  b = (b - min(b, na.rm = TRUE)) / 
    (max(b, na.rm = TRUE) - min(a, na.rm = TRUE)),
  c = (c - min(c, na.rm = TRUE)) / 
    (max(c, na.rm = TRUE) - min(c, na.rm = TRUE)),
  d = (d - min(d, na.rm = TRUE)) / 
    (max(d, na.rm = TRUE) - min(d, na.rm = TRUE))
)

# (a - min(a, na.rm = TRUE)) / (max(a, na.rm = TRUE) - min(a, na.rm = TRUE))
# (b - min(b, na.rm = TRUE)) / (max(b, na.rm = TRUE) - min(b, na.rm = TRUE))
# (c - min(c, na.rm = TRUE)) / (max(c, na.rm = TRUE) - min(c, na.rm = TRUE))
# (d - min(d, na.rm = TRUE)) / (max(d, na.rm = TRUE) - min(d, na.rm = TRUE))  

# (🟪 - min(🟪, na.rm = TRUE)) / (max(🟪, na.rm = TRUE) - min(🟪, na.rm = TRUE))

NAME <- function(ARGUMENT1, ARGUMENT2 = DEFAULT){
  BODY 
}

rescale01 <- function(x) {
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
}

rescale01(c(-10, 0, 10))

rescale01(c(1, 2, 3, NA, 5))

df |> mutate(a = rescale01(a),
             b = rescale01(b),
             c = rescale01(c),
             d = rescale01(d))

rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

x <- c(1:10, Inf)
rescale01(x)

rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE, finite = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

# Vector Functions --------------------------------------------------------

z_score <- function(x) { 
  (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
} 

ages <- c(25, 82, 73, 44, 5)
z_score(ages)

clamp <- function(x, min, max) { 
  case_when(
    x < min ~ min,
    x > max ~ max,
    .default = x
  ) 
} 

clamp(1:10, min = 3, max = 7)

first_upper <- function(x) { 
  str_sub(x, 1, 1) <- str_to_upper(str_sub(x, 1, 1))
  x
} 

first_upper("hi there, how's your day going?")

cv <- function(x, na.rm = FALSE) {
  sd(x, na.rm = na.rm) / mean(x, na.rm = na.rm)
}

cv(runif(100, min = 0, max = 50))

n_missing <- function(x) {
  sum(is.na(x))
} 

var <- sample(c(seq(1, 20, 1), NA, NA), size = 100, replace = TRUE)
n_missing(var)

mape <- function(actual, predicted) {
  sum(abs((actual - predicted) / actual)) / length(actual)
}

model1 <- lm(dist ~ speed, data = cars)
mape(cars$dist, model1$fitted.values)


# Data Frame Functions ----------------------------------------------------

grouped_mean <- function(df, group_var, mean_var) {
  df |> 
    group_by(group_var) |>
    summarize(mean(mean_var))
}

diamonds |> grouped_mean(cut, carat)

diamonds[diamonds$cut == "Ideal" & diamonds$price < 1000, ]

diamonds |> filter(cut == "Ideal" & price < 1000)

grouped_mean <- function(df, group_var, mean_var) {
  df |> 
    group_by({{ group_var }}) |> 
    summarize(mean({{ mean_var }}))
}

diamonds |> grouped_mean(cut, carat)

summary6 <- function(data, var) {
  data |> summarize(
    min = min({{ var }}, na.rm = TRUE),
    mean = mean({{ var }}, na.rm = TRUE),
    median = median({{ var }}, na.rm = TRUE),
    max = max({{ var }}, na.rm = TRUE),
    n = n(),
    n_miss = sum(is.na({{ var }})),
    .groups = "drop"
  )
}

diamonds |> summary6(carat)

count_prop <- function(df, var, sort = FALSE) {
  df |>
    count({{ var }}, sort = sort) |>
    mutate(prop = n / sum(n))
}

diamonds |> count_prop(clarity)


# Plot Functions ----------------------------------------------------------



histogram <- function(df, var, binwidth = NULL) {
  df |> 
    ggplot(aes(x = {{ var }})) +
    geom_histogram(binwidth = binwidth)
}

diamonds |> histogram(carat, 0.1)

sorted_bars <- function(df, var) {
  df |> 
    mutate({{ var }} := fct_rev(fct_infreq({{ var }})))  |>
    ggplot(aes(y = {{ var }})) + 
    geom_bar() 
}

diamonds |> sorted_bars(clarity)


histogram <- function(df, var, binwidth) {
  label <- rlang::englue("A histogram of {{ var }} with binwidth {binwidth}")
  
  df |> 
    ggplot(aes(x = {{ var }})) + 
    geom_histogram(binwidth = binwidth) + 
    labs(title = label)
}

diamonds |> histogram(carat, 0.1)

