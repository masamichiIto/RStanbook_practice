library(rstan)
setwd("~/Desktop/programs/R/RStanBook/chap09")

d <- read.csv(file='input/data-attendance-5.txt')
d$Score <- d$Score/200
X <- cbind(1, d[,-ncol(d)])
data <- list(N=nrow(d), D=ncol(X), X=X, Y=d$Y)
fit <- stan(file='model2/model9-3.stan', data=data, seed=1234)
fit
save.image(file = "output/result-model9-3.RData")
