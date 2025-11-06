= Weak, strong stationarity. Stationarity tests: DF, ADF, KPSS. Reduction to stationary time series

== Stationarity and Ergoticity

Stationarity is a key feature of time series. There are several kinds of stationarity:

- _Strict stationarity:_ joint distribution of any segment of time series $lr((y_(t_1), y_(t_2), ... , y_(t_k)))$ is equivalent to $lr((y_(t_1 + tau), y_(t_2 + tau), ... , y_(t_k + tau))) space forall tau$.

- _Weak stationarity:_

#h(1.25em) 1. $forall t space EE[y_t] = mu$,

#h(1.25em) 2. $forall t space DD[y_t] = sigma^2 < +infinity$,

#h(1.25em) 3. $forall t, s, tau space "cov"(y_t, y_s) = "cov"(y_(t+tau),y_(s+tau)) = gamma(|t-s|)$. Here $gamma(dot)$ is a function that depends on distance between points.

=== Non-stationary time series examples

1. Time servies with determinitstic trend:
$
y_t = alpha + beta t + epsilon_t, space epsilon_t ~ cal(N)(0, sigma^2).
$
Here, $EE[y_t] = alpha + beta t$ which is not a constant value.

2. $y_t = sin t + epsilon_t, space epsilon_t ~ cal(N)(0,sigma^2)$. Here

$ EE[y_t] = cases(1", "t=pi/2 + 2 pi k, -1", "t=- pi/2 + 2 pi k) $

and since it depends on $t$ the TS is non-stationary.

3. Random Walk: $y_t & = y_(t-1) + epsilon_t, space epsilon_t ~ cal(N)(0, sigma^2), space "cov"(epsilon_t, epsilon_s) = 0, space t != s$. Let us write out values of this TS:
$
  y_1 & = y_0 + epsilon_1, \
  y_2 & = y_1 + epsilon_2 = y_0 + epsilon_1 + epsilon_2, \
      & ... \
  y_t & = y_0 + sum_(i=1)^t epsilon_i
$
Therefore, $EE[y_t] = y_0\, space DD[y_t] = t sigma^2$.

=== Stationary time series examples

1. $y_t = epsilon_t, epsilon_t ~_"iid" cal(N)(0, sigma^2)$ -- white noise. In this case,

$ forall t, s: t != s, space EE[y_t] = 0, space DD[y_t] = sigma^2 < infinity -> "stationary" $

2. $y_t = beta_1 y_(t-1) + epsilon_t, space beta in (-1, 1), space epsilon_t ~_"iid" cal(N)(0, sigma^2)$
$
y_t =& beta_1 y_(t-1) + epsilon_t = beta_1 (beta_1 y_(t-2) + epsilon_(t-1)) + epsilon_t = \
    =& beta_1^t y_0 + sum_(i=1)^t beta_1^(t-i) epsilon_i.
$
Here, since $epsilon_i$ are independant from each other: 
$
EE[y_t] =& EE[beta_1^t y_0 + sum_(i=1)^t beta_1^(t-i) epsilon_i] = beta_1^t y_0 + sum_(i=1)^t beta_1^(t-i) EE[epsilon_i] =\
          =& beta_1^t y_0 space "if" space t -> infinity\, space beta_1^t -> 0. \
  DD[y_t] =& DD[beta_1^t y_0 + sum_(i=1)^t beta_1^(t-i) epsilon_i] = sum_(i=1)^t beta_1^(2(t-i)) DD[epsilon_i] =\
          =& (beta_1^(2t-2) + beta_1^(2t-4) + ... + 1) dot sigma^2 \
  "cov"(y_t, space y_(t+1)) =& "cov"(beta_1 y_(t-1) + epsilon_t, space beta_1 y_t + epsilon_(t_1)) \
          =& "cov"(beta_1^t y_0 + sum_(i=1)^t beta_1^(t-i) epsilon_i, space beta_1^(t+1) y_0 + sum_(i=1)^(t+1) beta_1^(t+1-i) epsilon_i) =\
          =& beta_1"cov"(epsilon_t, space epsilon_t) + beta_1^3"cov"(epsilon_(t-1), space epsilon_(t-1)) + ... + beta_1^(2t-1)"cov"(epsilon_1, space epsilon_1) =\
          =& sum_(i=1)^t beta_1^(2 i - 1) DD[epsilon_(t+1-i)] -> beta_1 / (1 - beta_1^2) dot sigma^2 = "const".
$

A random stochastic process is called _ergodic_ if its statistical properties can be estimated using a sample from it.

*Note:* any ergodic process is stationary and almost any stationary process is ergodic. 

== Stationarity tests

