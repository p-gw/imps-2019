# Estimation of transfer effects for the standardized Austrian matriculation exam
This is the repository for the poster presentation *Estimation of transfer effects for the standardized Austrian matriculation exam* at the International Meeting of the Psychometric Society 2019 in Santiago de Chile.

The repository contains additional information about the methods and procedures used in the estimation of the transfer effect and subsequent predictions on the item level for the most recent high-stakes test (see [Model specification](#model-specification)).

*R* (with data.table and ggplot2) and *Stan* (rstan) were used to estimate the models and create the plots (see [Software](#software)). Stan code for the models can be found in the [models](models/) folder.

The digital version of the poster is available in [A0 Format](transfer_effect_poster_A0.pdf) (original size) or scaled down to [A4 Format](transfer_effect_poster_A4.pdf) (handout size).

## Model specification
### Step 1: 1 Parameter Logistic IRT Model (1PL)
The Likelihood function is defined by

<img src="/tex/1fcb149bf2c2f0f382f7e4ed952f290c.svg?invert_in_darkmode&sanitize=true" align=middle width=251.98622790000002pt height=29.534320200000014pt/>,

where <img src="/tex/6e5449fbf7d5e13f0a2d97818795d655.svg?invert_in_darkmode&sanitize=true" align=middle width=80.84546909999997pt height=22.465723500000017pt/> is an index for persons and <img src="/tex/f9fd5b3e4692d6e96f7241b3ee283314.svg?invert_in_darkmode&sanitize=true" align=middle width=85.07302649999998pt height=22.465723500000017pt/> indexes items of the test. <img src="/tex/6f200ebb1186cca7e871aae8ed8b1801.svg?invert_in_darkmode&sanitize=true" align=middle width=48.79013534999999pt height=29.534320200000014pt/> is the inverse logit function (standard logistic function) defined as

<img src="/tex/f5716dbebd2262454c139254c47f3f81.svg?invert_in_darkmode&sanitize=true" align=middle width=134.79651239999998pt height=29.534320200000014pt/>.

The prior distribution for <img src="/tex/0f223ba37b1ea091f604b634a5f9c158.svg?invert_in_darkmode&sanitize=true" align=middle width=128.14219275pt height=24.65753399999998pt/> is chosen to fix the scale of the latent item difficulty parameters, while <img src="/tex/f166369f3ef0a7ff052f1e9bbf57d2e2.svg?invert_in_darkmode&sanitize=true" align=middle width=12.36779114999999pt height=22.831056599999986pt/> is estimated freely. The prior for <img src="/tex/f166369f3ef0a7ff052f1e9bbf57d2e2.svg?invert_in_darkmode&sanitize=true" align=middle width=12.36779114999999pt height=22.831056599999986pt/> is defined by

<img src="/tex/ca2a689a5ce5d9afcd6ba617a2afc922.svg?invert_in_darkmode&sanitize=true" align=middle width=171.21006539999996pt height=24.65753399999998pt/>,

with hyperparameters <img src="/tex/da6239365b75f716cc2425929ee5d820.svg?invert_in_darkmode&sanitize=true" align=middle width=30.70450844999999pt height=14.15524440000002pt/> and <img src="/tex/76d7568afe261f1f0f810cc4e00bc52b.svg?invert_in_darkmode&sanitize=true" align=middle width=30.19268999999999pt height=14.15524440000002pt/>. <img src="/tex/0664f0fbbe7e3e01a7c6926cbe00cee0.svg?invert_in_darkmode&sanitize=true" align=middle width=105.15336314999999pt height=24.65753399999998pt/> is the index of the low-stakes pilot study <img src="/tex/3e18a4a28fdee1744e5e3f79d13b9ff6.svg?invert_in_darkmode&sanitize=true" align=middle width=7.11380504999999pt height=14.15524440000002pt/> for person <img src="/tex/77a3b857d53fb44e33b53e4c8b68351a.svg?invert_in_darkmode&sanitize=true" align=middle width=5.663225699999989pt height=21.68300969999999pt/>. Thus, separate population means and standard deviations are estimated for each pilot study. The following prior distributions are defined on the hyperparameters <img src="/tex/da6239365b75f716cc2425929ee5d820.svg?invert_in_darkmode&sanitize=true" align=middle width=30.70450844999999pt height=14.15524440000002pt/> and <img src="/tex/76d7568afe261f1f0f810cc4e00bc52b.svg?invert_in_darkmode&sanitize=true" align=middle width=30.19268999999999pt height=14.15524440000002pt/>:

<img src="/tex/d586571212cd5d0b68c9447ecbfdd480.svg?invert_in_darkmode&sanitize=true" align=middle width=143.4442185pt height=24.65753399999998pt/>,

<img src="/tex/dffae2ec65f9c95bbf706839335a42b8.svg?invert_in_darkmode&sanitize=true" align=middle width=194.43921749999998pt height=24.65753399999998pt/>.

### Step 2: 1PL with fixed item difficulties
In order to estimate the population distributions in the high-stakes matriculation exams, a separate model is fit for each high-stakes test. Again a 1PL model was chosen and identical prior distributions were assigned for both <img src="/tex/1e4b0d490591ee5c595c32ad268f1a5b.svg?invert_in_darkmode&sanitize=true" align=middle width=128.55690044999997pt height=24.65753399999998pt/><sup>1</sup> and <img src="/tex/59dcb17834533326c2216b3f4384fe99.svg?invert_in_darkmode&sanitize=true" align=middle width=122.0833581pt height=24.65753399999998pt/> to scale the parameters analogous to the model in step 1. The hyperpriors for <img src="/tex/07617f9d8fe48b4a7b3f523d6730eef0.svg?invert_in_darkmode&sanitize=true" align=middle width=9.90492359999999pt height=14.15524440000002pt/> and <img src="/tex/8cda31ed38c6d59d14ebefa440099572.svg?invert_in_darkmode&sanitize=true" align=middle width=9.98290094999999pt height=14.15524440000002pt/> were also identical to the prior distributions in step 1.

To incorporate information about item difficulties derived in step 1, additional constraints are imposed on <img src="/tex/d03f98cb70df5aa6597689da142dc0af.svg?invert_in_darkmode&sanitize=true" align=middle width=15.402472799999991pt height=22.831056599999986pt/>. For this, the point estimate <img src="/tex/31450a3b1a78ed87610234758ca69bce.svg?invert_in_darkmode&sanitize=true" align=middle width=80.23395764999998pt height=31.50689519999998pt/> and the standard deviation of the item difficulty distribution <img src="/tex/79a8587ca18ba71ac4191b400b0b02d1.svg?invert_in_darkmode&sanitize=true" align=middle width=133.76533995pt height=29.424786600000015pt/> are used from step 1 to define a measurement model on <img src="/tex/8217ed3c32a785f0b5aad4055f432ad8.svg?invert_in_darkmode&sanitize=true" align=middle width=10.16555099999999pt height=22.831056599999986pt/> such that,

<img src="/tex/f9d4748142422dabf8e6665b2819bd77.svg?invert_in_darkmode&sanitize=true" align=middle width=151.73807879999998pt height=31.50689519999998pt/>.

<sup>1</sup> Indexing of <img src="/tex/07617f9d8fe48b4a7b3f523d6730eef0.svg?invert_in_darkmode&sanitize=true" align=middle width=9.90492359999999pt height=14.15524440000002pt/> and <img src="/tex/8cda31ed38c6d59d14ebefa440099572.svg?invert_in_darkmode&sanitize=true" align=middle width=9.98290094999999pt height=14.15524440000002pt/> in this step is not required as the models are estimated separately for each test.

### Step 3: Regression with measurement error
To estimate the desired transfer effect between low-stakes and high-stakes tests, population means in the high-stakes test (<img src="/tex/222342d8dd993419ad878b7a0eb4b760.svg?invert_in_darkmode&sanitize=true" align=middle width=25.056502349999988pt height=14.15524440000002pt/>) were regressed on population means in the low-stakes test (<img src="/tex/439a07a0295ec9157cfaaeca943ab3fd.svg?invert_in_darkmode&sanitize=true" align=middle width=23.30877284999999pt height=14.15524440000002pt/>). Index <img src="/tex/bc1e8c0bf7bfc6dba8044e71e1f309a5.svg?invert_in_darkmode&sanitize=true" align=middle width=80.54869184999998pt height=21.68300969999999pt/> defines a pair of low-stakes and high-stakes test in the same cohort. The model is given by

<img src="/tex/3e0770d87fd75e9e8416800ba39a719c.svg?invert_in_darkmode&sanitize=true" align=middle width=186.84682169999996pt height=24.65753399999998pt/>,

and includes the transfer effect in the parameter <img src="/tex/c745b9b57c145ec5577b82542b2df546.svg?invert_in_darkmode&sanitize=true" align=middle width=10.57650494999999pt height=14.15524440000002pt/>. Again, measurement error was accounted for by a measurement model on <img src="/tex/439a07a0295ec9157cfaaeca943ab3fd.svg?invert_in_darkmode&sanitize=true" align=middle width=23.30877284999999pt height=14.15524440000002pt/><sup>2</sup>,

<img src="/tex/e1057fd31a2c66fb21610b72516467e7.svg?invert_in_darkmode&sanitize=true" align=middle width=169.82528969999998pt height=24.65753399999998pt/>.

Informative prior distributions for <img src="/tex/439a07a0295ec9157cfaaeca943ab3fd.svg?invert_in_darkmode&sanitize=true" align=middle width=23.30877284999999pt height=14.15524440000002pt/>, <img src="/tex/c745b9b57c145ec5577b82542b2df546.svg?invert_in_darkmode&sanitize=true" align=middle width=10.57650494999999pt height=14.15524440000002pt/>, and <img src="/tex/0fe1677705e987cac4f589ed600aa6b3.svg?invert_in_darkmode&sanitize=true" align=middle width=9.046852649999991pt height=14.15524440000002pt/> were used to regularize the posterior estimates:

<img src="/tex/ba015120db66bb94c2aeae261513378d.svg?invert_in_darkmode&sanitize=true" align=middle width=183.44591594999997pt height=24.65753399999998pt/>

<img src="/tex/a943850d78cfa8ae855f2dd5b6940409.svg?invert_in_darkmode&sanitize=true" align=middle width=135.27975615pt height=24.65753399999998pt/>

<img src="/tex/bd20d2a7ab29c72e77209f43d065dc06.svg?invert_in_darkmode&sanitize=true" align=middle width=133.75009229999998pt height=24.65753399999998pt/>

<sup>2</sup> A measurement model on <img src="/tex/8f952fb9309653919e9e2071f70b86a9.svg?invert_in_darkmode&sanitize=true" align=middle width=21.55108559999999pt height=14.15524440000002pt/> was omitted because the standard deviation of <img src="/tex/07617f9d8fe48b4a7b3f523d6730eef0.svg?invert_in_darkmode&sanitize=true" align=middle width=9.90492359999999pt height=14.15524440000002pt/> in step 2 was estimated to be low and to solve some identification issues due to few observations (reducing number of parameters).

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
