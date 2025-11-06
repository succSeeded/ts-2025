= Exponential smoothing, Holt’s linear model, ETS models

== Simple exponential smoothing

This model is given by
$
hat(y)_(t+1 | t) = alpha y_t + (1 + alpha) hat(y)_(t | t-1), 
$
where $hat(y)_(t+1 | t)$ is a forecast for $y_(t+1)$ and $alpha$ is smoothing parameter. Optimal $alpha$ is a solution to the following optimization problem:
$
sum_(i=0)^T (hat(y)_i (alpha) - y_i)^2 -> min_alpha.
$
It can be shown that the smoothed predicted value is equal to predicted value of $x$ at $T+1$ which solves the following problem:
$
sum_(t=0)^T beta^(T-1) (y_t - x)^2 -> min_x.
$
Taking the derivative we get that:
$
sum_(t=0)^T beta^(T-t) (y_t - x) = 0,
$
it follows that:
$
x =& (sum_(t=0)^T beta^(T-t) y_t) / (sum_(t=0)^T beta^(T - t)) = (sum_(t=0)^T beta^(T-t) y_t) / (1 / (1 - beta)) = \
=& (1 - beta) sum_(t=0)^T beta^(T - t) y_t = (1 - beta) y_T + (1 - beta) beta sum_(t=0)^(T-1) beta^(T-1-t) y_t =\
=& (1 - beta) y_T + beta hat(y)_(T | T-1).
$
Designating $alpha = 1 - beta$ we get the initial expression.

== Holt's linear trend model

Consider additive trend model:
$
hat(y)_(t+d | t^prime) = a_t + b_t dot d,
$
where level component $a_t$ and slope of the linear trend $b_t$ are given by
$
a_t =& alpha y_t + (1 - alpha)(a_(t-1) + b_t),\
b_t =& beta (a_t - a_(t+1)) + (1 - beta) b_(t-1).
$
*Intuition.* (very intuitive explanation ahead which is 100\% easy to understand) 

For 
$
d=0:& space hat(y)_(t | t+1) = a_(t+1),\
d=1:& space hat(y)_(t+1 | t) = a_t + b_t.
$
Note that since forecasts need to match, $a_(t+1) approx a_t + b_t$, hence $a_(t+1) - a_t approx b_t$.

Consider time series of differences $Delta y_t = a_(t+1) - a_t$ and a problem of constant forecasting ($Delta hat(y)_(t| t-1) = b$) using exponential smoothing model:
$
sum_(i=0)^t (1 - beta)^(t-i) (Delta y_i - b)^2 -> min_b. 
$
Substituting the differences in definition of $b_t$ gives the following result:
$
b_t = beta Delta y_t + (1 - beta) Delta hat(y)_(t | t-1).
$
Since $a_(t+1) approx a_t + b_t$, it follows that this is exponential smoothing for $y_t$ where forecasted value is $a_t + b_t$:
$
a_t = alpha y_t + (1 - alpha) hat(y)_(t | t-1) = alpha y_t + (1 - alpha) (a_(t-1) + b_(t-1)).
$
The resulting model is interpretable(bruh), but only for linear/exponential trends that lack a seasonal component. It is worth noting that this model is sensitive to outliers and assumes the trend to be constant.

== ETS models

ETS (error-trend-seasonality) models is a family of exponential smooting models which utilize time series decomposition and construct forecasts based on contributions of resulting components. Those components are:

- *Error.* Shows how random fluctuations affect the model. Error can be:
#h(1.25em) 1. A --- additive (i.e. independant from time series level)

#h(1.25em) 2. M --- multiplicative (i.e. scales with time series level).

- *Trend.* Designates the long-term direction of time series. There can be: 

#h(1.25em) 1. N --- no trend;

#h(1.25em) 2. A --- additive trend;

#h(1.25em) 3. M --- multiplicative trend;

#h(1.25em) 4. Ad, Md --- additive / multiplicative dampened trend.

- *Seasonality.* Designates periodical fluctuations in time series. This component could be:

#h(1.25em) 1. N --- no seasonality;

#h(1.25em) 2. A --- linear seasonality;

#h(1.25em) 3. M --- multiplicative seasonality.

*Advantages:*

1. Interpretable and intuitive;

2. Can be used for interval forecasting;

3. Stable and robust;

4. Fast.

*Disadvantages:*

1. Does not support inclusion of exogenous variables;

2. Very shaky assumptions which bar this family of models from many real-life scenarios.

