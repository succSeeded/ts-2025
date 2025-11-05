= Time series forecasting problem. Multi-step ahead forecasting: two main approaches

== One-step-ahead forecasting

*Idea.* Predict one next value of time series (usually denoted as $t+1$) at a time using $w$ previous observations.

Given time series $Y = {y_1, dots, y_t}$ and lookback window $w$, find $f$ such that
$
hat(y)_(t+1) = f(y_t, y_(t-1), dots, y_(t-w+1)).
$
This task can be turned into an optimization problem by using a loss function, for example MAE, MSE, RMSE, MAPE or SMAPE.

== Multi-step-ahead forecasting

*Idea.* Predict multiple next values.

- *Recurrent approach.* Model learns how to make one-step-ahead forecasts adn then makes predictions multiple steps ahead by recursively applying one-step-ahead forecasting. This approach is easy to use and allows you to make predictions with any one-step-ahead model. However, since a model trained for one-step-ahead prediction is used recuresively, prediction errors add up the futher the prediction is.

- *Direct approach.* A separeate model is built for each step:
$
hat(y)_(t+1) =& f_1 (y_t, dots, y_(t-w+1)),\
hat(y)_(t+2) =& f_2 (y_t, dots, y_(t-w+1)),\
dots.v& \
hat(y)_(t+h) =& f_h (y_t, dots, y_(t-w+1)).
$
Or in vector form:
$
mat(hat(y)_(t+h); hat(y)_(t+h-1); dots.v; hat(y)_(t+1)) = f (y_t, dots, y_(t-w+1)).
$
This approach does not have error accumulation issue, however it also does not use information form previous forecasts and is more computationally complex.

== Real-life approach

1. Determine the target variable.

2. Take into account exogenous factors like the number of woring days in a month for demand forecastiong.

3. Decide whether to use deterministic or probabilistic forecasting.

== Model testing

1. Train-test split

2. Train-test-val split, where val is for hyperparameter tuning

3. Cross-validation.

