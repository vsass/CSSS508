########################
### Lecture 2 R Code ###
########################

# Note: Anything behind a # that isn't a comment (like this) is code that is 
# interactive or won't fully run. To see what that code does simply remove the 
# leading # and run it as normal or highlight the code directly and run it 
# any of the ways we discussed in lecture. 

# Introducing the Tidyverse! (Slide 5)

library(gapminder)
library(tidyverse)

str(gapminder)

China <- gapminder |> 
  filter(country == "China")
plot(lifeExp ~ year, 
     data = China, 
     xlab = "Year", 
     ylab = "Life expectancy",
     main = "Life expectancy in China", 
     col = "red", 
     pch = 16)

ggplot(data = China, 
       mapping = aes(x = year, y = lifeExp)) +
  geom_point(color = "red", size = 3) +
  labs(title = "Life expectancy in China", 
       x = "Year", 
       y = "Life expectancy") +
  theme_bw(base_size = 18)

# Example: Basic Jargon in Action! (Slide 24)

ggplot(data = China,  
       aes(x = year, y = lifeExp)) 

ggplot(data = China, 
       aes(x = year, y = lifeExp)) +
  geom_point()

ggplot(data = China, 
       aes(x = year, y = lifeExp)) +
  geom_point(color = "red", size = 3)

ggplot(data = China, 
       aes(x = year, y = lifeExp)) +
  geom_point(color = "red", size = 3) +
  labs(x = "Year")

ggplot(data = China, 
       aes(x = year, y = lifeExp)) +
  geom_point(color = "red", size = 3) +
  labs(x = "Year", 
       y = "Life expectancy")

ggplot(data = China, 
       aes(x = year, y = lifeExp)) +
  geom_point(color = "red", size = 3) +
  labs(x = "Year",
       y = "Life expectancy",
       title = "Life expectancy in China")

ggplot(data = China, 
       aes(x = year, y = lifeExp)) +
  geom_point(color = "red", size = 3) +
  labs(x = "Year",
       y = "Life expectancy",
       title = "Life expectancy in China") +
  theme_minimal()

ggplot(data = China, 
       aes(x = year, y = lifeExp)) +
  geom_point(color = "red", size = 3) +
  labs(x = "Year",
       y = "Life expectancy",
       title = "Life expectancy in China") +
  theme_bw(base_size = 18) 

ggplot(data = gapminder,
       aes(x = year, y = lifeExp)) +
  geom_point(color = "red", size = 3) +
  labs(x = "Year",
       y = "Life expectancy",
       title = "Life expectancy over time") + 
  theme_bw(base_size = 18) 

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp)) +
  geom_line(color = "red", size = 3) + 
  labs(x = "Year",
       y = "Life expectancy",
       title = "Life expectancy over time") + 
  theme_bw(base_size = 18) 

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, 
           group = country)) +
  geom_line(color = "red", size = 3) +
  labs(x = "Year",
       y = "Life expectancy",
       title = "Life expectancy over time") + 
  theme_bw(base_size = 18) 

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, 
           group = country)) +
  geom_line(color = "red") +
  labs(x = "Year",
       y = "Life expectancy",
       title = "Life expectancy over time") + 
  theme_bw(base_size = 18) 

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, 
           group = country, 
           color = continent)) +
  geom_line() +
  labs(x = "Year",
       y = "Life expectancy",
       title = "Life expectancy over time") + 
  theme_bw(base_size = 18) 

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, 
           group = country, 
           color = continent)) +
  geom_line() +
  labs(x = "Year",
       y = "Life expectancy",
       title = "Life expectancy over time") + 
  theme_bw(base_size = 18) +
  facet_wrap(vars(continent))

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, 
           group = country, 
           color = continent)) +
  geom_line() +
  labs(x = "Year",
       y = "Life expectancy",
       title = "Life expectancy over time") + 
  theme_bw() +
  facet_wrap(vars(continent))

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, 
           group = country, 
           color = continent)) +
  geom_line() +
  labs(x = "Year",
       y = "Life expectancy",
       title = "Life expectancy over time") + 
  theme_bw() +
  facet_wrap(vars(continent)) + 
  theme(legend.position = "none")

# Advanced ggplot tools (slide 42)

lifeExp_by_year <- 
  ggplot(data = gapminder, 
         aes(x = year, y = lifeExp, 
             group = country, 
             color = continent)) +
  geom_line() +
  labs(x = "Year",
       y = "Life expectancy",
       title = "Life expectancy over time") + 
  theme_bw() + 
  facet_wrap(vars(continent)) +
  theme(legend.position = "none")

lifeExp_by_year

lifeExp_by_year + 
  facet_grid(cols = vars(continent)) 

