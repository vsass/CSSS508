A <- c(5,10,15)
B <- c(5,15,25)

A == B
A >  B
A %in% B

A <- c(5,10,15)
B <- c(5,15,25)

A > 5 & A <= B
B < 10 | B > 20
!(A == 10)

# install.packages("dplyr")
library(dplyr)
library(gapminder)

log(mean(gapminder$pop))
gapminder$pop %>% mean() %>% log()

gapminder %>% filter(country == "China") %>% 
  head(4) # display first four rows
China <- gapminder %>% filter(country == "China")

gapminder %>% select(country,continent,year,lifeExp) %>% head(4)

gapminder %>% select(-continent, -pop, -lifeExp) %>% head(4)

gapminder %>% distinct(continent, year) %>% head(6)

gapminder %>% distinct(continent, year, .keep_all=TRUE) %>% head(6)

US_and_Canada <- gapminder %>% 
  filter(country %in% c("United States","Canada"))
US_and_Canada %>% arrange(year,lifeExp) %>% head(4)

US_and_Canada %>% arrange(desc(pop)) %>% head(4)

US_and_Canada %>% rename(life_expectancy = lifeExp) %>%
  head(4)

US_and_Canada %>% select(country, year, pop) %>%
  mutate(pop_millions = pop / 1000000) %>% #<<
  head(5)

gapminder %>% filter(year == 1982) %>%
  summarize(number_observations = n(),
            max_lifeexp = max(lifeExp),
            mean_pop = mean(pop),
            sd_pop = sd(pop))

US_and_Canada %>% group_by(year) %>%  #<<
  summarize(total_pop = sum(pop)) %>% #<<
  head(4)

# install.packages("nycflights13")
library(nycflights13)

flights %>% select(flight,origin,dest,carrier) %>% head(2)

airlines %>% head(2)

flights %>% select(flight,origin,dest,carrier) %>%
  left_join(airlines, by = "carrier")  %>% #<< 
  head(5)

flights %>% select(flight,origin,dest,tailnum) %>% head(2)

planes %>% select(tailnum,year,manufacturer,model) %>% head(2)

flights %>% select(flight,origin,dest,tailnum) %>%
  left_join(planes, by = "tailnum")  %>% #<< 
  head(5)

flights %>% select(flight,origin,dest,tailnum) %>%
  left_join(planes, by = "tailnum")  %>% 
  select(flight,origin,dest,manufacturer,model) %>% #<< 
  head(5)