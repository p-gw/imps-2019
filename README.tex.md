# Estimation of transfer effects for the standardized Austrian matriculation exam
This is the repository for the poster presentation *Estimation of transfer effects for the standardized Austrian matriculation exam* at the International Meeting of the Psychometric Society 2019 in Santiago de Chile.

The repository contains additional information about the methods and procedures used in the estimation of the transfer effect and subsequent predictions on the item level for the most recent high-stakes test (see [Model specification](#model-specification)).

*R* (with data.table and ggplot2) and *Stan* (rstan) were used to estimate the models and create the plots (see [Software](#software)). Stan code for the models can be found in the [models](models/) folder.

The digital version of the poster is available in [A0 Format](transfer_effect_poster_A0.pdf) (original size) or scaled down to [A4 Format](transfer_effect_poster_A4.pdf) (handout size).

## Model specification
### Step 1: 1 Parameter Logistic IRT Model (1PL)
The Likelihood function is defined by

$P(Y_{ij} = 1 | \theta_i, \beta_j) = \mathrm{logit}^{-1}(\theta_i - \beta_j)$,

where $i = 1, \ldots, I$ is an index for persons and $j = 1, \ldots, J$ indexes items of the test. $\mathrm{logit}^{-1}$ is the inverse logit function (standard logistic function) defined as

$\mathrm{logit}^{-1}(x) = \frac{1}{1 + e^{-x}}$.

The prior distribution for $\beta_j \sim \mathrm{Normal}(0, 1)$ is chosen to fix the scale of the latent item difficulty parameters, while $\theta_i$ is estimated freely. The prior for $\theta_i$ is defined by

$\theta_i \sim \mathrm{Normal}(\mu_{c(i)}, \sigma_{c(i)})$,

with hyperparameters $\mu_{c(i)}$ and $\sigma_{c(i)}$. $c(i) = 1, \ldots, C$ is the index of the low-stakes pilot study $c$ for person $i$. Thus, separate population means and standard deviations are estimated for each pilot study. The following prior distributions are defined on the hyperparameters $\mu_{c(i)}$ and $\sigma_{c(i)}$:

$\mu_{c(i)} \sim \mathrm{Normal}(0, 1)$,

$\sigma_{c(i)} \sim \mathrm{Half-Normal}(0, 1)$.

### Step 2: 1PL with fixed item difficulties
In order to estimate the population distributions in the high-stakes matriculation exams, a separate model is fit for each high-stakes test. Again a 1PL model was chosen and identical prior distributions were assigned for both $\theta_i \sim \mathrm{Normal}(\mu, \sigma)$<sup>1</sup> and $\beta \sim \mathrm{Normal}(0, 1)$ to scale the parameters analogous to the model in step 1. The hyperpriors for $\mu$ and $\sigma$ were also identical to the prior distributions in step 1.

To incorporate information about item difficulties derived in step 1, additional constraints are imposed on $\beta_j$. For this, the point estimate $\hat{\beta}_j = E(\beta_j)$ and the standard deviation of the item difficulty distribution $\hat{\sigma}_{\beta_j} = \sqrt(Var(\beta_j))$ are used from step 1 to define a measurement model on $\beta$ such that,

$\hat{\beta}_j \sim \mathrm{Normal}(\beta_j, \hat{\sigma}_{\beta_j})$.

<sup>1</sup> Indexing of $\mu$ and $\sigma$ in this step is not required as the models are estimated separately for each test.

### Step 3: Regression with measurement error
To estimate the desired transfer effect between low-stakes and high-stakes tests, population means in the high-stakes test ($\mu_{H_i}$) were regressed on population means in the low-stakes test ($\mu_{L_i}$). Index $i = 1, \ldots, 3$ defines a pair of low-stakes and high-stakes test in the same cohort. The model is given by

$\mu_{H_i} \sim \mathrm{Normal}(\alpha + \mu_{L_i}, \tau)$,

and includes the transfer effect in the parameter $\alpha$. Again, measurement error was accounted for by a measurement model on $\mu_{L_i}$<sup>2</sup>,

$\hat{\mu}_{L_i} \sim \mathrm{Normal}(\mu_{L_i}, \hat{\sigma}_{L_i})$.

Informative prior distributions for $\mu_{L_i}$, $\alpha$, and $\tau$ were used to regularize the posterior estimates:

$\mu_{L_i} \sim \mathrm{Normal}(-0.25, 0.5)$

$\alpha \sim \mathrm{Normal}(1, 0.5)$

$\tau \sim \mathrm{Normal}(0, 0.5)$

<sup>2</sup> A measurement model on $\mu_H$ was omitted because the standard deviation of $\mu$ in step 2 was estimated to be low and to solve some identification issues due to few observations (reducing number of parameters).

## Software
Bob Carpenter, Andrew Gelman, Matthew D. Hoffman, Daniel Lee, Ben Goodrich, Michael Betancourt, Marcus Brubaker, Jiqiang Guo, Peter Li, and Allen Riddell (2017). Stan: A probabilistic programming language. Journal of Statistical Software 76(1). DOI 10.18637/jss.v076.i01

Matt Dowle and Arun Srinivasan (2019). data.table: Extension of
`data.frame`. R package version 1.12.2.
https://CRAN.R-project.org/package=data.table

R Core Team (2019). R: A language and environment for statistical
computing. R Foundation for Statistical Computing, Vienna, Austria.
https://www.R-project.org/.

Stan Development Team (2018). RStan: the R interface to Stan. R package version 2.17.3.   http://mc-stan.org

Wickham, H. (2016). ggplot2: Elegant Graphics for Data Analysis.
  New York: Springer.
