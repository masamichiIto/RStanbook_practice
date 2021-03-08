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
  int T;
  real Time[T];
  matrix[N,T] Y;
  int T_new;
  real Time_new[T_new];
}

parameters{
  real a0;
  real b0;
  vector[N] log_a;
  vector[N] log_b;
  real<lower=0> s_a;
  real<lower=0> s_b;
  real<lower=0> s_Y;
}

transformed parameters{
  vector[N] a;
  vector[N] b;
  matrix[N, T] mu;
  a = exp(log_a);
  b = exp(log_b);
  for(t in 1:T){
    for(i in 1:N){
      mu[i,t] = a[i] *(1-exp(-b[i]*Time[t]));
    }
  }
}

model{
  log_a ~ normal(a0, s_a);
  log_b ~ normal(b0, s_b);
  to_vector(Y) ~ normal(to_vector(mu), s_Y);
}

generated quantities{
  real y_new[N, T_new];
  for(i in 1:N){
    for(t in 1:T_new){
      y_new[i,t] = normal_rng(a[i]*(1-exp(-b[i]*Time_new[t])), s_Y);
    }
  }
}
