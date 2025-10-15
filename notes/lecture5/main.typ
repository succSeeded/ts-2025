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

= ARIMA model

#v(0.5em)

== I. AR model description

Model $"AR"(p)$ is given by a following expression

$ y_t = c + phi_1 y_(t-1) + phi_2 y_(t-2) + ... + phi_p y_(t-p) + epsilon_t, $

where:
- $y_t$ -- value of TS \@ time t;
- $C$ -- constant term to be determined;
- $phi_t$ -- parameters of the model;
- $epsilon_t$ -- model error term at time $t$, a.k.a. noise term.

Assumptions and limitations:

1. $EE(y_t)=0 space forall t$;
2. $"Var"(y_t) = "const" = sigma^2 space forall t$;
3. $"Cov"(epsilon_t, epsilon_s) = 0 space forall t != s$;
4. $epsilon_t ~ cal(N)(0, sigma^2)$

Key features:

1. Interpretability
2. $"AR"(p)$ can be applied to stationary TS;
2.1. Influence of previous values fades over time;
3. ACF: autocorrelation function decays over time;
4. PACF: partial autocorrelation function breaks off after lag $p$, hence it can be used to find optimal $p$.

== Training AR model

1. OLS

$ sum_t epsilon_t^2 = sum_t (y_t - c - phi_1 y_(t-1) - ... - phi_p y_(t-p)) -> min_(c, phi_i) $

2. MLE

Given that $Y = (y_1, ..., y_n)$:

$ L(theta | y) approx& product_(t=p+1)^n f(y_t | y_(t-1), ..., y_(t-p), theta). $

Considering that $y_t|y_(t-1), ..., y_(t-p) ~ cal(N)(c + sum_(i=1)^p phi_i y_(t-i), sigma^2)$,

$ L(theta | y) = product_(i=p+1)^n 1/(sigma sqrt(2 pi)) exp(- 1 / 2 (y_t - c - sum_(i=1)^p phi_i y_(t-i))^2) -> max_theta. $

== II. MA(q) model description

$ y_t = mu + epsilon_t + theta_1 epsilon_(t-1) + ... + theta_q epsilon_q $

where:

- $theta_i$ -- model parameters;
- $epsilon_i$ -- time series error terms at time $i$;
- $mu$ -- configurable constant term;

Key features:

1. Interpretability;
2. Always stationary;
3. ACF: breaks off after lag $q$, hence used to determine the optimal $q$ value;
4. PACF: decays gradually;

== Training MA model

Let us assume that $epsilon_i=0, space i=0,...,q+1$. Then

1. Conditional LS. Denoting $theta = {theta_1, ..., theta_q}$ we get the following:

$ sum_(t=1)^n epsilon^2_t = sum_t (y_t - mu - sum_(i=1)^q epsilon_(t-i) theta_i) -> min_(mu, theta) $

2. MLE. Denoting $Y = (y_1, ..., y_n)$, we get

$ L(theta | y) approx product_(t=p+1)^n f(y_t | epsilon_(t-1), ..., epsilon_(t-q), theta) $

== ARMA(p, q) model description

$ y_t = c + phi_1 y_(t-1) + ... + phi_p y_(t-p) + epsilon_t + theta_1 epsilon_(t-1) + ... + theta_q epsilon_(t-q) $

here $p$ is defined as the first zero of PACF and $q$ as the first zero of ACF

== ARIMA(p, q, d) model desciption

ARIMA is an ARMA model fit to $Delta^d y_t$:

$ 
Delta y_t =& y_t - y_(t-1) = (1 - L) y_t, space L y_t = y_(t-1) \
Delta^2 y_t =& Delta(y_t - y_(t-1)) = y_t - 2 y_(t-1) + y_(t-2) = (1 - L)^2 y_t \
Delta^d y_t =& (1 - L)^d y_t.
$

Thus:

$ 
y_t =& c + phi_1 y_(t-1) + ... + phi_p y_(t-p) + epsilon_t + theta_1 epsilon_(t-1) + ... + theta_q epsilon_(t-q) \ 
(1 -& phi_1 L - ... - phi_p L^p)y_t = epsilon_t + theta_1 epsilon_(t-1) + ... + theta_q epsilon_(t-q) \ 
(1 -& sum_(i=1)^p phi_i L^i) Delta^d y_t = c + epsilon_t + sum_(i=1)^q theta_i epsilon_(t-i) \
(1 -& sum_(i=1)^p phi_i L^i) (1 - L)^d y_t = c + epsilon_t + sum_(i=1)^q theta_i epsilon_(t-i)
$

