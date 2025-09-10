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

= План курса

+ Введение во врем. ряды;

+ Фильтрация, сглаживание

+ Линейные модели: AR, MA, ARI MA

+ Нейросетевые подходы: П. и А. В.Р.

+ А. и П. хаотические временные ряды

+ Фрактальный анализ.

Оценка: $4 "лабы" times 0.6 + 2 "экзамена" times 0.4$

Time series is a sequence of measurements of certain quantity ordered in time. $y = {y_t}_(t=1)^T, y_t in R^n$.

Continuous time series examples:

1. Economic: GDP, consumer price index;

2. Financial time series;

3. Biological time series: ECG, heart rate.

= Time Series Decomposition (TSD)

Typical decomposiotion looks like:

$ y_t = T_t + S_t + R_t $

$T_t$ --- trend, $S_t$ --- seasonality component, $R_t$ --- random fluctuations.

The decomposition can also take on the following forms:

$ y_t = T_t S_t R_t, $
$ y_t = (T_t + S_t)R_t. $

Decomposition algorythms:

== I. Classical TSD (using moving averages).

$ "ma"(y_t; m) = 1 / m sum_(j=-k)^k y_t, m = 2k+1 $

The window size has to be odd. Backward formula:

$ "ma"(y_t; m) = 1 / m sum_(j=-m)^0 y_t, $

Forward formula:

$ "ma"(y_t; m) = 1 / m sum_(j=0)^m y_t. $

For $m = 4$:

$ "ma"(y_t; 4) = 1 / 4 (y_(t-1), y_t, y_(t+1), y_(t+2)) $

MA over MA:

$
  "ma"("ma"(y_t, 4); 2) & = 1 / 2 ["ma"(y_(t-1);4), "ma"(y_t; 4)] =                                                   \
                        & = 1 / 2[ 1 / 4 (y_(t-2), y_(t-1), y_t, y_(t+1)) + 1 / 4(y_(t-1), y_t, y_(t+1), y_(t+2)) ] = \
                        & = 1 / 8 y_(t-2) + 1 / 4 y_(t-1) + 1 / 4 y_t + 1 / 4 y_(t+1) + 1 / 8 y_(t+2). $

This is used to: 1) smoothen the data; 2) extranct the trend.

Weighted moving average (WMA):

$ "wma"(y_t; m) = sum_(j=-k)^k y_(t+j) dot w_j, w_j >= 0, sum w_j = 1. $

So, the classical TSD algorithm is given as follows:

1. Compute trend component using either MA over MA if m is even or WMA if m is odd. $ hat(T)_t = "ma"(y_t; m) "or" hat(T)_t = "ma"("ma"(y_t; m); m). $

2. Detrend the TS: $y_t - hat(T)_t = S_t + R_t$.

3. Compute $hat(S)_t$ by averaging detrended time series for a season.

4. $hat(R)_t = y_t - hat(S)_t - hat(T)_t$ assuming that S_t the same of each season.

== II. STL Decomposition (seasonal trend decomposition)

This algorithm realies on a technique called LOECS --- a type of local regression for modeling and smoothing data $(x_i, y_i)_(i=1)^m$. Its key components are:

1. Kernel funciton. For example, Gaussian kernel $w_i = exp (-(x_i - x)^2 / (2 tau^2))$.

2. Smoothing parameter $tau$. Smaller $tau$ leads to narrower windows, larger $tau$ --- to wider windows and $tau -> +infinity$ means that $w_i = 1$, hence leads to model becoming a simple linear regression.

Given data $(x_i, y_i)^m_(t=1)$ or $(t, y_t)^T_(t=1)$, the LOECS algorithm step-by-step:

1. Choose a kernel function $"kernel_fn"$ and $tau$.

2. For all $x_i$:

2.1. Calculate $w_i = "kernel_fn"(x_i, x, tau)$

2.2. Build weighted regression model. For example, weighted least squares: $L = sum_(i=1)^n w_i (y_i - Theta^T x_i)^2$, where $Theta = (X^T W X)^(-1)X^T W y$.

2.3. Make predictions $hat(y)(X)$ for X only.

