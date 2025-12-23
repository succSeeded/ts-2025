= Hurst exponent and how to calculate it

*Def. 1* The Hurst exponent is a quantitative measure of the persistance (long-term memory) of a time series.

It can be interpeted accodin to the following rule:

- $H > 0.5$ is characteristic for series with a persistent trend;

- $H = 0.5$ is characteristic for random series (i.e. those that lack persistent memory);

- $H < 0.5$ is characteristic for a persistent anti-trend (trend tends to reverse).

It can be calculated using multiple differenct algorithms, for example R / S algorithm.

== R / S algorithm

Consider a time series ${X_i}_(i=1)^N$.

1. Reconstruct the series into a set of embeddings of length $m$. Denote the size of embedding set itself as n.

2. For each embedding calculate the mean and standard deviation:
$
X_k = 1 / m sum_(i = 1)^m X_((k - 1)m + i), \
S_k = sqrt(1 / m sum_(i = 1)^m (X_((k-1)m + i) - X_k)^2).
$
3. Compute the normalized time series (i.e. cumulative sum of deviations from the mean):
$
Y_(k, i) = sum_(j=1)^i (X_((k-1)m + j) - X_k), i = 1, dots, m.
$
4. Compute the range for each embedding:
$
R_k = max_(1<=i<=m) Y_(k, i) - min_(1<=i<=m) Y_(k, i)
$
5. Normalize the ranges:
$
(R \/ S)_k = R_k / S_k, S_k != 0.
$
6. Average the ranges over all embeddings to get $R \/ S$ value for the selected $m$:
$
(R \/ S)^m = 1 / n sum_(i = 1)^n (R \/ S)_i .
$
7. Repeat the previous steps for various values of $m$, typically $10 <= m <= N / 2$ with logarithmic step.

8. Fit a linear regression on $(R \/ S)^m$ for various $m$:
$
log (R \/ S)^m = a + H dot log m + epsilon,
$
where $H$ is Hurst exponent.
