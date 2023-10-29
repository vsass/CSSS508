
# Random unused code ------------------------------------------------------

# proportion of religious affiliations

# Data manipulation 2
religion_income_prop <- religion_income_tidy |> 
  filter(income != "Don't know/refused") |> 
  mutate(total = sum(frequency), 
         prop = frequency/total, 
         .by = religion) |> 
  arrange(desc(prop))
religion_income_prop

Visualization 2
ggplot(religion_income_prop, aes(x = as.integer(income), y = prop, color = religion)) +
  geom_point() +
  geom_textpath(aes(label = religion)) +
  labs(title = "Relative Distribution of Income by Religion",
       x = "Income Level",
       y = "Proportion of Respective Religious Affiliation") +
  theme_tufte(base_size = 18)