== ARIMA model usage

Training:

1. $Y = (y_1, ..., y_n)$
2. Find $z_j^((m))$ terms (todo: find out how they are called)

$ z_j^((m)) = [y_(j - m + 1), ..., y_(j-1), y_j] -> Z^m = mat(z^((m))_m; z^((m))_(m+1); dots.v; z^((m))_n), Z^m in RR^(n-m times m). $

Inference:

3. $z^((m))_(n+1) =& [y_(n-m+2), ..., y_n, hat(y)_(n+1)] \ tilde(z)_(n+1)^((m)) =& z_(n+1)^((m))[:-1] = [y_(n-m+2), ..., y_n]$

4. Collect a set of possible predictions:

$ S_(n+1) = {z_i^((m))[m] | \|\|tilde(z)_(i)^((m)) - tilde(z)_(n+1)\|\| < epsilon}. $

5. Choose single prediction:
- $hat(y)_(n+1) = "mean"(S_(n+1))$
- $hat(y)_(n+1) = "mode"(S_(n+1))$
- $"Cusler"(S_(n+1)) ->^("cluster") {C_1, ..., C_k}$
$hat(y)_(n+1) = "mean"(C_i), space i = "argmax"_j|C_j|$.

Multistep ahead prediction: $tilde(z)_(n+2)^((m)) = [y_(n-m+3),...,y_n, hat(y)_(n+1)]$.

2\*. $Z^m ->^("cluster") C_1, ..., C_k "clusters of " z^((m)) " vectors"$

$ X^m = mat(xi_1^((m)); dots.v; xi_k^((m))), space xi_i = "\"central element\"" $

3\*. $tilde(z)^((m))_(n+1) = [y_(n-m+2), ..., y_n]$

4\*. $S_n = {xi_i^((m))[m]| \|\|tilde(xi)^((m))_i - tilde(z)^((m))_(n+1)\|\| < epsilon}$

Let us modify the algorithm:

1. $Y = (y_1, ..., y_n)$

2. Given $K, L:$ generate patterns (rus. _шаблоны_). For example:
$ K=10, L = 4: space A = mat(1,1,1,1; 1,1,1,2; dots.v, dots.v, dots.v, dots.v; 10,10,10,10) $
$ z_i^((10,10,10,10))=[y_(i-40), ..., y_(i-10), y_i] $
Note that in this example $A$ can have only elements with values from 1 to 10.

3. $forall alpha in A: alpha=(K_1, ..., K_L), K_i in overline(1\,..\,K)$
$ z^(\*)_i = [y_(i-K_L-K_(L-1)-...K_1), ..., y_(i-K_L-K_(L-1)), y_(i-K_L), y_i] $
Generate $Z^(alpha) = mat(z^alpha_(K_(m-K_L));z^alpha_(K_(m-K_(L+1)));dots.v;z^alpha_n) space forall alpha in A$

4. $forall alpha in A:$

$ tilde(z)^alpha_(n+1) = [y_(n+1-K_L-K_(L-1) - ...), ..., y_(n + 1 - K_L)] $

5. $forall alpha in A$

$
S^alpha_(n+1) =& {z^alpha_i [i+1] | \|\|tilde(z)_i^alpha - tilde(z)_(n+1)^alpha\|\|} \
S_(n+1) =& union_alpha S^alpha_(n+1)
$

6. Classify point the point as predictable or not prediactable.

6.1 Cluster $S_(n+1) -> C_1, ..., C_l, C_0$, where $C_0$ is a noise cluster and $C_i, space i=overline(1\,..\,l)$ are sorted by size from largest ($C_1$) to smallest ($C_l$).

$
eta_1 =& (\|C_1\|) / (\|C_2\|) >> 1 -> "goto 6.2" \
eta_2 =& (\|C_1\|) / (sum_(i=1)^l\|C_i\|) > epsilon_1 -> "goto 6.2"
$

6.2 Estimate the variance of cluster $C_1$. If $"Var"(C_1) < epsilon_1 -> "goto 7"$, if $"IQR"(C_1) < epsilon_2 -> "goto 7"$

6.3 Identify the point as non-predictable and nove to the next point.

7. Obtain single prediction.

example on the photo (what do we do if a value is skipped) 

= Self-healing algorithms

1. Forecast $h$ steps ahead.

2. Run self-healing unill convergence or max iteration is reached.

3. Move to step 1.
