= Filtration problem. Deterministic methods of filtration: MA, SMA, EMA, polynomial smoothing.

== Main methods of reduction to stationary time series

There are tow types of non-stationarity:

1. Trend

2. Nonconsistent dispersion

If there is a trend, we can use the following methods to standardize the time series:

1. Taking difference of time series:

$ y_i -> Delta y_i\, space Delta y_i = y_i - y_(i-1), space i = 2, ..., tau. $

2. Substracting the trend component:

#h(1.25cm) 2.1. TSD $->$ Trend $-> space y_i - "Trend"$;

#h(1.25cm) 2.2. Polynomial regression.

2.\* Lagged difference:

$ y_i -> Delta_k y_i, space Delta_k y_i = y_i - y_(i-k) $

and adjust $k$ for seasonality.

2.\*\* Subtract the seasonal component:

$ "TSD" -> "Seasonal component" -> y_i-"Season" $

=== Dispersion stabilization.

1. Box-cox transformation. Given $y = {y_1, ..., y_tau}, space y_i > 0$:
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

== Autocorrelation and partial autocorrelation.

*ACF* _(AutoCorrelation Function)_ shows correlation of $y_t$ with lagged component of time series $y_(t-k)$ for different $k$'s. It is given by the following expression:
$
"ACF"(k) = rho(y_t, space y_(t-k)) = ("cov"(y_t, space y_(t-k))) / (sigma(y_t) sigma(y_(t-k))) approx (sum^T_(tau=k)(y_k-overline(y))(y_(t-k)-overline(y))) / (sum_(t=1)^T (y_t - overline(y))),
$
where $overline(y) = 1 / T sum_(t=1)^T y_t$ and $|"ACF"(k)| <= 1$.

ACF is used to identify:

1. *Trend.* Since trend is a long-term movement in a set direction, ACF will be positive and significant for long periods of time. 

2. *Memory of the process.* Memory of the process is extent of the effect that previous values have on new observations. Therefore, the rate and nature of autocorrelation attenuation can signify the type of process: if it is fast, i.e. there are drops, the process has short memory; if attenuation is slow, i.e. the changes are exponential, the process has long memory.   

3. *Seasonality.* Since seasonality is just oscillations at a fixed frequency, ACF plot will show spikes corresponding to seasonality period.

*PACF* _(Partial AutoCorrelation Function)_ shows correlation between $y_t$ and $y_(t-k)$ but removes the effect of all intermediate lags $(y_(t-1), y_(t-2), ..., y_(t-k+1))$.
$
"PACF"(k) = rho(y_t, space y_(t-k)| y_(t-1), ..., y_(t-k+1)).
$
PACF is calculated by fitting a regression
$
y_t = phi_k_1 y_(t-1) + phi_k_2 y_(t-2) + ... + phi_k_k y_(t-k) + epsilon_t
$
and then $phi_k_k = "PACF"(k)$. Here the terms $phi_k_1, dots, phi_k_(k-1)$ are responsible for removal of linear effect of intermediate lags. 

Linear models we may look up: AR($k$), MA($k$), ARMA($p, k$), ARIMA($k$).

== Data filtration and smooting

Data filtration is *not* smooting. Rather smoothing is a tool used in data filtration. Filtration is time series transformation aimed at highlinghting, analyzing or supressing certain characterstics of time series such as noise or artifacts.

Goals of filtration:

- Trend extraction;

- Noise supression;

- Artifact removal;

- Time series decomposition.

A problem that may arise during filtering is finding a compromise between precision and smoothing.

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

Given data points, choose a window of size $n=2m+1$ and fit a polynomial line of a low degree then choose its value at $i$ as TS value at $i$. Algorithm step-by-step (at point $i$):

#h(1.25em) 1. Choose the window of size $n=2m+1$.

#h(1.25em) 2. Fit a polinomial $P(i) = alpha_0 + alpha_1 i + alpha_2 i^2 + ... + alpha_k i^k, space i = -m, dots, m$.

#h(1.25em) 3. Least squares minimization:
$
sum_(i=-m)^m (P(i) - y_i)^2 -> min_(alpha_j)\
$
#h(1.25em) 4. $P(0) = hat(alpha)_0 ->$ smoothed value for current $y_t$.

*Downside:* polynomials fitted for each point, which is suboptimal.

$hat(alpha)_0$ can be expressed as weighted combination of all $y_i$ inside the window:

$ hat(alpha)_0 = c_(-m) y_(-m) + c_(-m+1) y_(-m+1) + ... + c_m y_m, $

where $c_j$ are coefficients of Savitzky-Golay filter, which depend on window size and degree of polynomial.

How to compute $c_j$:

1. $P(i) = alpha_0 + alpha_1 i + ... + alpha_k i^k$

2.
$
P(-m) =& alpha_0 + alpha_1 dot (-m) + ... + alpha_k dot (-m)^k approx y_(-m),\
...\
P(0) =& alpha_0,\
...\
P(m) =& alpha_0 + alpha_1 m + ... alpha_k m^k.
$

In matrix multiplication from: 
$
X alpha approx y.
$
Here,
$
X = mat(1, -m, (-m)^2, ..., (-m)^k; 1, -m+1, (-m+1)^2, ..., (-m+1)^k; ..., ..., ..., ..., ...; 1, m, m^2, ..., m^k)
$
and $alpha$ is target for linear regression 
$
||X alpha - y||^2 -> min_alpha.
$
Taking its solution we get $hat(alpha) = (X^T X)^(-1) X^T y$
$
hat(alpha)_0 =& c_0^T hat(alpha) = c_0^T (X^T X)^(-1) X^T y, space c_0 = [1,0,...,0]^T \
hat(alpha)_0 =& C^T y = c_(-m)y_(-m) + ... + c_m y_m.
$

How to deal with corner points:

1. Asymmetric window

2. Use polynomials calculated for the first and last full window.

Derivatives of the signal:
$
&P^prime (i) |_(i=0) = hat(alpha)_1,\
&P^(prime prime) (i) |_(i=0) = 2 hat(alpha)_2,\
&P^((n)) (i) |_(i=0) = n! hat(alpha)_n.
$

