# Kitu Komya
# UID: 404-491-375

library(dplyr)
crime <- read.table(file = "Kitu/College/Junior Year/Winter Quarter/Stats 130/uscrime.txt", header = T)

# PART 1
# 1
# There are 16 variables and 47 observations.

# 2-1
crime <- crime[, c(2, 3, 10, 11, 12, 16)]

# 2-2
crime$UR <- (crime$U1+crime$U2)/2
crime <- mutate(crime, URlevel = cut(UR, breaks = c(0, 3, 7, 10), labels = c("Low", "Average", "High")))

# 2-3
crime <- crime[, -c(3, 4)]

# 3
fit <- lm(Crime ~ So + Ed + UR + Wealth, data = crime)
summary(fit)

# The variables with significant linear relationship with crime rate include So and Wealth.
# In interpreting the coefficients, we can conclude that if a state is a southern state, then on average, 
# the state's crime rate is higher by a rate of 330.5/100,000. Moreover, as an individual's wealth increases
# by 1 value of transferrable assets or family income, then on average, the individual will have a crime rate 
# reduced by a rate of 0.2170/100,000.

# 4
fit2 <- aov(Crime ~ URlevel, data = crime)
summary(fit2)

# Because the p-value is 0.736 which is greater than 0.05, at the 5% significance level we fail to reject the null hypothesis
# and thus conclude that crime rates among different unemployment levels are not significantly different. This is consistent
# with our claim from problem 3, since UR was not a significant variable in our linear regression model then either.


# PART 2
roll <- function(x) # x determines number of rolls
{
  count = 0
  # roll two dice
  for (i in 1:x) # roll either 100 times for simulation or 1000 times for analytical
  {
    a <- sample(1:6, 1)
    b <- sample(1:6, 1)
    sum = a + b
    if (sum > 8)
    {
      count = count + 1
    }
  }
  total = count/x
  return(total)
}

roll(100)
mean(roll(1000))

# The simulation of rolling 100 times gives a proportion value of 0.26 while the analytical answer 
# simulates a mean proportion value of 0.279, which is very close to the true value of 0.27778 (10/36). 
# Thus, the simulation supports the analytical value.