2.4. "Forget" the model.

STL algorithm.

Input: $Y = {y_1, ... , y_tau}$.

Parameters: $n_p$ --- \# of outer iterations (1-2)

#h(1.25cm)$n_i$ --- \# of innter iterations (1-2)

#h(1.25cm)$n_l$ --- trend smoothing parameter (smoothing parameter for LOECS)

#h(1.25cm)$n_s$ --- seasonality smoothing parameter

#h(1.25cm)$n_o$ --- residual smoothing parameter (optional, for residues $R_t$).

Outer loop: repeat $n_p$ times.

1. Initialization:

  #h(1.25cm)1) set trend $T^((0)) = 0$ (initialize the approximation using MA for example);

  #h(1.25cm)2) set weights $w={1,1,...1}$ (optional, for residues).

2. Inner loop: repeat $n_i$ times

#h(1.25cm)2.1. Detrend time series: $D = Y - T$.

#h(1.25cm)2.2. Compute seasonal component:

#h(2.5cm)2.2.1. Split $D$ subseries by seasons;

#h(2.5cm)2.2.2. For each subseries apply the LOECS technique with $tau = n_l$ and weights $W$.

#h(2.5cm)2.2.3. Assemble the smoothed subseries into a seasonal component $C$.

#h(2.5cm)2.2.4. Compute this $C$.

#h(1.25cm)2.3. Update seasonal component $S = C$.

#h(1.25cm)2.4. Deaseasonalize the data: $Y_("deseasonalized") = Y - S$

#h(1.25cm)2.5. Update the trend: apply LOECS for $Y_("deseasonalized")$ with $tau = n_l$ and "robust" weights $w$ (obtain $T$).

3. Compute the residuals $R = Y - T - S$.

4. Update weights: recompute weights based on residues $R$ to reduce the influence of outliers. Usually we sue Tuikey's biweight function.

Post-processing:

1) Normalize seasonality;

2) Smoothen the trend.

Result: T, S, R

STL is:

#h(1.25cm)robust to outliers,

#h(1.25cm)can model non-linear trends,

#h(1.25cm)work with any seasonality.

How to update weights using Tuikey's biweight function?

1. Obtain the residuals $R = Y-S-T$

2. Compute median absolute deviation (MAD)

$ "MAD" = "median"(|R - "median"(R)|). $

Normalize: $s approx 1.4826$, s --- standard deviation(??????????)

3. Compute the normalized residuals: $u_i = R_i / (C dot S)$, where $C$ is a tuning constant ($C = 4.685$).

4. Bisquare function $w_i = cases((1-u_i)^2"," |u_i| < 1",", 0"," |u_i| >= 1.)$.

5. If $S = 0$, then $w_i = 0$ (all residuals are the same). If $"MAD" = 0$, but the residuals are not the same, we use STD instead of MAD.

For example, if $R = [ 0.1, -0.2, 3.0, -0.1, 10.0 ]$:

1. MAD: $"median"(R) = 0.1$, hence $"MAD" = "median"(|R - 0.1|) = 0.3$

whatever yada-yada...

= Stationarity and Ergoticity

_Stationarity_ is a key feature of time series. There are several kinds of stationarity:

_Strict stationarity_: joint distribution of any segment of time series $lr((y_(t_1), y_(t_2), ... , y_(t_k)))$ is equivalent to $lr((y_(t_1 + tau), y_(t_2 + tau), ... , y_(t_k + tau))) space forall tau$.

_Weak stationarity_: (erased)

Non-stationary time series:

1. Time servies with determinitstic trend:

$ y_t = alpha + beta t + epsilon_t, epsilon_t ~ N(0, sigma^2). $

Here, $FF[y_t^T] = alpha + beta t$.

2. (erased)

3. Random Walk:

$
  y_t & = y_(t-1) + epsilon_t, space epsilon_t ~ N(0, sigma^2), space "cov"(epsilon_t, epsilon_s) = 0, space t != s \
  y_1 & = y_0 + epsilon_1,                                                                                          \
  y_2 & = y_1 + epsilon_2 = y_0 + epsilon_1 + epsilon_2,                                                            \
      & ...                                                                                                         \
  y_t & = y_0 + sum_(i=1)^t epsilon_i $

