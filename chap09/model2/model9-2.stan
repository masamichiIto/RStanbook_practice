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
  vector[D] Y[N];
}

parameters{
  vector[D] mn;
  cov_matrix[D] cov;
}

model{
  for(i in 1:N){
    Y[i] ~ multi_normal(mn, cov);
  }
}