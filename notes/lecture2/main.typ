#set page(
  paper: "a4",
  numbering: "1",
)

#set text(
  size: 16pt,
)

#set par(
  justify: true,
)

#set enum(numbering: "1.")

=== Main methods of reduction to stationary time series

#h(1.25cm) 1) Trend

#h(1.25cm) 2) Nonconsistent dispersion

1. Taking difference of time series:

$ y_i -> Delta y_i\, space Delta y_i = y_i - y_(i-1), space i = 2, ..., tau. $

2. Substract the trend component:

#h(1.25cm) 2.1. $"TSD" -> "Trend" -> y_i - "Trend"$;

#h(1.25cm) 2.2. Polynomial regression.

2.\* Lagged difference:

$ y_i -> Delta_k y_i, space Delta_k y_i = y_i - y_(i-k) $

and adjust the seasonality.

2.\*\* Subtract the seasonal component:

$ "TSD" -> "Seasonal component" -> y_i-"Season" $

=== Dispersion stabilization.

1. Box-cox transformation:

$
y={y_1, ..., y_tau}, space y_i > 0,\
tilde(y)_i = cases((y^lambda_i-1) / (lambda)\, space "if" lambda != 0\,, log y_i\, space "if" lambda = 0.) $

*Note:* $ lambda = cases(1 -> "no transformation;", 0.5 -> "square root, i.e. softer than log;", 0 -> log.) $

=== Using maximum likelyhood function.

Given a likelyhood function for $N$:

$ L = product_(i=1)^n 1 / sqrt(2 pi sigma^2) exp(- (z_i - mu)^2 / (2sigma^2)), $

$z_i=tilde(y)_i="Box-Cox"(y_i; lambda)$, hence

$
  L =     & product_(i=1)^n 1 / sqrt(2 pi sigma^2) exp(- (tilde(y)_i - mu)^2 / (2sigma^2)) product_(i=1)^n y_i^(lambda - 1) \
  log L = & l = - n / 2 log pi - n / 2 log sigma^2 - sum_(i=1)^n log(- (tilde(y)_i - mu)^2 / (2sigma^2)) +                  \
  +       & (lambda - 1) sum_(i=1)^n log y_i. $

If $delta y_i <= 0: space (y_i + alpha) > 0, space i=1,...tau$.

When to apply Box-Cox:

1. Graphical test: plot variance against mean. Use Box-Cox if there is a clear dependance.

2. Distribution is asymmetric (skewed idk).

= Autocorrelation and partial autocorrelation.

Autocorrelation function (ACF, denoted as $"ACF"(k)$) shows correlation of $y_i$ with log-ed component of time series $y_(t-k)$ for different $k$'s. It is given by the following expression:

$ "ACF"(k) = "corr"(y_t, y_(t-k)) = ("Cov"(y_t, y_(t-k))) / (sigma(y_t) sigma(y_(t-k))) approx (sum^T_(tau=k)(y_k-overline(y))(y_(t-k)-overline(y))) / (sum_(t=1)^T (y_t - overline(y))). $

1. Trend;

2. Menoly(???) of the process;

3. Seasonality.

In order to get rid of (...)'s influence partial autocorrelation function $"PACF"(k)$ is used. It shows correlation between $y_t$ and $y_(t-k)$ but removes the effect of all other internal(?) lags $(y_(t-1), y_(t-2), ..., y_(t-k+1))$.

$ "PACF"(k) = "Corr"(y_t, y_(t-k)| y_t, y_(t-1), ..., y_(t-k+1)). $

$"PACF"$ is calculated as follows:

1. Fit a regression:

$
  y_t =     & phi_k_1 y_(t-1) + phi_k_2 y_(t-2) + ... + phi_k_k y_(t-k) + epsilon_t \
  phi_k_k = & "PACF"(k) $

Linear models we may look up: $"AR"(k)\, space "MA"(k)\, space "ARMA"(p, k)$, $"ARIMA"(k)$.

= Data filtering and smooting

Data filtering is *not* smooting. Rather smoothing is a tool used in data filtering. Filtering is a timse series transformation aimed at highlinghting, analyzing or supressing certain characterstics (components) of time series.

Main goals of filtering:

#h(1.25cm) 1. Trend extraction;

#h(1.25cm) 2. Noise supression;

#h(1.25cm) 3. Artifact removal;

#h(1.25cm) 4. Time series decomposition.

A problem that may arise during filtering is finding a compromise between precision and smoothing.

*I. Determinate methods of filtration.*

1. $"SMA"(y_t; 2m+1) = (y_(t-m)+y_(t-m+1)+...+y_(t+m)) / (2m+1)$ --- central(?) mean. the problem with this one is that the last m observations are not really there. In order to takle this problem "left" and "right" variations of this formula are used:

