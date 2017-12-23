#PART 1
library(dplyr)
#Question 1

twins <- twins[,c(3,5,7,8,9,11,12)]
head(twins)

#Question 2

str(twins)

#Question 3

twins <- mutate(twins, WLH = cut(twins$HRWAGEH, breaks = c(0, 15, 40, 100),labels = c("Low", "Average", "High")))
twins <- mutate(twins, WLL = cut(twins$HRWAGEL, breaks = c(0, 15, 40, 100),labels = c("Low", "Average", "High")))

#Question 4
reg <- lm(EDUCL ~ HRWAGEL, data = twins)
summary(reg)
# residual plot
par(mfrow = c(2, 2))
plot(reg)

# Based on these graph results I think they do not have a linear relationship

#Question 5 

(tab <- xtabs(~ HRWAGEL + HRWAGEH, data = twins))
chisq.test(tab)

# Based on the Chi-Sq Test, the Wage Levels of Twin 1 and Twin 2 are dependant.
# H0 is that the values are independent but based on the p-value we reject H0 at 0.05 significance level

#PART 2

law_of_large_nos <- function(x)
{
  ans <- sample(c("H","T"),x, replace=T, prob = c(0.5,0.5))
  count <- 0
  for (val in ans){
    if (val == "H") count = count +1
  }
  return(count/x)
}

#Percentage of Heads
law_of_large_nos(1000)
#Yes it is close to 0.5! Therefore, the Law of Large Numbers is verified