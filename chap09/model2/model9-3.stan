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
  int D;
  matrix[N,D] X;
  vector<lower=0, upper=1>[N] Y;
}

parameters{
  vector[D] b;
  real<lower=0> sigma;
}

transformed parameters{
  vector[N] mu;
  mu = X*b;
}

model{
  Y ~ normal(mu, sigma);
}