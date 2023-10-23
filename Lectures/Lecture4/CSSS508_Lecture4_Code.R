########################
### Lecture 4 R Code ###
########################

# Note: Anything behind a # that isn't a comment (like this) is code that is 
# interactive or won't fully run. To see what that code does simply remove the 
# leading # and run it as normal or highlight the code directly and run it 
# any of the ways we discussed in lecture. 

# loading necessary packages for code to run
{
  library(tidyverse)
  library(nycflights13)
}


# Logical Operators -------------------------------------------------------

x <- c(1 / 49 * 49, sqrt(2) ^ 2)
x

x == c(1, 2)
print(x, digits = 16)

NA > 5
10 == NA
NA == NA
is.na(c(NA, 5))

A <- c(5, 10, 15)
B <- c(5, 15, 25)

A == B
A > B
A %in% B

A > 5 & A <= B 
B < 10 | B > 20
!(A == 10)

C <- c(5, 10, NA, 10, 20, NA)
any(C <= 10)
all(C <= 20)
all(C <= 20, na.rm = TRUE)
mean(C, na.rm = TRUE)

x <- c(-3:3, NA)
if_else(x > 0, "+ve", "-ve", "???")

case_when(
  x == 0   ~ "0",
  x < 0    ~ "-ve", 
  x > 0    ~ "+ve",
  is.na(x) ~ "???"
)

data(flights)
data(airlines)
data(airports)
data(planes)
data(weather)


# Subsetting Data ---------------------------------------------------------

delay_2hr <- flights |> 
  filter(dep_delay > 120)
delay_2hr

flights |> 
  select(year, month, day)

flights |> 
  select(year:day)

flights |> 
  select(where(is.character))

flights |> 
  distinct(origin, dest)

flights |> 
  distinct(origin, dest, .keep_all = TRUE)

flights |>
  count(origin, dest, sort = TRUE)


# Modifying Data ----------------------------------------------------------

flights |> 
  arrange(year, month, day, dep_time)

flights |> 
  arrange(desc(dep_delay))

flights |> 
  rename(tail_num = tailnum)

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before = 1
  )

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours,
    .keep = "used"
  )

flights |> 
  relocate(time_hour, air_time)


# Summarizing Data --------------------------------------------------------

flights |> 
  group_by(month)

flights |> 
  summarize(
    avg_delay = mean(dep_delay)
  )

flights |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE) 
  )

flights |> 
  group_by(month) |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE)
  )

flights |> 
  group_by(month) |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n()
  )

daily <- flights |> 
  group_by(year, month, day)  
daily

daily |> 
  ungroup() 

flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    .by = month
  )

flights |> 
  group_by(dest) |> 
  slice_max(arr_delay, n = 1) |>
  relocate(dest) 


# Merging Data ------------------------------------------------------------

airlines 
airports
planes
weather
flights

planes |> 
  count(tailnum) |>
  filter(n > 1)

planes |> 
  filter(is.na(tailnum))

flights2 <- flights |> 
  mutate(id = row_number(), .before = 1)
flights2

flights2 <- flights |> 
  select(year, time_hour, origin, dest, tailnum, carrier)

flights2 |>
  left_join(airlines)

flights2 |> 
  left_join(planes)

flights2 |> 
  left_join(planes, join_by(tailnum))

flights2 |> 
  left_join(airports, join_by(dest == faa))

flights2 |> 
  left_join(airports, join_by(dest == faa), keep = TRUE) 

airports |> 
  semi_join(flights2, join_by(faa == origin))

airports |> 
  anti_join(flights2, join_by(faa == origin))

df1 <- tibble(key = c(1, 2, 2), val_x = c("x1", "x2", "x3"))
df2 <- tibble(key = c(1, 2, 2), val_y = c("y1", "y2", "y3"))

df1 |> 
  inner_join(df2, join_by(key))

