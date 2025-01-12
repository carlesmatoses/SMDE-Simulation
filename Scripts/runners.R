library(dplyr)

h2s <- function(x) as.numeric(strptime(x, format="%H:%M:%S") - as.POSIXct(format(Sys.Date())), units="secs")

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
  Bib = as.integer(Bib),
  City = as.factor(City),
  State = as.factor(State),
  Country = as.factor(Country),
)

# 1 Read data
m15 <- process_data("./Data/marathon_results_2015.csv")
m16 <- process_data("./Data/marathon_results_2016.csv")
m17 <- process_data("./Data/marathon_results_2017.csv")

hist(m15$Official.Time)
hist(m16$Official.Time)
hist(m17$Official.Time)
