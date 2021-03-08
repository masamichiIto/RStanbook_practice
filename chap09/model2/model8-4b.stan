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
data {
  int N;
  int K;
  vector[N] X;
  vector[N] Y;
  int<lower=0, upper=K> KID[N]; 
}

parameters{
  real a0;
  real b0;
  vector[K] a;
  vector[K] b;
  real<lower=0> s_a;
  real<lower=0> s_b;
  real<lower=0> s_Y;
}

model{
  a ~ normal(a0, s_a);
  b ~ normal(b0, s_b);
  Y ~ normal(a[KID] + b[KID] .* X, s_Y);
}