= Lyapunov Spectrum

== Local linear maps method

Assume that locally $Y_(i+1) approx A_i B_i + b_i$.

Let
$
mat(Y^T_(j_1 + 1); Y^T_(j_2+1); dots.v; Y^T_(j_k+1)) = mat(Y^T_(j_1), 1; Y^T_(j_2), 1; dots.v, dots.v; Y^T_(j_k), 1) times mat(A_i^T; b_(i)^T).
$

Step-by-step:

1. Reconstruction: ${x_i} -> {Y_i}$.

2. Search for the $k$ nearest neigbours.
$
N_i = {Y_(j_1), dots, Y_(j_k)}, space Y_(j_k) in {Y_j: space ||Y_i - Y_j|| < epsilon, |i - j| > epsilon_t}.
$
3. $forall Y_j in N_i: Y_(j + 1) approx A_i Y_j + b_i$. Then, minimize MSE:
$
sum_(Y_j in N_i) ||Y_(j+1) - A_i Y_j - b_i||^2 -> min_(A_i, b_i)
$
4. Form an orthonormal basis:

#h(1.25em) 4.1. Choose an initial point $Y_(i_0)$ on the trajectory.

#h(1.25em) 4.2. Initialize an orthonormal basis: $Q_0 = [q_1^0, q_2^0, dots, q_m^0], space Q_0^T Q_0 = I$.

#h(1.25em) 4.3. Initialize the accumulators for log stretching coefficients: 
$
L_j = 0, space j=1, dots, m.
$ 

5. Find $A_(i_n)$ for each $Y_(i_n)$ (see step 3) and apply it to the current basis:
$
V_(n+1) = A_(i_n) Q_n.
$
Then, every T steps (or as needed) use QR decomposition $V_(n+1) = Q_(n+1) R_(n+1)$ to get a new orthonormal basis $Q_(n+1)$, and an upper-triangular matrix $R_(n+1)$. 

6. Accumulate the exponents: $L_j = L_j + ln(R_(n+1))_(j j), j = 1, dots, m$. 

7. Go to the next point: $i_(n+1) = i_n + 1$.

7. Calculate the Lyapunov exponents:
$
lambda_j = L_j / (N_("iter") Delta t), space j = 1, dots, m.
$

Note that $A_i$ is a jacobian matrix of our dynamical system.

== Wolf method

Step-by-step:

1. Reconstruction ${x_i} -> {Y_i}$.

2. Initialization. Let $Y_0 = Y_i$, define an orthonormal basis for it: $q^0_1 = [1, 0, dots, 0]^T$, $q_2^0 = [0, 1, 0, dots, 0]^T, dots$

3. Take $Y_k$ and evolve it in time by ${q^k_1, q^k_2, dots, q^k_m}$, $Y_(k+1) = Y_(i+1)$, then $forall q_(i)$:
$
||Y_j - Y_k|| <& epsilon_max, |j - k| > epsilon_t \
delta = Y_j - Y_k:& alpha = arccos((delta dot q^k_i) / (||delta|| space ||q_i^(k)||)) < epsilon_min
$
4. $v_j = Y_(j+Delta) - Y_(k+Delta) => {v_1, v_2, dots, v_m}.$

5. For $j = overline(1\,dots\,m)$:

#h(1.25cm) for $j = 1$: $u_1 = v_1 / (||v_1||)$, $L_1^k = ln ||v_1||$

#h(1.25cm) for $j = 2$: $w_2 = v_2 - (v_2 dot u_1) u_1$, $u_2 = w_2 / (||w_2||)$. $L_2^k = ln ||w_2||$ and so on.

6. $q_1^(k+1) = u_1, dots, q_m^(k+1) = u_m$.

#h(1.25cm) for $j$: 
$
w_j =& v_j - sum_(i=1)^(j - 1) (v_j u_i) u_i \
u_j =& w_j / (||w_j||) \
L^k_j =& ln ||w_j||.
$
Then,
$
lambda_j = sum_(k=1)^("max_iter")L^k_(j k) / ("max_iter" dot Delta dot Delta t).
$

== How to choose the size of reconstruction

False nearest neigbours approach. For $m = m_min, dots, m_max$.

1. Sample $z_i$ -- vectors of size $m$.

2. Find the number of nearset neigbours:
$
"NN"_i = |{z_j: ||z_i - z_j|| < epsilon}|, space "NN" = sum_i "NN"_i
$

3. Sample $tilde(z)_i$ -- vectors of size $m+1$.

4. Find the number of false nearest neigbours:
$
"FNN"_i = |{tilde(z)_j : ||z_i - z_j|| < epsilon_1, ||tilde(z)_i - tilde(z)_j|| >= epsilon_2, |i - j| > tau}|
$
and $"FNN" = sum_i "FNN"_i$.

5. The optimal $m$ is the one that achieves the preset FNN to NN ratio (typically $1%$ to $5%$) first.