So, $EE[y_t] = y_0\, space DD[y_t] = t sigma^2$.

Some examples:

1. $y_t = S_t, epsilon_t ~ "iid" N(0, sigma^2)$ -- white noise. In this case,

$ EE[y_t] = 0, space DD[y_t] = epsilon^2 < infinity -> "stationary", space "cov"(epsilon_t, epsilon_s) = 0 $

2.
  $ y_t & = beta y_(t-1) + epsilon_t, space beta in (-1, 1), space epsilon_t ~ "iid" N(0, sigma^2) \
        & "(erased)" $

1.
  $ EE[y_t] & = beta_1^t EE[y_0]+hat(beta)^(t-1)EE[epsilon_1]+...+EE[epsilon_t]    \
            & = beta_1^t y_0 space "if" space t -> infinity\, space beta_1^t -> 0. $

2.
  $
    DD[beta^t y_0 &+ beta^(t-1)epsilon_1+...+epsilon_t] =                                                                             \
                                                          & = beta^(2t-2)DD(epsilon_1) + beta^(2t-4)DD(epsilon_2)+...+DD[epsilon_t] = \
                                                          & = (beta^(2t-2) + beta^(2t-4) + ... + 1) sigma^2                           \
                                                          & "(erased)" $
3.
  $
    "cov" & (y_t, y_(t+1)) =                                                                                               \
          & = "cov"(beta^t y_0 + beta^(t-1)epsilon_1+...+epsilon_t, beta^(t+1)y_0 + beta^(t)epsilon_1+...+epsilon_(t+1)) = \
          & = beta "cov"(epsilon_t, epsilon_t) + beta^3 "cov"(epsilon_(t-1), epsilon_()) ... "(erased)" $

== Unit root

$ y_t = phi dot y_(t-1) + epsilon_t, space epsilon_i ~^("iid") N(0, sigma^2), space phi "is constant." $

1. $|phi| < 1$ means that the process is stationary;

2. $|phi| = 1$ is the unit root case, not stationary;

3. $|phi| > 1$ is a non-stationary or explosive time series.

*Why unit root?*

$ L y_t = y_(t-1), space y_t = phi L y_t + S_t -> (1 - phi L) "(erased)" $

If $(1 - phi z) = 0$, $z = 1 / phi = 1 -> phi = 1$

2. Dickey-Fuller test

#h(1.25cm) 1)
$
  y_t       & = phi y_(t-1) + epsilon_t                                   \
  y_t       & - y_(t-1) = phi y_(t-1) - y_(t-1) + epsilon_t               \
  Delta y_t & = (phi - 1)y_(t-1) + epsilon_t = gamma y_(t-1) + epsilon_t. $

#h(1.25cm) 2)
$
  H_0 & : gamma = 0 space (phi = 1) -> "unit root" -> "non-stationary time series." \
  H_1 & : gamma > 0 space (phi < 1) -> "no unit root" -> "stationary process."      \ $

#h(1.25cm) 3) Evaluate $gamma$ by fitting regression:

$
  Delta y_t & = gamma y_(t-1) + epsilon_t
  t_("stat") & = hat(gamma) / ("SE"(hat(gamma))) $

#h(1.25cm) 4) Distributed Dickey-Fuller:

#h(1.25cm) S.L. Crit.Val.

#h(1.25cm) 1% -3.43

#h(1.25cm) 5% -2.86

#h(1.25cm) 10% -2.57

#h(1.25cm) 5) If $t_("stat") < "crit. val." -> H_0 " is rejected,"$

#h(1.25cm) If $t_("stat") > "crit. val." -> H_0 " is not rejected."$

=== Modification

(erased)

1) $p approx root(3, T), space p !=(?) sqrt(T)$.

2) Test different $p$, choose $p$ which gives you the "best" regression: BIC, AIC, MQIC.

4. KPSStat

#h(1.25cm) 1) KPSS assumes that the time series is dependant on $y_t = xi_t + r_t + epsilon_t$, where $xi_t ...$ (FINISH LATER!!!!!!)
