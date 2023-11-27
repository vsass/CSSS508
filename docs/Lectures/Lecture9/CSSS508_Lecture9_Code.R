########################
### Lecture 9 R Code ###
########################

# Note: Anything behind a # that isn't a comment (like this) is code that is 
# interactive or won't fully run. To see what that code does simply remove the 
# leading # and run it as normal or highlight the code directly and run it 
# any of the ways we discussed in lecture. 

# loading necessary packages for code to run
{
  library(tidyverse)
}


# Introduction to Iteration -----------------------------------------------------------------

mean1 <- mean(swiss$Fertility)
mean2 <- mean(swiss$Agriculture)
mean3 <- mean(swissExamination)
mean4 <- mean(swiss$Fertility)
mean5 <- mean(swiss$Catholic)
mean5 <- mean(swiss$Infant.Mortality)
c(mean1, mean2 mean3, mean4, mean5, man6)

swiss |> summarize(
  across(Fertility:Infant.Mortality, mean)
)


# Modifying Multiple Columns ----------------------------------------------

df <- tibble(
  a = rnorm(5),
  b = rnorm(5),
  c = rnorm(5),
  d = rnorm(5)
)
df

df |> mutate(
  a = (a - min(a, na.rm = TRUE)) / (max(a, na.rm = TRUE) - min(a, na.rm = TRUE)),
  b = (b - min(b, na.rm = TRUE)) / (max(b, na.rm = TRUE) - min(a, na.rm = TRUE)),
  c = (c - min(c, na.rm = TRUE)) / (max(c, na.rm = TRUE) - min(c, na.rm = TRUE)),
  d = (d - min(d, na.rm = TRUE)) / (max(d, na.rm = TRUE) - min(d, na.rm = TRUE))
)

rescale01 <- function(x) { 
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
}

df |> mutate(a = rescale01(a),
             b = rescale01(b),
             c = rescale01(c),
             d = rescale01(d))

df |> mutate(across(a:d, rescale01))

# across(.cols, .fns, .names = NULL)

iris |> 
  summarise(across(starts_with("Sepal"), median))

iris |> 
  summarise(across(everything(), median), 
            .by = Species)

iris |> 
  summarise(across(where(is.numeric), median))

airquality |> 
  summarise(across(Ozone:Temp, median()))

airquality |> 
  summarise(across(Ozone:Temp, \(x) median(x, na.rm = TRUE)))

airquality |> 
  summarise(across(Ozone:Temp, ~ median(.x, na.rm = TRUE)))

airquality |> 
  summarise(across(Ozone:Temp, 
                   list(median = \(x) median(x, na.rm = TRUE),
                        n_miss = \(x) sum(is.na(x)))))

df |> mutate(across(a:d, rescale01))

df |> mutate(across(a:d, rescale01, .names = "{.col}_rescaled"))

airquality |> filter(if_any(Ozone:Temp, is.na))

airquality |> filter(if_all(Ozone:Temp, is.na))

summarize_means <- function(df, summary_vars = where(is.numeric)) {
  df |> 
    summarize(
      across({{ summary_vars }}, \(x) mean(x, na.rm = TRUE)),
      n = n(),
      .groups = "drop"
    )
}

diamonds |> 
  group_by(cut) |> 
  summarize_means(c(carat, x:z))


# Reading in Multiple Files -----------------------------------------------

data2019 <- readxl::read_excel("data/y2019.xlsx")
data2020 <- readxl::read_excel("data/y2020.xlsx")
data2021 <- readxl::read_excel("data/y2021.xlsx")
data2022 <- readxl::read_excel("data/y2022.xlsx")

data <- bind_rows(data2019, data2020, data2021, data2022)

paths <- list.files("data/gapminder",
                    pattern = "[.]xlsx$",
                    full.names = TRUE)
paths

files <- list(
  readxl::read_excel("data/gapminder/1952.xlsx"),
  readxl::read_excel("data/gapminder/1957.xlsx"),
  readxl::read_excel("data/gapminder/1962.xlsx"),
  readxl::read_excel("data/gapminder/1967.xlsx"),
  readxl::read_excel("data/gapminder/1972.xlsx"),
  readxl::read_excel("data/gapminder/1977.xlsx"),
  readxl::read_excel("data/gapminder/1982.xlsx"),
  readxl::read_excel("data/gapminder/1987.xlsx"),
  readxl::read_excel("data/gapminder/1992.xlsx"),
  readxl::read_excel("data/gapminder/1997.xlsx"),
  readxl::read_excel("data/gapminder/2002.xlsx"),
  readxl::read_excel("data/gapminder/2007.xlsx")
)

files <- map(paths, readxl::read_excel)

files[[1]]

list_rbind(files)

paths |> 
  map(readxl::read_excel) |> 
  list_rbind()

files <- paths |> 
  set_names(basename) |>
  map(readxl::read_excel)

paths |> 
  set_names(basename)

paths |> 
  set_names(basename) |> 
  map(readxl::read_excel)

gapminder <- paths |> 
  set_names(basename) |> 
  map(readxl::read_excel) |> 
  list_rbind(names_to = "year") |>
  mutate(year = parse_number(year))
gapminder

write_csv(gapminder, "gapminder.csv")

# Saving Multiple Outputs -------------------------------------------------

by_clarity <- diamonds |> 
  group_nest(clarity) |>
  mutate(path = str_glue("diamonds-{clarity}.csv"))

by_clarity

by_clarity$data[[1]]

# write_csv(by_clarity$data[[1]], by_clarity$path[[1]])
# write_csv(by_clarity$data[[2]], by_clarity$path[[2]])
# write_csv(by_clarity$data[[3]], by_clarity$path[[3]])
# ...
# write_csv(by_clarity$by_clarity[[8]], by_clarity$path[[8]])

map2(by_clarity$data, by_clarity$path, write_csv)

walk2(by_clarity$data, by_clarity$path, write_csv)

carat_histogram <- function(df) {
  ggplot(df, aes(x = carat)) + geom_histogram(binwidth = 0.1)  
}

carat_histogram(by_clarity$data[[1]])

by_clarity <- by_clarity |> 
  mutate(
    plot = map(data, carat_histogram),
    path = str_glue("clarity-{clarity}.png")
  )
by_clarity

by_clarity$plot[[1]]

walk2(
  by_clarity$path,
  by_clarity$plot,
  \(path, plot) ggsave(path, plot, width = 6, height = 6)
)

#ggsave(by_clarity$path[[1]], by_clarity$plot[[1]], width = 6, height = 6)
#ggsave(by_clarity$path[[2]], by_clarity$plot[[2]], width = 6, height = 6)
#ggsave(by_clarity$path[[3]], by_clarity$plot[[3]], width = 6, height = 6)
#...
#ggsave(by_clarity$path[[8]], by_clarity$plot[[8]], width = 6, height = 6)


# Apply Family ------------------------------------------------------------

lapply(swiss, FUN = median)

sapply(swiss, FUN = median)

vapply(swiss, median, double(1))

diamonds |> 
  group_by(cut) |> 
  summarize(price = mean(price))

tapply(diamonds$price, diamonds$cut, mean)

apply(swiss, MARGIN = 2, FUN = summary)

# for loops ---------------------------------------------------------------

# for (element in vector) {
#   # do something with element
# }

for(i in 1:10) {
  print(i)
}

1:10 |>
  walk(\(x) print(x))






