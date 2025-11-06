= Time series decomposition: TSD, STL

Typical TSD (time series decomposition) looks like:

$ y_t = T_t + S_t + R_t $

$T_t$ --- trend, $S_t$ --- seasonality component, $R_t$ --- random fluctuations, a.k.a. noise.

The decomposition can also take on the following forms:

$ y_t = T_t S_t R_t, " or " y_t = (T_t + S_t)R_t. $

== Classical TSD (using moving averages)

Moving average (MA) is given by the following expression:

$ "MA"(y_t; m) = 1 / m sum_(j=-k)^k y_(t+j), $

where $m = 2k+1$ is called _window size_ and has to be odd. Backward formula:
$
"MA"(y_t; m) = 1 / m sum_(j=-m)^0 y_(t+j),
$
Forward formula:
$
"MA"(y_t; m) = 1 / m sum_(j=0)^m y_(t+j).
$
For $m = 4$:
$
"MA"(y_t; 4) = 1 / 4 (y_(t-1), y_t, y_(t+1), y_(t+2)).
$
Moving average over moving average:
$
  "MA"("MA"(y_t, 4); 2) & = 1 / 2 ["MA"(y_(t-1);4), "MA"(y_t; 4)] = \
                        & = 1 / 2[ 1 / 4 (y_(t-2), y_(t-1), y_t, y_(t+1)) + 1 / 4(y_(t-1), y_t, y_(t+1), y_(t+2)) ] = \
                        & = 1 / 8 y_(t-2) + 1 / 4 y_(t-1) + 1 / 4 y_t + 1 / 4 y_(t+1) + 1 / 8 y_(t+2).
$
MAs are used to: 1) smooth out the data; 2) extranct the trend.

Weighted moving average (WMA):
$
"WMA"(y_t; m) = sum_(j=-k)^k y_(t+j) dot w_j, space w_j >= 0, space sum w_j = 1.
$
The classical TSD algorithm is given as follows:

1. Compute trend component using $2 times m$-MA if $m$ is even and $m$-MA if it is odd. 
$
hat(T)_t = cases("MA"(y_t; m)", if "m" is odd,", "MA"("MA"(y_t; m); 2)", if "m" is even.")
$
2. Detrend the time series (TS): 
$
y_t - hat(T)_t = S_t + R_t.
$
3. Compute $hat(S)_t$ by averaging detrended TS for a season (assuming that $S_t$ does not change from season to season).

4. $hat(R)_t = y_t - hat(S)_t - hat(T)_t.$

*Note:* TSD assumes that $S_t$ is constant throughout the seasons and that the trend line itself is not sensitive to sharp fluctuations. 

== STL decomposition

An alternative to classical TSD would be _STL decomposition_ (Seasonal Trend decomposition via LOESS). Here LOESS (locally estimated scatterplot smoothing) is type of local regression for modeling and smoothing data $(x_i, y_i)_(i=1)^m$. Its key components are:

1. Kernel function. For example, Gaussian kernel

$ w_i = exp (-(x_i - x)^2 / (2 tau^2)). $

2. Smoothing parameter $tau$. Smaller $tau$ leads to narrower windows and more flexible models, larger $tau$ --- to wider windows and less flexible models and $tau -> +infinity$ means that $w_i = 1$, hence model becomes a simple linear regression.

Given data $(x_i, y_i)^m_(t=1)$ or $(t, y_t)^T_(t=1)$, the LOESS algorithm step-by-step:

1. Choose a kernel function $cal(F)$ and set smoothing parameter $tau$.

2. For each $x$ in dataset:

#h(1.25em) 2.1. Calculate $w_i = cal(F)(x_i, x, tau)$

#h(1.25em) 2.2. Build weighted regression model. For example, weighted least squares: 
$
L = sum_(i=1)^n w_i (y_i - Theta^T x_i)^2,
$
#h(1.25em) where $Theta = (X^T W X)^(-1)X^T W y$.

