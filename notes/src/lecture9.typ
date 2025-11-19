#set page(
  paper: "a4",
  numbering: "1",
)

#set text(
  size: 14pt,
)

#set par(
  justify: true,
)

#set math.cases(
  gap: 1em,
)

#set heading(numbering: "1. ")

#show heading.where(level: 1): it => { pagebreak(weak: true); it }

#show heading: set block(above: 1.5em, below: 1.0em)

= Numerical methods of Lyapunov coefficient calculation

$
d(t) =& d_0 e^(lambda_1 t) \
ln d(t) = & ln d_0 + lambda_1 t
$

Consider a dynamical system:
$
cases(dot(x) = f_1(x\, y)\,, dot(y) = f_2(x\, y))
$
A trajectory consisting of points that are stable by Lyaponov is is called an attractor.

A time series can be split into $z_i = [x_i, dots, x_(i+m-1)]$. This is a transition from time series to a dynamical system. It can be transitiioned forward by $Delta t$ and then be taking the last $z$-vector one can have a new time series.

== Rosenstein algorithm

Let $x_1, dots, x_n$ be a dataset, 
$
Y_i =& [x_i, x_(i+1), dots, x_(i+m-1)] \
Y_i =& [x_i, x_(i+tau), dots, x_(i + tau(m - 1))].
$
Step-by-step:

1. ${x_i} -> {Y_i}$.

2. Finding nearest neighbours. 
$
forall Y_i: space tilde(N)_i =& {Y_j|space epsilon_min < ||Y_i - Y_j|| < epsilon_max "and" |i - j| > epsilon_t}, \
$
3. Take $k$ nearest neigbours:
$
N_i =& {Y_(j_1), dots, Y_(j_k)}.
$
4. Calculate the distances after $k$ steps: $d_(i j) (k) = ||Y_(i+k) + Y_(j + k)||$ for each $k = overline(0\,dots\,T)$. 
5. Average those distances: 
$
S(k) = 1 / (M prime) sum_(i = 1)^(M prime) 1 / (|N_i|) sum_(Y_j in N_i) in d_(i j) (k),
$
Where $M prime$ is the number of $Y$-vectors used in computations (not all of them can be used).

6. Calculate Lyapunov exponent using linear regression:
$
S(k) approx alpha + lambda_i (k dot Delta t).
$

Hyperparameters: $m, tau, epsilon_min, epsilon_max, epsilon_t, k, T$. It is important to know that this algorithm is extremely sensitive to hypterparameter values.

== Kantz algorithm

This algorithm differs only in the way that data is averaged.

Step-by-step:

5. Average dataset:
$
S(k) = 1 / (M prime) sum_(i = 1)^(M prime) 1 / (|N_i|) sum_(Y_j in N_i) d_(i j) (k).
$
6. 
$
S(k) approx& S(0) e^(lambda_1 (k dot Delta t)) \
ln S(k) approx& ln S(0) + lambda_1 (k dot Delta t).
$

= Lyapunov spectre estimation

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
N_i = {Y_(j_1), dots, Y_(j_k)}, space Y_(j_k) in {Y_(j) | space ||Y_i - Y_j|| < epsilon "and" |i - j| > epsilon_t}.
$
3. $forall Y_j in N_i: Y_(j + 1) approx A_i Y_j + b_i$. Then, minimize MSE:
$
sum_(Y_j in N_i) ||Y_(j+1) - A_i Y_(j_1) - b_i|| -> min_(A_i, b_i)
$
4. Form an orthonormal basis. 

#h(1.25em) 4.1. $Y_(i_0)$

#h(1.25em) 4.2. $Q_0 = [q_1^0, q_2^0, dots, q_m^0], space Q_0^T Q_0 =I$.

#h(1.25em) 4.3. $L_j = 0, space j=1, dots, m$. 

5. Find $A_(i_n)$ for each $Y_(i_n)$ (see step 3)
$
V_(n+1) = A_(i_n) Q_n.
$
Then, use QR decomposition of $A_(i_n)$: $V_(n+1) = Q_(n+1) R_(n+1)$, where $Q_(n+1)$ is an orthonormal basis, $R_(n+1)$ is an upper triangular matrix. Then, $L_j = L_j + ln(R_(n+1))_(j i)$, $i_(n+1) = i_n + 1$.

6. Calculate the Lyapunov exponents:
$
lambda_j = L_j / (N_("iter") Delta t).
$

Note that $A_i$ is a jacobian matrix of our dynamical system.

== Wolf method

Step-by-step:

1. Reconstruction ${x_i} -> {Y_i}$.

2. Initialization. Let $Y_0 = Y_i$, define an orthonormal basis for it: $q^0_1 = [1, 0, dots, 0]^T$, $q_2^0 = [0, 1, 0, dots, 0]^T, dots$

3. Take $Y_k$ and evolve it in time by ${q^k_1, q^k_2, dots, q^k_m}$, $Y_(k+1) = Y_(i+1)$, then $forall q_(i)$:
$
||Y_j - Y_k|| <& epsilon_max \
|j - k| >& epsilon_t \
delta = Y_j -& Y_k: alpha = arccos((delta dot q^k_i) / (||delta|| space ||q_i^(k)||)) < epsilon_min
$
4. $v_j = Y_(j+Delta) - Y_(k+Delta) => {v_1, v_2, dots, v_m}.$

5. For $j = overline(1\,dots\,m)$:

for $j = 1$: $u_1 = v_1 / (||v_1||)$, $L_1^k = ln ||v_1||$

for $j = 2$: $w_2 = v_2 - (v_2 dot u_1) u_1$, $u_2 = w_2 / (||w_2||)$. $L_2^k = ln ||w_2||$ and so on.

6. $q_1^(k+1) = u_1, dots, q_m^(k+1) = u_m$.

for $j$: 
$
w_j =& v_j - sum_(i=1)^(j - 1) (v_j u_i) u_i \
u_j =& w_j / (||w_j||) \
L^k_j =& ln ||w_j||.
$

Them,
$
lambda_j = sum_(k=1)^("max_iter")L^k_(j k) / ("max_iter" dot Delta dot Delta t).
$

= Entropy-complexity plane

Blah-blah-blah.

= How to choose the size of reconstruction

False nearest neigbours approach. For $m = m_min, dots, m_max$.

1. Sample $z^m$ vectors of size $m$.

2. $"# of NN" = |{(z^m_i, z^m_j) | ||z_i^m - z_j^m|| < epsilon}| forall z^m_i, z^m_j$.

3. Sample $z^(m+1)$ -- vectors of size $m+1$.

4. 
$
"# of false NN" = |{(z_i^(m+1), z_j^(m+1)) |& ||z_i^m - z_j^m|| < epsilon, \
||z_i^(m+1) - z_j^(m+1)|| >& epsilon, |i - j| > tau}|, forall z^(m+1)_i, z^(m+1)_j.
$
FNN has a dip at the best $m$.
