########################
### Lecture 3 R Code ###
########################

# Note: Anything behind a # that isn't a comment (like this) is code that is 
# interactive or won't fully run. To see what that code does simply remove the 
# leading # and run it as normal or highlight the code directly and run it 
# any of the ways we discussed in lecture. 

# loading necessary packages for code to run
{
  library(tidyverse)
  library(nycflights13)
  library(gapminder)
}

# Code Style --------------------------------------------------------------

# Code goal: 
short_flights <- flights |> 
  filter(air_time < 60)

# Code foul: 
SHORTFLIGHTS <- flights |> 
  filter(air_time < 60)

# Code goals: 
z <- (a + b)^2 / d
mean(x, na.rm = TRUE)

# Code foul: 
z<-( a + b ) ^ 2/d
mean (x ,na.rm=TRUE)

flights |> 
  mutate(
    speed      = distance / air_time,
    dep_hour   = dep_time %/% 100,
    dep_minute = dep_time %%  100
  )

median(sqrt(log(mean(gapminder$pop))))

gapminder$pop |> mean() |> log() |> sqrt() |> median()

a <- c("Z", NA, "C", "G", "A")
# magrittr pipe
a %>% gsub('A', '-', x = .)
# native pipe
a |> gsub('A','-', x = _) # _ is the placeholder for |> 
a |> gsub(pattern = 'A', replacement = '-') # leaving the "piped" argument as the only unnamed argument also works 
a |> (\(.) gsub('A', '-', x = .))() # using an anonymous function call allows you to be explicit while specifying your own placeholder

# code goals
flights |>  
  group_by(tailnum) |> 
  summarize(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )

# code fouls
flights |>
  group_by(
    tailnum
  ) |> 
  summarize(delay = mean(arr_delay, na.rm = TRUE), n = n())
getwd()

# Workflow ----------------------------------------------------------------

# Reproducible Research ---------------------------------------------------

# Useful Base R -----------------------------------------------------------

x <- c(a = "one", 
       b = NA, 
       c = "two", 
       d = "three", 
       e = "four", 
       f = NA, 
       g = NA, 
       h = "five")

# with positive integers
x[c(3, 1, 5)]

# even repeated values
x[c(3, 1, 1, 5, 3)]

# with negative integers
x[c(-2, -6, -7)]

# with a logical vector
x[!is.na(x)]

# or with a named vector
x[c("c", "h")]

df <- tibble(
  x = 1:3, 
  y = c("a", "e", "f"), 
  z = runif(3) # defaults: min = 0, max = 1
)

df

# Select first row and second column
df[1, 2]

# Select all rows and columns x and y
df[, c("x" , "y")]

# Select rows where `x` is greater than 1 and all columns
df[df$x > 1, ]

df1 <- data.frame(x = 1:3)
df1[, "x"]

df2 <- tibble(x = 1:3)
df2[, "x"]

df1[, "x" , drop = FALSE]

tb <- tibble(
  x = 1:4,
  y = c(10, 4, 1, 21)
)

tb

# by position
tb[[1]]

# by name
tb[["x"]]

tb$x

tb$z <- tb$x + tb$y
tb
