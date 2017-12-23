# Kitu Komya
# UID: 404-491-375

library(dplyr)
twins <- read.table(file = "Kitu/College/Junior Year/Winter Quarter/Stats 130/twins.txt", header = T, sep = ",")

# PART 1

# QUESTION 1
twins <- twins[, c(3, 5, 7, 8, 9, 11, 12)]

# QUESTION 2
str(twins)

# QUESTION 3
twins <- mutate(twins, WLH = cut(twins$HRWAGEH, breaks = c(0, 15, 40, 100), labels = c("Low", "Average", "High")))
twins <- mutate(twins, WLL = cut(twins$HRWAGEL, breaks = c(0, 15, 40, 100), labels = c("Low", "Average", "High")))

# QUESTION 4
fit <- lm(HRWAGEL ~ EDUCL, data = twins)
plot(x = twins$EDUCL, y = twins$HRWAGEL) 
# for some reason, plot(fit) is only returning the residual, normal qq, scale-location, and residuals vs leverage points plots NOT the actual scatterplot 
# plot(fit)
abline(fit)

# Based off the plot, we can conclude that if there is any linear relationship between education and income,
# it is extremely, extremely weak, essentially nonexistent.

# QUESTION 5
tab <- xtabs(~ WLH + WLL, data = twins)
chisq.test(tab)

# Because the p-value is 1.88 * 10^-9 which is less than 0.05, at the 5% significance level we reject the null hypothesis
# and thus conclude that the wage levels of twin1 and twin2 and not independent and thus dependent. 


# PART 2
large <- function(x)
{
  samples <- sample(c("H","T"), x, replace = T, prob = c(0.5,0.5))
  sum <- 0
  for (count in samples)
  {
    if (count == "H") 
    {
      sum = sum + 1
    }
  }
  return(sum/x)
}

large(1000)

# My simulation gives me a proportion of 0.501 which is obviously very close to 0.5. Hence, we can 
# confirm the Law of Large Numbers!