lifeExp_by_year +
  facet_grid(cols = vars(continent)) + 
  theme(legend.position = "bottom")

# ggsave("I_saved_a_file.pdf", plot = lifeExp_by_year,
#        height = 3, width = 5, units = "in")

ggplot(data = China, aes(x = year, y = gdpPercap)) +
  geom_line() +
  scale_y_log10(breaks = c(1000, 2000, 3000, 4000, 5000)) + 
  xlim(1940, 2010) + ggtitle("Chinese GDP per capita")

lifeExp_by_year +
  theme(legend.position = c(0.8, 0.2)) 

lifeExp_by_year +
  theme(legend.position = c(0.8, 0.2)) +
  scale_color_manual(
    name = "Which continent are\nwe looking at?", # \n adds a line break 
    values = c("Africa" = "#4e79a7", "Americas" = "#f28e2c", 
               "Asia" = "#e15759", "Europe" = "#76b7b2", "Oceania" = "#59a14f"))

gapminder_sub <- gapminder |> 
  filter(year %in% c(1952, 1982, 2002)) # create subset with only 3 years

scales_plot <- ggplot(data = gapminder_sub, 
                      aes(x = lifeExp, y = gdpPercap, fill = continent)) + 
  geom_jitter(alpha = 0.5, # alpha of points halfway transparent
              pch = 21, # shape is a circle with fill
              size = 3, # increase size
              color = "black") + # outline of circle is black 
  scale_fill_viridis_d(option = "D") + # circle is filled by colors perceptable for various forms of color-blindness
  facet_grid(rows = vars(year), # facet by years in the row
             cols = vars(continent)) + # facet by continent in the columns
  ggthemes::theme_tufte(base_size = 20) # increase base text size
scales_plot

scales_plot + scale_y_log10(breaks = c(250, 1000, 10000, 50000, 115000)) # transform the y axis to the logarithm to gain better visualization

scales_plot + scale_y_log10(breaks = c(250, 1000, 10000, 50000, 115000)) +
  facet_grid(rows = vars(year), 
             cols = vars(continent), 
             scales = "free_x") # make the x axis vary by data 

scales_plot + scale_y_log10(breaks = c(250, 1000, 10000, 50000, 115000)) +
  facet_grid(rows = vars(year), 
             cols = vars(continent), 
             scales = "free_y") # make the y axis vary by data 

scales_plot + scale_y_log10(breaks = c(250, 1000, 10000, 50000, 115000)) +
  facet_grid(rows = vars(year), 
             cols = vars(continent), 
             scales = "free") # make both axes vary by data 

ggplot(gapminder, aes(x = continent, y = lifeExp)) +
  geom_boxplot(outlier.colour = "hotpink")

ggplot(gapminder, aes(x = continent, y = lifeExp)) +
  geom_boxplot(outlier.colour = "hotpink") +
  geom_jitter(alpha = 0.25)

ggplot(gapminder, aes(x = continent, y = lifeExp)) +
  geom_boxplot(outlier.colour = "hotpink") +
  geom_jitter(position = position_jitter(width = 0.1, height = 0), alpha = 0.25)

outliers <- gapminder |> 
  group_by(continent) |> 
  mutate(outlier = case_when(quantile(lifeExp, probs = 0.25) - (IQR(lifeExp) * 1.5) > lifeExp ~ "outlier", # anything lower than the 1st quartile - 1.5*IQR 
                             quantile(lifeExp, probs = 0.75) + (IQR(lifeExp) * 1.5) < lifeExp ~ "outlier", # anything higher than the 3rd quartile + 1.5*IQR
                             .default = NA)) |> 
  filter(!is.na(outlier)) |> # remove non-outliers
  ungroup() |> group_by(country) |> # regroup by country
  filter(lifeExp == min(lifeExp)) # filter just the min for each country

head(outliers)

no_outliers <- gapminder |> 
  group_by(continent) |> 
  mutate(outlier = case_when(quantile(lifeExp, probs = 0.25) - (IQR(lifeExp) * 1.5) > lifeExp ~ "outlier",
                             quantile(lifeExp, probs = 0.75) + (IQR(lifeExp) * 1.5) < lifeExp ~ "outlier", 
                             .default = NA)) |> 
  filter(is.na(outlier)) # remove outliers

head(no_outliers)

ggplot(gapminder, aes(x = continent, y = lifeExp)) +
  geom_boxplot(outlier.colour = "hotpink", outlier.size = 3) +
  geom_jitter(data = no_outliers, position = position_jitter(width = 0.1, height = 0), alpha = 0.25, size = 3) + 
  geom_text(data = outliers, aes(label = country), size = 8) + 
  theme_minimal(base_size = 18)

