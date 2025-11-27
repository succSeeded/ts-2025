= Autocorrelation and partial autocorrelation. AR, MA, ARMA, ARIMA models.

== Autocorrelation and partial autocorrelation

*ACF* _(AutoCorrelation Function)_ shows correlation of $y_t$ with lagged component of time series $y_(t-k)$ for different $k$'s. It is given by the following expression:
$
"ACF"(k) = rho(y_t, space y_(t-k)) = ("cov"(y_t, space y_(t-k))) / sqrt(sigma(y_t) sigma(y_(t-k))) approx (sum^T_(tau=k)(y_k-overline(y))(y_(t-k)-overline(y))) / (sum_(t=1)^T (y_t - overline(y))),
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
y_t = phi_1 y_(t-1) + phi_2 y_(t-2) + ... + phi_k y_(t-k) + epsilon_t
$
and then $phi_k = "PACF"(k)$. Here the terms $phi_1, dots, phi_(k-1)$ are responsible for removal of linear effect of intermediate lags. 

== AR model description

Model $"AR"(p)$ is given by a following expression
$
y_t = c + phi_1 y_(t-1) + phi_2 y_(t-2) + ... + phi_p y_(t-p) + epsilon_t,
$
where:
- $y_t$ --- value of TS \@ time t;
- $c$ --- constant term to be determined;
- $phi_t$ --- parameters of the model;
- $epsilon_t$ --- model error term at time $t$, a.k.a. noise term.

Assumptions and limitations:

1. $EE(epsilon_t)=0 space forall t$;
2. $DD(epsilon_t) = "const" = sigma^2 space forall t$;
3. $"cov"(epsilon_t, space epsilon_s) = 0 space forall t != s$;
4. $epsilon_t ~ cal(N)(0, sigma^2)$.

Key features:

1. Interpretability.

2. $"AR"(p)$ can be applied only to stationary TS. This guarantiees that the influence of previous values fades over time, since otherwise the series will be explosive and model would not be suitable for forecasting. 

3. ACF: decays over time.

4. PACF: breaks off after lag $p$, hence it can be used to find optimal $p$.

=== Training AR model

1. OLS
$
sum_t epsilon_t^2 = sum_t (y_t - c - phi_1 y_(t-1) - dots - phi_p y_(t-p))^2 -> min_(c, phi_i)
$
2. MLE

Given that $Y = (y_1, ..., y_n)$:
$
L(theta | y) approx& product_(t=p+1)^n f(y_t | y_(t-1), ..., y_(t-p), theta).
$
Considering that $y_t|y_(t-1), ..., y_(t-p) ~ cal(N)(c + sum_(i=1)^p phi_i y_(t-i), sigma^2)$,
$
L(theta | y) = product_(t=p+1)^n 1/(sigma sqrt(2 pi)) exp(- 1 / 2 ((y_t - c - sum_(i=1)^p phi_i y_(t-i)) / sigma)^2) -> max_theta,
$
where $theta = {c, phi_1, dots, phi_p}$.

== MA model description
$
y_t = mu + epsilon_t + theta_1 epsilon_(t-1) + ... + theta_q epsilon_q
$
where:

- $theta_i$ --- model parameters;
- $epsilon_i$ --- time series error term at time $i$;
- $mu$ --- configurable constant term.

This model has same assumptions as AR.

Key features:

1. Interpretability.
2. Always stationary.
3. ACF: breaks off after lag $q$, hence used to determine the optimal $q$ value.
4. PACF: decays gradually.

=== Training MA model

Let us assume that $epsilon_i=0, space i=0,...,q+1$. Then

1. Conditional LS. Denoting $theta = {theta_1, ..., theta_q}$ we get the following:
$
sum_(t=1)^n epsilon^2_t = sum_t (y_t - mu - sum_(i=1)^q epsilon_(t-i) theta_i) -> min_(mu, theta)
$
2. MLE. Denoting $Y = (y_1, ..., y_n)$, we get
$
L(theta | y) approx product_(t=1)^n f(y_t | epsilon_(t-1), ..., epsilon_(t-q), theta).
$
and since $y_t | epsilon_(t-1), dots, epsilon_(t-q), theta ~ cal(N)(mu + sum_(i=1)^q theta_i epsilon_i, sigma^2)$, the optimization problem can be formulated in the following manner:
$
log L(theta | y) = -1 / 2 n log (2 pi) - 1 / 2 log sigma^2 - 1 / 2 sum_(t=1)^n (y_t - mu - sum_(i=1)^q theta_i epsilon_(t-i))^2 / sigma^2 -> max_(theta). 
$

== ARMA model description

$
y_t = c + phi_1 y_(t-1) + ... + phi_p y_(t-p) + epsilon_t + theta_1 epsilon_(t-1) + ... + theta_q epsilon_(t-q)
$
here $p$ is defined as the first zero of PACF and $q$ as the first zero of ACF.

== ARIMA model desciption

Denote
$
Delta y_t =& y_t - y_(t-1) = (1 - L) y_t, space L y_t = y_(t-1) \
Delta^2 y_t =& Delta (y_t - y_(t-1)) = y_t - 2 y_(t-1) + y_(t-2) = (1 - L)^2 y_t \
Delta^d y_t =& (1 - L)^d y_t.
$
Taking an ARMA model:
$ 
y_t =& c + phi_1 y_(t-1) + ... + phi_p y_(t-p) + epsilon_t + theta_1 epsilon_(t-1) + ... + theta_q epsilon_(t-q) \ 
(1 -& phi_1 L - ... - phi_p L^p)y_t = c + (1 + theta_1 L + ... + theta_q L^q)epsilon_t
$
and applying it to $Delta^d y_t$ results in the following model:  
$
(1 -& sum_(i=1)^p phi_i L^i) Delta^d y_t = c + (1 + sum_(i=1)^q theta_i L^i) epsilon_t \
(1 -& sum_(i=1)^p phi_i L^i) (1 - L)^d y_t = c + (1 + sum_(i=1)^q theta_i L^i) epsilon_t. 
$
Which is called $"ARIMA"(p, q, d)$.
