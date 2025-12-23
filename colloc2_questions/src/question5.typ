= Fractal and topological dimensions. Fractal dimension approximations

== Topological dimension

Topological dimension is denoted as $d_T$. Topological dimensions of several objects: $d_T (emptyset) = -1$, $d_T ("point") = 0$, $d_T ("line") = 1$.

Consider a set $A$. Split it into subsets $A_i, "diam" A_i < epsilon$. Let
$
m(epsilon, p) =& inf_({A_i}) sum_i ("diam"A_i)^p, \
d_M =& sup_p {p | sup_(epsilon > 0) m(epsilon, p) > 0}. 
$
Note that if $d_M > d_T$ $A$ is a fractal. 

Let $N(epsilon)$ be the number of non-empty cubes with $"diam" = epsilon$. Then, capacity is given by
$
D_0 = lim_(epsilon -> 0) (ln N(epsilon)) / (ln (1 / epsilon)).
$

== Fractal dimension estimation

1. ${x_1, dots, x_N} -> {y_1, dots, y_M}, space y_i = [x_i, x_(i+tau), dots, x_(i + tau dot (m - 1))]$. $x_i$ --- scalars, $y_i$ --- vectors, $y_i^((k))$ --- k-th value of $y_i$

2. Normalization:
$
tilde(y)^((k))_i = (y_i^((k)) - min_j y^((k))_j) / (max_j y^((k))_j - min_j y^((k))_j),
$
which results in all coordinates lying within unit hypercube $[0, 1]^m$.

3. Choose a sequence of box sizes 
$
epsilon_l = epsilon_max dot q^l, space l = 0, 1, dots, L,
$
where $q in (0, 1)$, $L$ is such that $epsilon_min << 1$ and $N(epsilon_min) >> 1$.

4. Calculating $N(epsilon)$. For each box size $epsilon_l$ the entire unit cube is partitioned into non-overlapping hypercubes with side length $epsilon_l$ giving $K = ceil.l 1 / epsilon_l ceil.r$ boxes along each dimension. For each point $y_i$ the indices of the box containing it are computed:  
$
"Index"_k = floor.l y_(i, k) / epsilon_l floor.r, space k = 1, dots, m.
$
Unique sets of indices are markes as occupied boxes, $N(epsilon)$ is the number of such boxes containing at least one point of hte attractor.

Plotting $ln N(epsilon)$ against $ln 1 / epsilon$ we get a line: $ln N(epsilon) = alpha + D_0 ln (1 / epsilon)$.

== Correlation dimension
$
D_2 = lim_(r -> 0) (ln C(r)) / (ln r),
$
where $C(r)$ is correlation integral.

Consider a set fo points in $m$-dimensional phase space ${y_i}_(i=1)^M$, then:
$
C(r) = 2 / (M (M-1)) sum_(i=1)^M sum_(j = i + 1)^M theta (r - ||y_i - y_j||),
$
where $theta(x)$ is a Heaviside function. Generally,
$
C(r) = integral mu (B (x, r)) d mu(x)
$
where $B(x, r)$ is ball of radius $r$ with center at $x$ and $mu$ is a metric function.

1. Reconstruction $x_i -> y_i$.

2. Define a grid for $r$ (usually as geometric progression).

3. $d_(i j) = ||y_i - y_j||$

4. $C(r) = 2 / (M (M-1)) sum_(i=1)^M sum_(j = i + 1)^M theta (r - d_(i j))$.

5. $C(r) prop r^(D_2) => ln C(r) = alpha + D_2 dot ln r$ (use only part of data that creates the line).

$
H_q =& 1 / (1 - q) log (sum_i p_i^q), \
H_q (epsilon) =& alpha + D_(epsilon) log 1 / epsilon, \
D_q =& lim_(q -> infinity) (H_q (epsilon)) / (log 1 / epsilon).
$

== Lyapunov dimension
$
D_L = k + (log (lambda_1 lambda_2 dots lambda_k)) / (log (lambda_(k+1))),
$
where $k$ is the largest integer such that $lambda_1, dots, lambda_k >= 1$.

== Restoring the equation of a dynamical system

Consider a system
$
cases(dot(x) = sigma (y - x), dot(y) = x (rho - z) - y, dot(z) = x y - beta z)
$
where $x = x(t), space y = y(t), space z = z(t)$.

1. Take a matrix
$
Theta = mat(dots.v, dots.v, dots.v, dots.v, dots.v, dots.v, dots.v, ; 1, x, y, z, x^2, y^2, x y, dots; dots.v, dots.v, dots.v, dots.v, dots.v, dots.v, dots.v, )
$
2. Take $Xi$
$
Xi = mat(dots.v, dots.v, dots.v; xi_1, xi_2, xi_3; dots.v, dots.v, dots.v)
$
such that $[dot(x), dot(y), dot(z)] = Theta times Xi$ is equivalent to the initial system, or
$
hat(y) = X dot Theta, space ||hat(y) - y|| -> min_Theta. \
||dot(Y) - hat(dot(Y))|| + alpha dot ||Xi||_1 -> min
$
where $alpha dot ||Xi||_1$ is $l_1$ regularization term (generally with a sizable $alpha$ value).

Take an autoencoder, where $Psi$ is the encoder, $Phi$ is the decoder, $x$ is the input, $x prime$ is the output and $z$ is the latent space value.
$
dot(z) = Theta times Xi = mat(dots.v, dots.v, dots.v, ; 1, z, z^2, z^3, dots; dots.v, dots.v, dots.v, ).
$
where $z$ is a latent variable / space / idk. Then, the loss would be:
$
cal(L) =& alpha_1 ||x prime - x|| + alpha_2 ||hat(dot(z)) - dot(z)|| + alpha_3||Xi||_1 -> min_(Xi, Psi, Phi).
$
