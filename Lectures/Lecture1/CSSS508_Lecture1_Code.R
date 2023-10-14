########################
### Lecture 1 R Code ###
########################

# Note: Anything behind a # that isn't a comment (like this) is code that is 
# interactive or won't fully run. To see what that code does simply remove the 
# leading # and run it as normal or highlight the code directly and run it 
# any of the ways we discussed in lecture. 


# Introduction to R, RStudio, and Quarto ----------------------------------

7 * 49
# Sometimes important stuff is highlighted! 

# (11-2

123 + 456 + 789

sqrt(400)

# ?sqrt

## ??exponential

new.object <- 144

new.object

new.object + 10
new.object + new.object
sqrt(new.object)

# create vector of ages of students
ages <- c(45, 21, 27, 34, 23, 24, 24)

# get average age of students
mean(ages)

new.object <- c(4, 9, 16, 25, 36)
new.object

sqrt(new.object)

# Quarto ------------------------------------------------------------------

summary(cars)

x <- sqrt(77) 

# Base R and Packages -----------------------------------------------------

head(cars, 5) # prints first 5 rows, see tail() too

str(cars) # str[ucture]

summary(cars)

hist(cars$speed) # Histogram

hist(cars$dist)

hist(cars$dist,
     xlab = "Distance (ft)", # X axis label
     main = "Observed stopping distances of cars") # Title

plot(dist ~ speed, data = cars,
     xlab = "Speed (mph)",
     ylab = "Stopping distance (ft)",
     main = "Speeds and stopping distances of cars",
     pch = 16) # Point shape
abline(h = mean(cars$dist), col = "firebrick") # add horizontal line
abline(v = mean(cars$speed), col = "cornflowerblue") # add vertical line

pairs(swiss, 
      pch = 8, 
      col = "violet",
      main = "Pairwise comparisons of Swiss variables")

library(gt) # loads gt, do once in your session
gt(as.data.frame.matrix(summary(swiss))) 

head(swiss)
gt_preview(swiss, 
           top_n = 3, # default is 5
           bottom_n = 3) # default is 1 