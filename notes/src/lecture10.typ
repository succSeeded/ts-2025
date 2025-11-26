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

= Topological dimension

Topological dimension is denoted as $d_T$. It has following properties:

1. $d_T (emptyset) = -1$, $d_T ("point")=0$, $d_T ("line") = 1$

2. Border between $A$ and $B$ is a closed set $Phi$ such that its complement is a union of such $C$ and $D$ that $C inter D = emptyset$, $A subset.eq C$ and $B subset.eq D$

3. Dimension of $X$ is equal to dimension of the border increased by 1.

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

1. ${x_1, dots, x_N} -> {y_1, dots, y_M}, space y_i = [x_i, x_(i+tau), dots, x_(i + tau dot (M - 1))]$. $x_i$ --- scalars, $y_i$ --- vectors, $y_i^((k))$ --- k-th value of $y_i$

2. Normalization $tilde(y)^((k))_i = (y_i^((k)) - min_j y^((k))_j) / (max_j y^((k))_j - min_j y^((k))_j)$.

3. $epsilon_l = epsilon_max dot q^l$.

4. Calculate $N(epsilon) = floor.l tilde(y)_i / epsilon_l floor.r$, $N(epsilon_l) = "unique"{epsilon_i}$.

Plotting $ln N(epsilon)$ against $ln 1 / epsilon$ we get that there is a line: $ln N(epsilon) = alpha + D_0 ln (1 / epsilon)$.

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

5. $C(r) <º)))>< gamma^(D_2) => ln C(r) = alpha + D_2 ln r$ (use only part of data that creates the line).

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

D.S. $x_(n+1) = f(x_n)$ and its measure $mu$. Split $A$ on $A_i$.

Denote the set of points mapped to $A_i$ by $f^k$ as $f^(-k) (A_i)$.

1. $A_i^((1)) = A_i$ --- just $A_i$

2. $A_(i_1 i_2)^((2)) = A_(i_1) inter f^(-1) (A_(i_2))$ --- all points from $A_(i_1)$ which were mapped to $A_(i_2)$ by $f$.

3. $A^((3))_(i_1 i_2 i_3) = A_(i_1) inter f^(-1) A_(i_2) inter f^(-2) A_(i_3)$ --- points from $A_(i_1)$ that were mapped to $A_(i_3)$ through $A_(i_2)$.

4. Repeat until $A^((k))_(i_1 dots i_k)$.

5. $H^((k)) = sum_(i_1, dots, i_k) mu (A_(i_1 i_2 dots i_k)) log mu (A_(i_1 dots i_k))$.

If $epsilon = max_i "diam" A_i$, then KS-entropy of D.S.:
$
"KS" (m) = lim_(epsilon -> 0) lim_(k -> infinity) (H^((k+1)) - H^((k))) = lim_(epsilon -> 0) lim_(k -> infinity) H^((k)) / k.
$
Then, if $"KS">0$ the time series is chaotic and if $"KS" = 0$ it is simple deterministic.

= Time series classification

= Restoring the equation of a dynamical system

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
