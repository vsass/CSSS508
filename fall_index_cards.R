##################
### Class data ###
##################

library(tidyverse)

fall_2023 <- tribble(
  ~name, ~pronouns, ~program, ~year, ~programming_experience, ~feelings_about_course, ~communicate_animals_humans, 
  "a", NA, "MPH", 2, "Used R in a course", "curious", "fluency in every language",
  "b", NA,  "PhD Business Administration", 1, "Tried to study R but not comfortable navigting through packages", "Excited", "animal", 
  "c", NA, "PhD", 3, "A summer tutoring session w/ a grad dtudent -> I learned a little ;) Took a class for 2 weeks and dropped", "Eager to start", "Converse with non-human animals so I can alet animals (birds) to dangers in the built environment --> my topic of study 😊", 
  "d", "He/Him/His", "Information Management Masters", 2, "A bit R but mostly Python", NA, 
  "e", "he, him", "MSW/MPH", 3, "Last year was my first time learning R", "Excited", "Lifelong fluency in every human language", 
  
)