#h(1.25em) 2.3. Make predictions $hat(y)(x)$ for $x$ only.

#h(1.25em) 2.4. "Forget" the model.

=== STL algorithm
  
*Input:* $Y = {y_1, ... , y_tau}$.

*Parameters:* $n_p$ --- \# of outer iterations (1-2)

#h(1.25cm) $n_i$ --- \# of inner iterations (1-2)

#h(1.25cm) $n_l$ --- trend smoothing parameter (smoothing parameter for LOESS)

#h(1.25cm) $n_s$ --- seasonality smoothing parameter

#h(1.25cm) $n_o$ --- residual smoothing parameter (optional, for residues $R_t$).

0. Outer loop: repeat the following steps $n_p$ times.

1. Initialization:

#h(1.25cm)1.1. set trend $T^((0)) = 0$ or other initial approximation (MA for example);

#h(1.25cm)1.2. set weights $w={1,1,...1}$ (optional, for residues).

2. Inner loop: repeat $n_i$ times

#h(1.25cm)2.1. Detrend time series: $D = Y - T$.

#h(1.25cm)2.2. Compute seasonal component:

#h(2.5cm)2.2.1. Split $D$ subseries by seasons;

#h(2.5cm)2.2.2. For each subseries apply the LOESS smoothing with $tau = n_s$ and weights $w$.

#h(2.5cm)2.2.3. Assemble the smoothed subseries into a seasonal component $C$.

#h(2.5cm)2.2.4. Center the seasonal component $C$ by subtracting moving average.

#h(1.25cm)2.3. Update seasonal component $S = C$.

#h(1.25cm)2.4. Deaseasonalize the data: $tilde(Y) = Y - S$

#h(1.25cm)2.5. Update the trend: apply LOESS for $tilde(Y)$ with $tau = n_l$ and "robust" weights $w$ (obtain $T$).

3. Compute the residuals $R = Y - T - S$.

4. Update weights: recompute weights $w$ based on residues $R$ to reduce the influence of outliers usually using Tuikey's biweight function.

*Post-processing:*

1. Normalize seasonality: mean value of $S$ for each season should be zero.

2. Smoothen the trend if needed.

*Result:* trend $T$, seasonality $S$, residual noise $R$

*Pros:*

- _flexiblity:_ it is robust to outliers;

- _robustness:_ it can model non-linear trends;

- _arbitrary period:_ it can work with any seasonality.

=== Tuikey's biweight function

Tuikey's biweight function is used to update the weights $w$ using the following algorithm:

1. Obtain the residuals $R = Y-S-T$

2. Compute MAD (median absolute deviation):

$ "MAD" = "median"(|r_i - "median"(R)|). $

Normalize: $S approx 1.4826 dot "MAD"$, since $sigma = 1.4826$ 

3. Compute the normalized residuals: 

$ u_i = r_i / (C dot S), $

where $C$ is a tuning constant ($C = 4.685$).

4. Bisquare function
$
w_i = cases((1-u_i)^2"," |u_i| < 1",", 0"," |u_i| >= 1.)
$
5. If $S = 0$, then $w_i = 0$ (all residuals are the same). If $"MAD" = 0$, but the residuals are not the same, we use standard deviation instead of MAD.

For example, if $R = [ 0.1, -0.2, 3.0, -0.1, 10.0 ]$:

1. $"median"(R) = 0.1$, hence $"MAD" = "median"(|R - 0.1|) = 0.3$

2. $S = 0.3 dot 1.4826 approx 0.4448$

3. $C = 4.685 => C dot S = 2.083$

4. $r_3 = 3.0: |u_3| = |3.0 / 2.083| approx 1.44 > 1 => w_3 = 0$ 

5. $r_5 = 10.0: |u_5| = 4.801 > 1 => w_5 = 0$

6. $r_1 = 0.1: |u_1| approx 0.04821 => w_1 = (1 - 0.048^2)^2 approx 0.995$

