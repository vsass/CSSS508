########################
### Lecture 7 R Code ###
########################

# Note: Anything behind a # that isn't a comment (like this) is code that is 
# interactive or won't fully run. To see what that code does simply remove the 
# leading # and run it as normal or highlight the code directly and run it 
# any of the ways we discussed in lecture. 

# loading necessary packages for code to run
{
  library(tidyverse)
}


# Strings -----------------------------------------------------------------

"\'"
'\"'
"\\"
str_view(c("\'", '\"', "\\"))

str_view("Sometimes you need\nto create another line.")
str_view("\tOther times you just need to indent somewhere.")
str_view(c("\U1F00F", "\u2866", "\U1F192"))

load(url("https://github.com/vsass/CSSS508/raw/main/Lectures/Lecture7/data/restaurants.Rdata"))

glimpse(restaurants)

str_c(c("CSSS", "STAT", "SOC"), 508)
str_c(c("CSSS", "STAT", "SOC"), 508, sep = " ")
str_c(c("CSSS", "STAT", "SOC"), 508, sep = " ", collapse = ", ")

restaurants |> 
  select(Name, Address, City) |> 
  distinct() |> 
  mutate(Sentence = str_c(Name, " is located at ", Address, " in ", City, "."),
         .keep = "none")

restaurants |> 
  select(Name, Address, City) |> 
  distinct() |> 
  mutate(Sentence = str_glue("{Name} is located at {Address} in {City}."), 
         .keep = "none")

restaurants |> 
  select(Name, `Inspection Score`) |>
  summarize(inspection_scores = str_flatten(`Inspection Score`, collapse = ", "), 
            .by = Name)

restaurants |> 
  mutate(Name = str_wrap(Name, width = 20)) |> 
  distinct(Name)

# separate_longer_delim(col, delim)
# separate_longer_position(col, width)
# separate_wider_delim(col, delim, names)
# separate_wider_position(col, widths)

restaurants |> 
  select(`Inspection Date`) |>
  separate_wider_delim(`Inspection Date`, 
                       delim = "/", 
                       names = c("month", "day", "year"))

restaurants |> 
  select(Address) |> 
  separate_wider_delim(Address, 
                       delim = " ", 
                       names = c("num", "name", "type")) 

debug <- restaurants |> 
  select(Address) |> 
  separate_wider_delim(Address, 
                       delim = " ", 
                       names = c("num", "name", "type"), 
                       too_many = "debug",
                       too_few = "debug") 
debug[debug$Address_pieces == 4, ]
debug[debug$Address_pieces == 2, ]


unique_cities <- unique(restaurants$City)
unique_cities  |> 
  head()

str_to_upper(unique_cities) |> 
  head()
str_to_lower(unique_cities) |> 
  head()
str_to_title(unique_cities) |> 
  head()

unique_names <- unique(restaurants$Name)
unique_names |> head(3)
str_trim(unique_names) |> head(3)

phone_numbers <- restaurants |>
  select(`Phone`) |> 
  mutate(phone_length = str_length(`Phone`))

phone_numbers |> count(phone_length)

phone_numbers |> 
  filter(phone_length %in% c(15, 18)) |> 
  slice_head(n = 1, by = phone_length)

restaurants |> 
  select(`Phone`) |> 
  mutate(area_code = str_sub(`Phone`, start = 2, end = 4)) |>
  distinct(area_code)

# Pattern Matching & Regular Expressions ----------------------------------

restaurants |>  
  filter(`Inspection Score` < 10 | `Inspection Score` > 150)

# str_detect(string, pattern)

restaurants |> 
  select(Name, Address) |> 
  filter(str_detect(Address, "Pike")) |> 
  distinct()

str_detect(string, pattern)

restaurants |> 
  select(Name, Address) |> 
  mutate(Address = str_to_title(Address)) |>
  filter(str_detect(Address, "Pike")) |> 
  distinct()

# str_replace(string, pattern, replacement)

restaurants |> 
  select(`Inspection Date`) |> 
  mutate(full_date = str_replace(string = `Inspection Date`, 
                                 pattern = "01/",
                                 replacement = "January "))

restaurants |> 
  select(`Inspection Date`) |> 
  mutate(full_date = str_replace(string = `Inspection Date`, 
                                 pattern = "^01/",
                                 replacement = "January "))

restaurants |> 
  count(Description) |>
  print(n = 33)

res_sep <- restaurants |> 
  distinct(Name, Description) |>
  separate_wider_regex(cols = Description,
                       patterns = c(capacity_description = "^.+",
                                    risk_category = "Risk ?(?:Category)? ?I{1,3}$")) 

res_sep <- restaurants |> 
  distinct(Name, Description) |> 
  separate_wider_regex(cols = Description, 
                       patterns = c(capacity_description = "^.+",
                                    risk_category = "Risk ?(?:Category)? ?I{1,3}$"),
                       too_few = "debug") |> 
  distinct(capacity_description, risk_category, Description_ok, 
           Description_matches, Description_remainder) |>
  print(n = 33)

res_sep <- restaurants |> 
  distinct(Name, Description) |> 
  separate_wider_regex(cols = Description, 
                       patterns = c(capacity_description = "^.+",
                                    risk_category = "Risk ?(?:Category)? ?I{1,3}$"), 
                       too_few = "align_start")
res_sep

res_sep <- restaurants |> 
  distinct(Name, Description) |> 
  separate_wider_regex(cols = Description, 
                       patterns = c(capacity_description = "^.+",
                                    risk_category = "Risk ?(?:Category)? ?I{1,3}$"), 
                       too_few = "align_start") |>
  mutate(capacity_description = str_remove(capacity_description, pattern = " - $"),
         risk_category = str_remove(risk_category, pattern = "Risk ?(?:Category)? "))
res_sep

res_sep |> 
  distinct(capacity_description, risk_category) |> 
  print(n = 33)

apropos("separate")

list.files(pattern = "\\.qmd$")

names(iris)
iris %>% select(matches("[pt]al")) |>
  names() 

names(who) |> head(n = 10)
who |> pivot_longer(cols = new_sp_m014:newrel_f65,
                    names_to = c("diagnosis", "gender", "age"), 
                    names_pattern = "new_?(.*)_(.)(.*)",
                    values_to = "count") |> 
  slice_head(n = 10)
