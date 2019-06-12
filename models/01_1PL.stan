data {
  int<lower=1> I;
  int<lower=1> J;
  int<lower=1> N;

  int<lower=1,upper=I> ii[N];
  int<lower=1,upper=J> jj[N];

  int<lower=0> y[N];
  int<lower=1> NC;
  int<lower=1,upper=NC> c[I];
}
parameters {
  vector[I] theta_norm;
  real mu_theta[NC];
  real<lower=0> sigma_theta[NC];
  vector[J] beta;
}
transformed parameters {
  vector[I] theta;

  for (n in 1:I)
    theta[n] = mu_theta[c[n]] + theta_norm[n] * sigma_theta[c[n]];
}
model {
  target += normal_lpdf(theta_norm | 0, 1);
  target += normal_lpdf(mu_theta | 0, 1);
  target += normal_lpdf(sigma_theta | 0, 1);
  target += normal_lpdf(beta | 0, 1);

  target += bernoulli_logit_lpmf(y | theta[ii] - beta[jj]);
}
