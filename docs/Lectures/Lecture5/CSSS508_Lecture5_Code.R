########################
### Lecture 5 R Code ###
########################

# Note: Anything behind a # that isn't a comment (like this) is code that is 
# interactive or won't fully run. To see what that code does simply remove the 
# leading # and run it as normal or highlight the code directly and run it 
# any of the ways we discussed in lecture. 

# loading necessary packages for code to run
{
  library(tidyverse)
}


# Importing and Exporting Data --------------------------------------------

billboard_2000_raw <- read_csv(file = "data/billboard.csv")

glimpse(billboard_2000_raw)

billboard_2000_raw <- read_csv(file = "data/billboard.csv", 
                               na = c("N/A", "999"))

billboard_2000_raw <- read_csv(file = "data/billboard.csv", 
                               skip = 1)

billboard_renamed <- read_csv(file = "data/billboard.csv", 
                              col_names = c("year", "artist", "track", "time", "date_entered", 
                                            paste("wk", 1:76, sep = "_")))

billboard_renamed |>  names() |> head(10)

billboard_2000_raw <- read_csv(file = "data/billboard.csv", 
                               col_names = FALSE) 

# Download pacakge first
# install.packages("janitor")

# Create new object for renamed data
billboard_renamed <- billboard_2000_raw |> 
  janitor::clean_names(numerals = "right")

billboard_renamed |>  names() |> head(10)

glimpse(billboard_2000_raw) 

class(c(T, F, NA, FALSE, TRUE))
class(c(1, NA, 17.5, 5.3, NA))
class(as.Date(c(NA, "2023-10-31", "1986-06-21", "1997-01-15"), tz = "America/Los_Angeles"))
class(c("apple", NA, "mango", "blackberry", "plum")) 
class(c(NA, NA, NA, NA, NA))

# Create character string of shortcode column types
bb_types <- paste(c("icctD", rep("i", 76)), collapse="")
bb_types 

# re-read in data with column types specified
billboard_2000_raw <- read_csv(file = "data/billboard.csv", 
                               col_types = bb_types)

billboard_2000_raw <- read_csv(file = "data/billboard.csv", 
                               col_types = cols(.default = col_character())) 

billboard_2000_raw <- read_csv(file = "data/billboard.csv", 
                               col_types = cols_only(x = col_character)) 

# Create list of files manually
sales_files <- c("data/01-sales.csv", "data/02-sales.csv", "data/03-sales.csv")
read_csv(sales_files, id = "file")

# Create list of files with pattern-matching
sales_files <- list.files("data", pattern = "sales\\.csv$", full.names = TRUE)
sales_files

# Creating data with tibble
tibble( 
  x = c(1, 2, 5), 
  y = c("h", "m", "g"),
  z = c(0.08, 0.83, 0.60)
)

# Creating data with tribble
tribble( 
  ~x, ~y, ~z,
  1, "h", 0.08,
  2, "m", 0.83,
  5, "g", 0.60
)

write_csv(billboard_2000_raw, path = "data/billboard_data.csv")


# Tidying and Reshaping Data ----------------------------------------------

billboard_2000 <- billboard_renamed |>
  pivot_longer(cols = starts_with("wk_"),
               names_to ="week",
               values_to = "rank")

billboard_2000 |> head(10)

glimpse(billboard_2000)

summary(billboard_2000$rank)

billboard_2000 <- billboard_renamed %>%
  pivot_longer(cols = wk_1:wk_76, 
               names_to = "week", 
               values_to = "rank", 
               values_drop_na = TRUE)
summary(billboard_2000$rank)

dim(billboard_2000)

head(billboard_2000$week)

billboard_2000 <- billboard_2000 |> 
  mutate(week = parse_number(week))
summary(billboard_2000$week)

billboard_2000 <- billboard_renamed %>%
  pivot_longer(starts_with("wk_"), 
               names_to        = "week", 
               values_to       = "rank",
               values_drop_na  = TRUE,
               names_prefix    = "wk_",
               names_transform = list(week = as.integer))

head(billboard_2000, 5)

who2

who2 |> 
  pivot_longer(
    cols = !(country:year),
    names_to = c("diagnosis", "gender", "age"), 
    names_sep = "_",
    values_to = "count"
  )

household

household |> 
  pivot_longer(
    cols = !family, 
    names_to = c(".value", "child"),
    names_sep = "_", 
    values_drop_na = TRUE
  )

wide_stats <- long_stats |> 
  pivot_wider(id_cols = Group,
              names_from = Statistic,
              values_from = Value)
wide_stats


# Working with Factors ----------------------------------------------------

month <- c("Dec", "Apr", "Jan", "Mar")

month <- c("Dec", "Apr", "Jam", "Mar")

sort(month)

month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

month_factor <- factor(month, levels = month_levels)
month_factor

sort(month_factor)

df <- read_csv(csv, col_types = cols(month = col_factor(month_levels)))

levels(month_factor)

gss_cat

fct_reorder(.f = factor,
            .x = ordering_vector,
            .fun = optional_function)

fct_relevel(.f = factor, 
            ... = value,
            after = placement)

fct_reorder2(.f = factor, 
             .x = vector1,
             .y = vector2)

fct_infreq(.f = factor)

