########################
### Lecture 6 R Code ###
########################

# Note: Anything behind a # that isn't a comment (like this) is code that is 
# interactive or won't fully run. To see what that code does simply remove the 
# leading # and run it as normal or highlight the code directly and run it 
# any of the ways we discussed in lecture. 

# loading necessary packages for code to run
{
  library(tidyverse)
}


# Numbers --------------------------------------------

parse_integer(c("1", "2", "3"))
parse_double(c("1", "2", "3.123"))
parse_number(c("USD 3,513", "59%", "$1,123,456.00"))

library(nycflights13)
data(flights)

flights |> count(origin)

flights |> 
  summarise(n= n(),
            .by = origin)

flights |> 
  summarize(carriers = n_distinct(carrier), 
            .by = dest) |> 
  arrange(desc(carriers))

flights |> 
  summarize(miles = sum(distance), 
            .by = tailnum)

flights |> count(tailnum, wt = distance) 

df <- tribble(
  ~x, ~y,
  1,  3,
  5,  2,
  7, NA,
)

df

df |> 
  mutate(
    min = pmin(x, y, na.rm = TRUE),
    max = pmax(x, y, na.rm = TRUE)
  )

1:10 %% 3

flights |> mutate(hour = sched_dep_time %/% 100,
                  minute = sched_dep_time %% 100,
                  .keep = "used")

log(c(2.718282, 7.389056, 20.085537))
log2(c(2, 4, 8))
log10(c(10, 100, 1000))

1:15
cumsum(1:15)

x <- c(1, 2, 5, 10, 15, 20)
cut(x, breaks = c(0, 5, 10, 15, 20))
cut(x, breaks = c(0, 5, 10, 100))
cut(x, 
    breaks = c(0, 5, 10, 15, 20), 
    labels = c("sm", "md", "lg", "xl")
)
y <- c(NA, -10, 5, 10, 30)
cut(y, breaks = c(0, 5, 10, 15, 20))

round(pi)
round(pi, digits = 2)
round(39472, digits = -1)
round(39472, digits = -2)
round(39472, digits = -3)

round(c(1.5, 2.5)) 
floor(123.456)
ceiling(123.456)

x <- sample(1:500, size = 100, replace = TRUE) # <20>
mean(x)
median(x)
quantile(x, .95)

min(x)
max(x)
range(x)
IQR(x)
var(x)
sd(x)

first(x)
last(x)
nth(x, n = 77)

x / sum(x)
(x - mean(x)) / sd(x)
(x - min(x)) / (max(x) - min(x))
x / first(x)


# Missing Values ----------------------------------------------------------

treatment <- tribble(
  ~person,           ~treatment, ~response,
  "Derrick Whitmore", 1,         7,
  NA,                 2,         10,
  "Katherine Burke",  3,         NA,
  NA,                 1,         4
)

treatment |>
  fill(everything())

x <- c(1, 4, 5, 7, NA)
coalesce(x, 0)

x <- c(1, 4, 5, 7, -99)
na_if(x, -99)

0 / 0 
0 * Inf
Inf - Inf
sqrt

stocks <- tibble(
  year  = c(2020, 2020, 2020, 2020, 2021, 2021, 2021),
  qtr   = c(   1,    2,    3,    4,    2,   3,    4),
  price = c(1.88, 0.59, 0.35, 0.89, 0.34, 0.17, 2.66)
)

stocks

stocks |>
  complete(year, qtr)

stocks |>
  complete(year, qtr, fill = list(price = 0.93))

health
levels(health$smoker)
health |> count(smoker, .drop = FALSE)

ggplot(health, aes(x = smoker)) +
  geom_bar() +
  scale_x_discrete() + 
  theme_classic(base_size = 22)

ggplot(health, aes(x = smoker)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE) + 
  theme_classic(base_size = 22)

is.numeric(5)
is.character("A")
is.logical(TRUE)
is.infinite(-Inf)
is.na(NA)
is.nan(NaN)


# Vectors -----------------------------------------------------------------

c(1, 3, 7, -0.5)
length(c(1, 3, 7, -0.5))

1:10
seq(-3, 6, by = 1.75)
rep(c(0, 1), times = 3)
rep(c(0, 1), each = 3)
rep(c(0, 1), length.out = 3)

x <- c(3, 6, 2, 9, 5)
x[6] <- 8
x
x[c(7, 8)] <- c(9, 9)
x

c(1, 2, 3) + c(4, 5, 6)
c(1, 2, 3, 4)^3

x <- c(1, 2, 10, 20)
x / 5

x * c(1, 2)
x * c(1, 2, 3)

flights |> 
  filter(month == c(1, 2)) |>
  head(5)

x <- c(97, 68, 75, 77, 69, 81)
z <- (x - mean(x)) / sd(x)
round(z, 2)

vector_w_missing <- c(1, 2, NA, 4, 5, 6, NA)
mean(vector_w_missing)

mean(vector_w_missing, na.rm = TRUE)

first_names <- c("Andre", "Brady", "Cecilia", "Danni", "Edgar", "Francie")
first_names[c(1, 2)]

first_names[-3]

first_names[nchar(first_names) == 7]

pet_names <- c(dog = "Lemon", cat = "Seamus")
pet_names["cat"]


# Matrices ----------------------------------------------------------------

a_matrix <- matrix(first_names, nrow = 2, ncol = 3)
a_matrix

a_matrix[1, c(1:3)] <- c("Hakim", "Tony", "Eduardo")

b_matrix <- rbind(c(1, 2, 3), c(4, 5, 6))
b_matrix

c_matrix <- cbind(c(1, 2), c(3, 4), c(5, 6))
c_matrix

a_matrix
a_matrix[1, 2]
a_matrix[1, c(2,3)]
dim(a_matrix)

a_matrix[, 1] 
a_matrix[, 1, drop = FALSE] 

bad_matrix <- cbind(1:2, c("Victoria", "Sass"))
bad_matrix

rownames(bad_matrix) <- c("First", "Last")
colnames(bad_matrix) <- c("Number", "Name")
bad_matrix
bad_matrix[ ,"Name", drop = FALSE]

matrix(c(2, 4, 6, 8),nrow = 2, ncol = 2) / matrix(c(2, 1, 3, 1),nrow = 2, ncol = 2)

c_matrix
e_matrix <- t(c_matrix)
e_matrix

f_matrix <- c_matrix %*% e_matrix 
f_matrix

g_matrix <- solve(f_matrix)
g_matrix

data.frame(Column1 = c(1, 2, 3),
           Column2 = c("A", "B", "C"))

tibble(Column1 = c(1, 2, 3),
       Column2 = c("A", "B", "C"))


# Lists -------------------------------------------------------------------

my_list <- list(first_thing = 1:5,
                second_thing = matrix(8:11, nrow = 2), 
                third_thing = fct(c("apple", "pear", "banana", "apple", "apple")))
my_list

my_list[["first_thing"]]
my_list[[1]]
my_list$first_thing

str(my_list[[1]])
str(my_list[1])

names(my_list)

obj1 <- list("a", list(1, elt = "foo"))
obj2 <- list("b", list(2, elt = "bar"))
x <- list(obj1, obj2)
x

pluck(x, 1) 
pluck(x, 1, 2) 
pluck(x, 1, 2, "elt") 

lm_output <- lm(speed ~ dist, data = cars)
is.list(lm_output)

names(lm_output)
lm_output$coefficients
str(lm_output)




