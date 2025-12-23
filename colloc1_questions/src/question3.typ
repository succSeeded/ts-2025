= Filtration problem. Deterministic methods of filtration: MA, SMA, EMA, polynomial smoothing

== Main methods of reduction to stationary time series (may be redundant)

There are two types of non-stationarity:

- Trend;

- Nonconsistent dispersion.

If there is a trend, we can use the following methods to standardize the time series:

1. Taking difference of time series:

$ y_i -> Delta y_i\, space Delta y_i = y_i - y_(i-1), space i = 2, ..., tau. $

2. Substracting the trend component:

#h(1.25cm) 2.1. TSD $->$ Trend $-> space y_i - "Trend"$;

#h(1.25cm) 2.2. Polynomial regression.

2.\* Lagged difference:
$
y_i -> Delta_k y_i, space Delta_k y_i = y_i - y_(i-k)
$
and adjust $k$ for seasonality.

2.\*\* Subtracting the seasonal component:
$
"TSD" => "Season" => y_i-"Season"
$
=== Dispersion stabilization

Box-cox transformation. Given $y = {y_1, ..., y_tau}, space y_i > 0$:
$
tilde(y)_i =& cases((y^lambda_i-1) / lambda\, space lambda != 0\,, log y_i\, space lambda = 0.)
$
*Note:* if $lambda > 1$ the inverse transform is taken, otherwise:
$
lambda = cases(
  1 => "no transformation;",
  0.5 => "square root, i.e. softer than log;",
  0 => "natural" space log.
)
$
The $lambda$ value is chosen using a maximum likelyhood function by applying Box-Cox for different $lambda$ values and choosing which maximizes the likelyhood of transformed data following a normal distribution. 

Normal distribution likelyhood function:
$ 
L = product_(i=1)^n 1 / sqrt(2 pi sigma^2) exp(- (z_i - mu)^2 / (2 sigma^2)).
$
Substituting $z_i=tilde(y)_i="Box-Cox"(y_i, lambda)$ we get:
$
L =& product_(i=1)^n 1 / sqrt(2 pi sigma^2) exp(- (tilde(y)_i - mu)^2 / (2 sigma^2)) times product_(i=1)^n y_i^(lambda - 1) \
log L =& - n / 2 log pi - n / 2 log sigma^2 - sum_(i=1)^n log(- (tilde(y)_i - mu)^2 / (2sigma^2)) +\
  +& (lambda - 1) sum_(i=1)^n log y_i.
$
Here, the term 
$
product_(i=1)^n y_i^(lambda - 1)
$ 
is derivative of Jacobian matrix of Box-Cox trnasform. Note that Box-Cox works only for positive $y_i$, hence if $y_i <= 0,$ the data is shifted by $alpha: y_i + alpha > 0, space i=1,...tau$ and the transform itself is applied after that.

When to apply Box-Cox:

1. Graphical test: plot variance against mean. Use Box-Cox if there is a clear dependance.

2. Distribution is asymmetric.

== Data filtration and smooting

Data filtration is *not* smooting. Rather smoothing is a tool used in data filtration. Filtration is time series transformation aimed at highlinghting, analyzing or supressing certain characterstics of time series such as noise or artifacts.

Goals of filtration:

- Trend extraction;

- Noise supression;

- Artifact removal;

- Time series decomposition.

A problem that may arise during filtration is finding a compromise between precision and smoothing.

=== Deterministic methods of filtration

1. SMA (moving average): 
$
"SMA"(y_t, m) = (y_(t-m)+y_(t-m+1)+...+y_(t+m)) / (2m+1).
$
Here the issue arises from last $m$ observations missing, hence in most scenarios the formula will look like this:
$ 
"SMA" (y_t, m) = (y_(t-m) + y_(t-m+1) + ... + y_t) / (m+1).
$

2. WMA (weighted moving average):
$
"WMA" = (sum w_i y_i) / (sum w_i).
$

3. EMA (exponential moving average). 

The idea of this method is to construct a recurrent formula so that the weights of previous points would decrease exponentially. It is given by the following expression:
$
"EMA"(y_t) = alpha y_t + (1 - alpha) "EMA"(y_(t-1)).
$
Here $alpha in (0, space 1)$ is a smooting parameter.

4. Polynomial (Savitzky-Golay) filter. 

Given data points, choose a window of size $n=2m+1$ and fit a polynomial line of a low degree then choose its value at $i$ as TS value at $i$. Algorithm step-by-step (at a fixed point $t$):

#h(1.25em) 1. Choose the window of size $n=2m+1$ and degree of polynomial $k$.

#h(1.25em) 2. Fit a polinomial $P(i) = alpha_0 + alpha_1 i + alpha_2 i^2 + ... + alpha_k i^k, space i = -m, dots, m$.

#h(1.25em) In matrix multiplication from: 
$
X alpha approx y.
$
#h(1.25em)Here,
$
X = mat(1, -m, (-m)^2, ..., (-m)^k; 1, -m+1, (-m+1)^2, ..., (-m+1)^k; dots.v, dots.v, dots.v, dots.down, dots.v; 1, m, m^2, ..., m^k).
$


#h(1.25em) 3. Coefficients $alpha_j$ can be obtained using least squares minimization:
$
sum_(i=-m)^m (P(i) - y_(t-i))^2 -> min_(alpha_j)\
$
#h(1.25em) its solution being $hat(alpha) = (X^T X)^(-1) X^T y$.

#h(1.25em) 4. $P(0) = hat(alpha)_0 ->$ smoothed value for current $y_t$. Since
$
hat(alpha)_0 = c_0^T hat(alpha) = c_0^T (X^T X)^(-1) X^T y, space c_0 = [1,0,...,0]^T,
$
#h(1.25em) designating $C = X (X^T X)^(-1) c_0$, the resulting expression is
$
hat(alpha)_0 = C^T y = c_(-m)y_(t-m) + ... + c_m y_(t+m).
$

*Downside.* Polynomials have to be fitted for each point.

How to deal with corner points:

1. Asymmetric window

2. Use polynomials calculated for the first and last full window.

