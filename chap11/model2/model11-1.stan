//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

data{
  int N;
  int<lower=0, upper=1> Y[N];
}

parameters{
  real<lower=0, upper=1> q;
}

model{
  for(i in 1:N){
    target += log_sum_exp(
      log(0.5) + bernoulli_lpmf(Y[i] | q),
      log(0.5) + bernoulli_lpmf(Y[i] | 1)
    );
  }
}