library(ggrepel)
ggplot(gapminder, aes(x = continent, y = lifeExp)) +
  geom_boxplot(outlier.colour = "hotpink", outlier.size = 3) +
  geom_jitter(data = no_outliers, position = position_jitter(width = 0.1, height = 0), alpha = 0.25, size = 3) + 
  geom_label_repel(data = outliers, aes(label = country), color = "hotpink", size = 8) + 
  theme_minimal(base_size = 18)

# Bonus: Advanced Example! (slide 59)

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) 

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_line() 

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_line() +
  geom_line(stat = "smooth", 
            method = "loess", 
            aes(group = continent)) 

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_line() +
  geom_line(stat = "smooth", 
            method = "loess", 
            aes(group = continent)) +
  facet_wrap(~ continent, 
             nrow = 2)

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_line() +
  geom_line(stat = "smooth", 
            method = "loess", 
            aes(group = continent)) +
  facet_wrap(~ continent, 
             nrow = 2) +
  scale_color_manual(name = "Life Exp. for:", 
                     values = c("Country" = "black", "Continent" = "blue"))

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_line() +
  geom_line(stat = "smooth", 
            method = "loess", 
            aes(group = continent)) +
  facet_wrap(~ continent, 
             nrow = 2) +
  scale_color_manual(name = "Life Exp. for:", 
                     values = c("Country" = "black", "Continent" = "blue")) +
  scale_size_manual(name = "Life Exp. for:", 
                    values = c("Country" = 0.25, "Continent" = 3))

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_line(aes(color = "Country", size = "Country")) +
  geom_line(stat = "smooth", method = "loess", 
            aes(group = continent, color = "Continent", size = "Continent")) +
  facet_wrap(~ continent, 
             nrow = 2) +
  scale_color_manual(name = "Life Exp. for:", 
                     values = c("Country" = "black", "Continent" = "blue")) +
  scale_size_manual(name = "Life Exp. for:", 
                    values = c("Country" = 0.25, "Continent" = 3))

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_line(alpha = 0.5, 
            aes(color = "Country", size = "Country")) +
  geom_line(stat = "smooth", method = "loess", 
            aes(group = continent, color = "Continent", size = "Continent"), 
            alpha = 0.5) +
  facet_wrap(~ continent, 
             nrow = 2) +
  scale_color_manual(name = "Life Exp. for:", 
                     values = c("Country" = "black", "Continent" = "blue")) +
  scale_size_manual(name = "Life Exp. for:", 
                    values = c("Country" = 0.25, "Continent" = 3))

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_line() +
  geom_line(stat = "smooth", 
            method = "loess", 
            aes(group = continent)) +
  facet_wrap(~ continent, 
             nrow = 2) +
  scale_color_manual(name = "Life Exp. for:", 
                     values = c("Country" = "black", "Continent" = "blue")) +
  scale_size_manual(name = "Life Exp. for:", 
                    values = c("Country" = 0.25, "Continent" = 3)) +
  theme_minimal(base_size = 14) + 
  labs(y = "Years", 
       x = "")

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_line() +
  geom_line(stat = "smooth", 
            method = "loess", 
            aes(group = continent)) +
  facet_wrap(~ continent, 
             nrow = 2) +
  scale_color_manual(name = "Life Exp. for:", 
                     values = c("Country" = "black", "Continent" = "blue")) +
  scale_size_manual(name = "Life Exp. for:", 
                    values = c("Country" = 0.25, "Continent" = 3)) +
  theme_minimal(base_size = 14) + 
  labs(y = "Years", 
       x = "", 
       title = "Life Expectancy, 1952-2007", 
       subtitle = "By continent and country")

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_line() +
  geom_line(stat = "smooth", 
            method = "loess", 
            aes(group = continent)) +
  facet_wrap(~ continent, 
             nrow = 2) +
  scale_color_manual(name = "Life Exp. for:", 
                     values = c("Country" = "black", "Continent" = "blue")) +
  scale_size_manual(name = "Life Exp. for:", 
                    values = c("Country" = 0.25, "Continent" = 3)) +
  theme_minimal(base_size = 14) + 
  labs(y = "Years", 
       x = "", 
       title = "Life Expectancy, 1952-2007", 
       subtitle = "By continent and country") +
  theme(axis.text.x = element_text(angle = 45)) 

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_line() +
  geom_line(stat = "smooth", 
            method = "loess", 
            aes(group = continent)) +
  facet_wrap(~ continent, 
             nrow = 2) +
  scale_color_manual(name = "Life Exp. for:", 
                     values = c("Country" = "black", "Continent" = "blue")) +
  scale_size_manual(name = "Life Exp. for:", 
                    values = c("Country" = 0.25, "Continent" = 3)) +
  theme_minimal(base_size = 14) + 
  labs(y = "Years", 
       x = "", 
       title = "Life Expectancy, 1952-2007", 
       subtitle = "By continent and country") +
  theme(legend.position = c(0.82, 0.15), 
        axis.text.x = element_text(angle = 45))