$ "SMA"_"left?" (y_t\, m) = (y_(t-m) + y_(t-m+1) + ... + y_t) / (m+1). $

2. $"WMA" = (sum w_i y_i) / (sum w_i)$.

3. $"EMA"(y_t) = alpha y_t + (1 - alpha) "EMA"(y_(t-1))$.

Polynomial (Savitzky-Golay) filter

Given data points, choose a window of size $n=2m+1$ and fit a polynomial line of a low degree then choose its value at $i$ as TS value at $i$. Algorithm step-by-step (at point $i$):

1. Choose the window of size $n=2m+1$.

2. Fit a polinomial $P(i) = alpha_0 + alpha_1 i + alpha_2 i^2 + ... + alpha_k i^k$.

3. Least squares minimization:

$ sum_(i=-m)^m (P(i) - y_i)^2 -> min_(X_j) $

4. $P(0) = hat(alpha)_0 ->$ smoothed value for current $y_t$.

Downside: polynomials fitted for each point, which is suboptimal.

$hat(alpha)_0$ can be expressed as weighted combination of all $y_i$ inside the window:

$ hat(alpha)_0 = c_(-m) y_(-m) + c_(-m+1) y_(-m+1) + ... + c_m y_m, $

where $c_j$ are coefficients of Savitzky-Golay filter, which depend on window size and degree of polynomial.

How to compute $c_j$:

1. $P(i) = alpha_0 + alpha_1 i + ... + alpha_k i^k$

2.
  $
    P(-m) = & alpha_0 + alpha_1 dot (-m) + ... + alpha_k dot (-m)^k approx y_(-m)\, \
    ...                                                                             \
    P(0) =  & alpha_0,                                                              \
    ...                                                                             \
    P(m) =  & alpha_0 + alpha_1 m + ... alpha_k m^k. $

3.
  $ X alpha approx y, space X = mat(1, -m, (-m)^2, ..., (-m)^k; 1, -m+1, (-m+1)^2, ..., (-m+1)^k; ..., ..., ..., ..., ...; 1, m, m^2, ..., m^k), \
  space ||X alpha - y||^2 -> min_alpha $

$
  hat(alpha)_0 = & c_0^T hat(alpha) = c_0^T (X^T X)^(-1) X^T y, space c_0 = [1,0,...,0]^T \
  hat(alpha)_0 = & C^T y = c_(-m)y_(-m) + ... + c_m y_m $

How to deal with harder points:

1. Asymmetric window

2. Use polynomials calculated for the first and last full window.

= Fourier transform

Fourier series is a decomposition of a function $f in C[a, b]$ with a orthogonal function system $g_k(x)$ in some euclidean space:

$ f(x) = sum_(k=1)^infinity c_k g_k(x), space (f, g_k) = integral_a^b f(x) g_k (x) "dx" = 0 $

If $g_k (x)$ is a trigonometric system:

$ g_k in {1 / (2 l), 1 / sqrt(l) cos((pi x) / l), 1 / sqrt(l) sin((pi x) / l), ... } $

Then f(x):

$
  f(x) = & a_0 / 2 + sum_(k=1)^infinity [a_k cos((k pi x) / l) + b_k sin((k pi x) / l) ],         \
  a_k =  & 1 / l integral_(-l)^l f(x) cos((k pi x) / l) "dx"\,                                    \
  b_k =  & 1 / l integral_(-l)^l f(x) sin((k pi x) / l) "dx", space b_0 = 0, space b_(-k) = -b_k. $

In a more general case:

$ f(x) = sum_(k = -infinity)^(infinity) c_k e^(i w_k x), space w_k = (pi k) / l, space c_k = 1 / (2 l) integral_(-l)^l f(x) e^(-i w_k x) "dx" $

Since $sin(k x) = (e^(i k x) - e^(-i k x)) / (2 i), space cos(k x) = (e^(i k x) + e^(- i k x)) / 2$,

$
  f(x) = & e^(i w_0 x) dot (a_0) / 2 + sum_(k=1)^(infinity) [a_k (e^(i w_k x) + e^(-i w_k x)) / 2 + b_k (e^(i w_k x) - e^(-i w_k x) ) / (2 i) ] = \
  =      & a_0 / 2 e^(i w_0 x) + 1 / 2 sum_(k=1)^(infinity) [a_k e^(i w_k x) + a_k e^(-i w_k x) - i b_k e^(i w_k x) + i b_k e^(-i w_k x) ] =      \
  =      & a_0 / 2 e^(i w_0 x) + 1 / 2 sum_(k=1)^infinity (a_k - i b_k) e^(i w_k x) + 1 / 2 sum_(k=1)^infinity (a_k + i b_k) e^(-i w_k x) =       \
  =      & sum_(k=-infinity)^infinity c_k e^(i w_k x). $
