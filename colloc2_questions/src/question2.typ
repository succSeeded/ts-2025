= Largest Lyapunov Exponent

*Def. 1* The largest (senior) Lyapunov exponent is a measure of the exponential speed at which trujectories diverge.

It can be calculated in the following manner:

1. Given a time series $Y = (y_1, dots, y_N)$, conduct a reconstruction $z_i = (y_i, dots, y_(i+m-1))$.

2. Select the nearset neighbours 
$
j_i = {j: epsilon_min < rho(z_i, z_j) < epsilon_max, |i - j| > epsilon_t}.
$
From the set of points satisfying these conditions $k$ are selected which will be denoted as $N_i = {z_(j_1), dots, z_(j_k)}$.

3. For each $z_i$ and each of its neighbours $z_j in N_i$ the evolution of distance between them over time is computed:
$
d_(i j) (k) = ||z_(i + tau) - z_(j + tau)||, space tau = 0, 1, dots, "max_time".
$
4. For each time lag $tau$ the average logarithmic divergence is calculated:
$
S (tau) = 1 / (M prime) sum_(i = 1)^(M prime) 1 / (|N_i|) sum_(z_j in N_i) ln d_(i j) (tau),
$
where $M prime$ is the number of points $z_i$ for which enough neighbourse are found, i.e. $|{i: |N_i| >= k}|$. This function represents the average log distance between trajectories after $tau$ steps.

5. The largest Lyapunov exponent can be exstimated as follows:
$
lambda_max = (S (tau_2) - S (tau_1)) / ((tau_2 - tau_1) Delta t),
$
where $[tau_1, tau_2]$ is the range of lags over which linear growth of S (tau) can be observed. However, in practice a linear estimation algorithm is ofter used:
$
S (tau) approx a + lambda_max dot tau Delta t.
$
