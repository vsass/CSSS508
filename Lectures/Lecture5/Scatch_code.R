# 2. Go to the [Lecture 5 Homepage](https://vsass.github.io/CSSS508/Lectures/Lecture5/CSSS508_Lecture5_index.html) and click on the link `Higher Education Trends` under the Data section. 
#   i) Click *File* > *Save* to download this data to the same folder where your source document^[`R` Script or `.qmd`] will be saved for this lab.
#   ii) Read in your data using the appropriate function from `readr`. 
#   iii) Pivot your data to make it tidy^[There should be 3 columns in your final dataset].
#   iv) Visualize these data. What's the trend in higher educational careers? 

library(geomtextpath)

higher_edu <- read_csv(file = "data/instructional-staff.csv")
higher_edu_tidy <- higher_edu |> 
  pivot_longer(cols = !faculty_type, 
               names_to = "year", 
               values_to = "percentage") |> 
  mutate(year = as.integer(year))

ggplot(higher_edu_tidy, aes(x = year, y = percentage, color = faculty_type)) + 
  geom_textpath(aes(label = faculty_type))