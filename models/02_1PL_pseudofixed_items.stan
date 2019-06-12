data {
  int<lower=1> I;
  int<lower=1> J;
  int<lower=1> N;

  int<lower=0,upper=I> ii[N];
  int<lower=0,upper=J> jj[N];
  int<lower=0,upper=1> y[N];

  int<lower=0,upper=1> fixed[J];
  real beta_fixed[J];
  real sd_beta_fixed[J];
}
parameters {
  vector[J] beta;
  real theta_norm[I];
  real mu_theta;
  real<lower=0> sigma_theta;
}
transformed parameters {
  vector[I] theta;

  for (i in 1:I)
    theta[i] = mu_theta + theta_norm[i] * sigma_theta;
}
model {
  target += normal_lpdf(beta | 0, 1);

  for (j in 1:J) {
    if (fixed[j] == 1)
      beta_fixed[j] ~ normal(beta[j], sd_beta_fixed[j]);
  }

  target += normal_lpdf(theta_norm | 0, 1);
  target += normal_lpdf(mu_theta | 0, 1);
  target += normal_lpdf(sigma_theta | 0, 1);

  target += bernoulli_logit_lpmf(y | theta[ii] - beta[jj]);
}