=== Unit root

Time series with unit root do not have a constant average level and have stochastic trends.

Let us consider a simple model: $y_t = phi dot y_(t-1) + epsilon_t, space epsilon_i ~^("iid") cal(N)(0, sigma^2), space phi$ is constant.

1. $|phi| < 1$ means that the process is stationary;

2. $|phi| > 1$ is a non-stationary or explosive time series;

3. $|phi| = 1$ is the unit root case, not stationary, since:
$
y_t = y_(t-1) + epsilon_t = y_0 + sum_(i=1)^n epsilon_i => DD[y_t] = t sigma^2.
$
*Why unit root?*

Let us define a lag operator $L y_t = y_(t-1)$. Then, $y_t = phi y_(t-1) + epsilon_t$ can be rewritten as $y_t = phi L y_t + epsilon_t$ hence $y_t (1 - phi L) = epsilon_t$.

Taking this into account, the characteristic equation would be
$
(1 - phi z) = 0 => z = 1 / phi
$ and if $phi = 1$ then $z = 1$ and $y_t = y_(t-1) + epsilon_t$.

=== Dickey-Fuller test (unit root test)

1. Consider a time series $y_t = phi y_(t-1) + epsilon_t$. Let $Delta y_t = y_t - y_(t-1)$, then:
  $ Delta y_t & = (phi - 1)y_(t-1) + epsilon_t = gamma y_(t-1) + epsilon_t. $

2. Formulate the hypotheses:
$
  H_0 & : gamma = 0 space (phi = 1) => "unit root" => "non-stationary time series."\
  H_1 & : gamma < 0 space (phi < 1) => "no unit root" => "stationary time series." 
$

3. Evaluate $gamma$ by fitting regression: $Delta y_t & = gamma y_(t-1) + epsilon_t$. Estimate standard t-statistic for $gamma$: 
$ t_"stat" & = hat(gamma) / ("SE"(hat(gamma))) $

4. Dickey-Fuller distribution.
#table(
  columns: (auto, auto),
  align: (center, center),
  table.header([*Significance level*], [*Critical value*]),
  $1%$, $-3.43$,
  $5%$, $-2.86$,
  $10%$, $-2.57$
)

5. If $t_("stat") < "crit. val." -> H_0 " is rejected,"$

If $t_("stat") >= "crit. val." -> H_0 " is not rejected."$

=== Modification of DF test

Basic regression is very simple model. Instead, it is often epxanded:
$
Delta y_t = alpha + beta t + gamma y_(t-1) + epsilon_t.
$
This model is able to perform stationarity checks around deterministic trends. 

=== Augmented Dickey-Fuller test

DF test assumes that $epsilon_t$ are not correlated. This issue can be solved by adding lagged differences to the regression. Those lagged differences will reduce autocorrelation in error terms $epsilon_t$.
$
Delta y_t = alpha + beta t + gamma y_(t-1) + sum_(i=1)^p delta_i Delta y_(t-i) 
$
How does the choice of $p$ impact the model:

- if $p$ is too small, then the correlation issue will not be solved,

- if $p$ is too big, the power of test decreases.

How to choose $p$:

1. $p approx root(3, T), space p approx sqrt(T)$.

2. Test different $p$, choose one that gives you the "best" regression: BIC, AIC, MQIC.

Interpretation of ADF is exactly the same.

=== KPSS (Kwiatkowski-Phillips-Schmidt-Shin) test

1. KPSS assumes that the time series can be decomposed into the following sum:
$
y_t = xi_t + r_t + epsilon_t,
$
where:

- $xi_t$ is deterministic trend,

- $r_t$ is stochastic trend such that $DD[r_t]=sigma_r^2$,

- $epsilon_t$ -- white noise.

2. $H_0$: time series is stationary $=> sigma_r^2 = 0 => y_t = xi_t + epsilon_t$,

$H_1$: time series is not stationary $=> sigma_r^2 > 0 => r_t != 0$.

3. Fit regression:

#h(1.25em) 3.1. $y_t = alpha + beta t + epsilon_t =>$ residuals $e_t = y_t - hat(alpha) - hat(beta) t$.

#h(1.25em) 3.2. Accumulation of residuals $S_t = sum_(i=1)^t e_i$.

#h(1.25em) 3.3. Calculate KPSS value:
$
"KPSS" = sum_(i=1)^T S_t^2 / (T^2 sigma_epsilon^2),
$
#h(1.25em) where $sigma_epsilon^2$ is the variance of $epsilon_t$ estimated using Newey-West method.

4. Decision logic: if $"KPSS" < "crit. value"$, reject $H_0$. Otherwise, $H_0$ is not rejected.


