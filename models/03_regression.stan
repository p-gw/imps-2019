data {
  int N;

  vector[N] mu_h;
  vector[N] sd_h;
  vector[N] mu_hat_l;
  vector[N] sd_hat_l;

  real mu_hat_l_pred;
  real sd_hat_l_pred;
}
parameters {
  real alpha;
  real<lower=0> tau;
  vector[N] mu_l;
  real mu_l_pred;
}
model {
  mu_l ~ normal(-0.25, 0.5);

  mu_hat_l ~ normal(mu_l, sd_hat_l);
  alpha ~ normal(1, 0.5);
  tau ~ normal(0, 0.5);

  mu_h ~ normal(alpha + mu_l, tau);

  // same priors on generated quantity parameters
  mu_l_pred ~ normal(-0.25, 0.5);
  mu_hat_l_pred ~ normal(mu_l_pred, sd_l_pred);
}
generated quantities {
  real mu_h_pred;
  mu_h_pred = normal_rng(alpha + mu_l_pred, tau);
}