# ggplot Extensions! (slide 73)

# install.packages("geomtextpath") <- run in console first
library(geomtextpath)
gapminder |> 
  filter(country %in% c("Cuba", "Haiti", "Dominican Republic")) |> # restricting data to 3 regionally-specific countries
  ggplot(aes(x = year, 
             y = lifeExp, 
             color = country, 
             label = country)) + # specify label with text to appear
  geom_textpath() + # adding textpath geom to put labels within lines
  theme(legend.position = "none") # removing legend

# install.packages("ggridges") <- run in console first
library(ggridges)
ggplot(gapminder, 
       aes(x = lifeExp, 
           y = continent, 
           fill = continent, 
           color = continent)) +
  geom_density_ridges(alpha = 0.5, 
                      show.legend = FALSE) # add ridges, make all a bit transparent, remove legend

# install.packages("GGally") <- run in console first
library(GGally)

ggcorr(swiss, 
       geom = "circle", 
       min_size = 25, # specify minimum size of shape 
       max_size = 25, # specify maximum size of shape 
       label = TRUE, # label circles with correlation coefficient
       label_alpha = TRUE, # less strong correlations have lower alpha
       label_round = 2, # round correlations coefficients to 2 decimal points
       legend.position = c(0.15, 0.6), 
       legend.size = 12)

# install.packages("ggcorrplot") <- run in console first
library(ggcorrplot)

# compute correlation matrix
corr <- round(cor(swiss), 1)
# computer matrix of correlation p-values
p_mat <- cor_pmat(swiss)

ggcorrplot(corr,
           hc.order = TRUE, # use hierarchical clustering to group like-correlations together
           type = "lower", # only show lower half of correlation matrix
           p.mat = p_mat, # give corresponding p-values for correlation matrix
           insig = "pch", # add default shape (an X) to correlations that are insignificant
           outline.color = "black", # outline cells in white
           ggtheme = ggthemes::theme_tufte(), # using a specific theme I like from ggthemes package 
           colors = c("#4e79a7", "white", "#e15759")) + # specify custom colors 
  theme(legend.position = c(0.15, 0.67))

ggpairs(swiss, 
        lower = list(continuous = wrap("smooth", # specify a smoothing line added to scatterplots
                                       alpha = 0.5, 
                                       size=0.2))) + 
  ggthemes::theme_tufte() # add nice theme from ggthemes

# install.packages("patchwork") <- run in console first
library(patchwork)

# Create first plot object
plot_lifeExp <- ggplot(gapminder, 
                       aes(x = lifeExp, y = continent, fill = continent, color = continent)) +
  geom_density_ridges(alpha = 0.5, show.legend = FALSE)

# Create second plot object
plot_boxplot <- ggplot(gapminder, 
                       aes(x = continent, y = lifeExp, color = continent), 
                       alpha = 0.5) +
  geom_boxplot(outlier.colour = "black", varwidth = TRUE) + # change outlier color and make width of boxes relative to N
  coord_flip() + # flip the coordinates (x & y) to align with first plot
  geom_jitter(position = position_jitter(width = 0.1, height = 0), # add datapoints to boxplot
              alpha = 0.25) + 
  geom_label_repel(data = outliers, # add new dataset with just 4 of the outliers
                   aes(label = country), 
                   color = "black") +
  theme(axis.text.y = element_blank(), # remove y axis text 
        axis.ticks.y = element_blank(), # remove y axis ticks 
        axis.title.y = element_blank(), # remove y axis title 
        legend.position = "none")

plot_lifeExp + plot_boxplot # simply add two objects together to place side by side

plot_lifeExp + theme_bw() # reusing plot_lifeExp from previous slide and changing theme

plot_lifeExp + theme_light()

plot_lifeExp + theme_classic()

plot_lifeExp + theme_linedraw()

plot_lifeExp + theme_dark()

plot_lifeExp + theme_minimal()

plot_lifeExp + theme_gray()

plot_lifeExp + theme_void()

library(ggthemes)
plot_lifeExp + theme_excel()

plot_lifeExp + theme_economist()

plot_lifeExp + theme_few()

plot_lifeExp + theme_fivethirtyeight() 

plot_lifeExp + theme_gdocs()

plot_lifeExp + theme_stata()

plot_lifeExp + theme_tufte()

plot_lifeExp + theme_wsj()
