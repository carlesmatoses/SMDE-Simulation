library(dplyr)

h2s <- function(x) as.numeric(strptime(x, format="%H:%M:%S") - as.POSIXct(format(Sys.Date())), units="secs")
level <- function(x) if (x < 18) { "Elite" } else if (x >= 500) { "New" } else { "Hobby" }

process_data <- function(file) read.csv(file) %>% mutate(
  X5K = h2s(X5K),
  X10K = h2s(X10K),
  X15K = h2s(X15K),
  X20K = h2s(X20K),
  Half = h2s(Half),
  X25K = h2s(X25K),
  X30K = h2s(X30K),
  X35K = h2s(X35K),
  X40K = h2s(X40K),
  Pace = h2s(Pace),
  Official.Time = h2s(Official.Time),
  M.F = as.factor(M.F),
  City = as.factor(City),
  State = as.factor(State),
  Country = as.factor(Country),
  AgeRange = as.integer(Age/5) * 5,
  LogTime = log(Official.Time),
)

# 1 Read data
m15 <- process_data("./Data/marathon_results_2015.csv")
m16 <- process_data("./Data/marathon_results_2016.csv")
m17 <- process_data("./Data/marathon_results_2017.csv")

# Time distributions (not normal)
hist(m15$Official.Time)
hist(m16$Official.Time)
hist(m17$Official.Time)

max(m15$Official.Time)

# Age distributions
hist(m15$Age, breaks = 16)
hist(m15[m15$Age < 60, "Age"], breaks = 8)

# Drop runners older than 60
m15.sub60 <- m15 %>% filter(Age >= 20 & Age < 60)

# Check gender distributions
boxplot(log(Official.Time) ~ M.F, data = m15.sub60)
boxplot(log(Official.Time) ~ AgeRange, data = m15.sub60)

boxplot(log(Official.Time) ~ AgeRange, data = m15.sub60[m15.sub60$M.F == "M", c("Official.Time", "AgeRange")])
boxplot(log(Official.Time) ~ AgeRange, data = m15.sub60[m15.sub60$M.F == "F", c("Official.Time", "AgeRange")])

# Check pace distribution
plot(Official.Time ~ Pace, data = m15)
hist(log(m15$Pace))
hist(log(m15.sub60$Official.Time))

# Check normality for combined
hist(log(m15.sub60$Official.Time))
qqnorm(log(m15.sub60$Official.Time))

hist(log(m15.sub60$Pace))
qqnorm(log(m15.sub60$Pace))

# Check normality for male
hist(log(m15.sub60[m15.sub60$M.F == "M", "Official.Time"]))
qqnorm(log(m15.sub60[m15.sub60$M.F == "M", "Official.Time"]))

# Check normality for female
hist(log(m15.sub60[m15.sub60$M.F == "F", "Official.Time"]))
qqnorm(log(m15.sub60[m15.sub60$M.F == "F", "Official.Time"]))

summary(m15$Pace)
sd(m15$Pace)

elites <- m15[m15$X5K < 18*60, "LogTime"]
hobby <- m15[m15$X5K >= 18*60 & m15$X5K < 25*60, "LogTime"]
news <- m15[m15$X5K >= 25*60, "LogTime"]
elites <- elites[complete.cases(elites)]
hobby <- hobby[complete.cases(hobby)]
news <- news[complete.cases(news)]
summary(elites)
summary(elites[complete.cases(elites)])
sd(elites)
summary(hobby)
sd(hobby)
summary(news)
sd(news)

max(m15$Official.Time[complete.cases(m15$Official.Time)])
