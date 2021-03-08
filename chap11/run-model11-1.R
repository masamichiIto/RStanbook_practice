library(rstan)
setwd("~/Desktop/programs/R/RStanBook/chap11")

d <- read.csv(file='input/data-coin.txt')
data <- list(N=nrow(d), Y=d$Y)
fit <- stan(file='model2/model11-1.stan', data=data, seed=1234)
save.image(file = "output/result-model11-1.RData")