relig_summary <- gss_cat |>
  group_by(relig) |>
  summarize(
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )

ggplot(relig_summary, aes(x = tvhours, y = relig)) +
  geom_point()

rincome_summary <- gss_cat |>
  group_by(rincome) |>
  summarize(
    age = mean(age, na.rm = TRUE),
    n = n()
  )

ggplot(rincome_summary, aes(x = age, y = rincome)) + 
  geom_point()

by_age <- gss_cat |>
  filter(!is.na(age)) |> 
  count(age, marital) |>
  group_by(age) |>
  mutate(
    prop = n / sum(n)
  )

ggplot(by_age, aes(x = age, y = prop, color = marital)) +
  geom_line(linewidth = 1) + 
  scale_color_brewer(palette = "Set1")

gss_cat |>
  mutate(marital = marital) |> 
  ggplot(aes(x = marital)) + 
  geom_bar()

gss_cat |> count(partyid)

gss_cat |>
  mutate(
    partyid = fct_recode(partyid,
                         "Republican, strong" = "Strong republican",
                         "Republican, weak" = "Not str republican",
                         "Independent, near rep" = "Ind,near rep",
                         "Independent, near dem" = "Ind,near dem",
                         "Democrat, weak" = "Not str democrat",
                         "Democrat, strong" = "Strong democrat"
    )
  ) |>
  count(partyid)

gss_cat |>
  mutate(
    partyid = fct_collapse(partyid,
                           "other" = c("No answer", "Don't know", "Other party"),
                           "rep" = c("Strong republican", "Not str republican"),
                           "ind" = c("Ind,near rep", "Independent", "Ind,near dem"),
                           "dem" = c("Not str democrat", "Strong democrat")
    )
  ) |>
  count(partyid)

gss_cat |>
  mutate(relig = fct_lump_n(relig, n = 10)) |>
  count(relig, sort = TRUE)

ordered(c("a", "b", "c"))


# Wrangling Date/ Date-Time Data ------------------------------------------

csv <- "
  date
  05/22/23
"

read_csv(csv, col_types = cols(date = col_date("%m/%d/%y")))

ymd("2017-01-31")
mdy("January 31st, 2017")
dmy("31-Jan-2017")

ymd_hms("2017-01-31 20:11:59")
mdy_hm("01/31/2017 08:01")
ymd("2017-01-31", tz = "UTC")

library(nycflights13)
flights |> 
  select(year, month, day, hour, minute)

flights2 <- flights |> 
  select(year, month, day, hour, minute) |> 
  mutate(departure = make_datetime(year, month, day, hour, minute))
flights2

ggplot(flights2, aes(x = departure)) + 
  geom_freqpoly(binwidth = 86400)

as_datetime(today())
as_date(now())

as_datetime(1)
as_datetime(5057)
as_date(1)
as_date(5057)

datetime <- ymd_hms("2020-01-30 12:30:45")

year(datetime)
month(datetime)
mday(datetime)
yday(datetime)
wday(datetime)
hour(datetime)
minute(datetime)
second(datetime)

datetime <- ymd_hms("2020-01-30 08:05:35")

year(datetime) <- 2030
hour(datetime) <- hour(datetime) + 1

datetime

update(datetime, year = 2030, month = 2, mday = 2, hour = 2)

update(ymd("2023-02-01"), mday = 30)

datetime <- ymd_hms("2020-01-30 08:05:35")

floor_date(datetime, unit = "week")
round_date(datetime, unit = "week", week_start = 1)
ceiling_date(datetime, unit = "hour")

s_age <- today() - ymd("2023-05-28")
s_age
as.duration(s_age)

dseconds(15)
dminutes(10)
dhours(c(12, 24))
ddays(0:5)
dweeks(3)
dyears(1)

2 * dyears(1)
dyears(1) + dweeks(12) + dhours(15)
one_am <- ymd_hms("2026-03-08 01:00:00", tz = "America/New_York")
one_am
one_am + ddays(1)

one_am
one_am + days(1)
hours(c(12, 24))
days(7)
months(1:6)
10 * (months(6) + days(1))
days(50) + hours(25) + minutes(2)

# A leap year
ymd("2024-01-01") + dyears(1)
ymd("2024-01-01") + years(1)

# Daylight saving time
one_am + ddays(1)
one_am + days(1)

years(1) / days(1)
dyears(1) / ddays(365)

y2023 <- ymd("2023-01-01") %--% ymd("2024-01-01")
y2024 <- ymd("2024-01-01") %--% ymd("2025-01-01")
y2023
y2024
y2023 / days(1)
y2024 / days(1)

Sys.timezone()
OlsonNames()

x <- ymd_hms("2024-06-01 12:00:00", tz = "America/New_York")
x

with_tz(x, tzone = "Australia/Lord_Howe")

y <- ymd_hms("2024-06-01 9:00:00", tz = "America/Los_Angeles")
y

force_tz(y, tzone = "Australia/Lord_Howe")

a <- ymd_hms("2024-06-01 14:00:00", tz = "Asia/Gaza") 
b <- ymd_hms("2024-06-01 14:00:00", tz = "Cuba") 
c <- ymd_hms("2024-06-01 14:00:00", tz = "Africa/Kinshasa") 
a
b
c
c(a, b, c)


