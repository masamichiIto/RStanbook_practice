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
  int T;
  int T_pred;
  vector[T] Y;
}

parameters{
  vector[T] mu;
  real<lower=0> s_mu;
  real<lower=0> s_Y;
}

model{
  mu[2:T] ~ normal(mu[1:(T-1)], s_mu);
  Y ~ normal(mu, s_Y);
}

generated quantities{
  vector[T+T_pred] mu_all;
  vector[T_pred] y_pred;
  mu_all[1:T] = mu;
  for(t in 1:T_pred){
    mu_all[T+t] = normal_rng(mu_all[T+t-1], s_mu);
    y_pred[t] = normal_rng(mu_all[T+t], s_Y);
  }
}