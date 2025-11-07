= Predictive clustering

== Basic algorithm

1. $Y = (y_1, ..., y_n)$
2. Find $z_j^((m))$ terms
$ 
z_j^((m)) = [y_(j - m + 1), ..., y_(j-1), y_j] => Z^m = mat(z^((m))_m; z^((m))_(m+1); dots.v; z^((m))_n), Z^m in RR^(n-m times m).
$
Inference:

3. $z^((m))_(n+1) =& [y_(n-m+2), ..., y_n, hat(y)_(n+1)] \ tilde(z)_(n+1)^((m)) =& z_(n+1)^((m))[:-1] = [y_(n-m+2), ..., y_n]$

4. Collect a set of possible predictions:
$
S_(n+1) = {z_i^((m))[m] | ||tilde(z)_(i)^((m)) - tilde(z)_(n+1)|| < epsilon}.
$
5. Choose single prediction:
- $hat(y)_(n+1) = "mean"(S_(n+1))$
- $hat(y)_(n+1) = "mode"(S_(n+1))$
- $"Cluster"(S_(n+1)) -> {C_1, ..., C_k}$, then $hat(y)_(n+1) = "mean"(C_i), space i = "argmax"_j|C_j|$.

This algorithm can be modified to use cluster centroids for predictions:

2\*. $Z^m ->^("cluster") C_1, ..., C_k$. Then
$
X^m = mat(xi_1^((m)); dots.v; xi_k^((m))), space xi_i = "centroid of "C_i
$
3\*. $tilde(z)^((m))_(n+1) = [y_(n-m+2), dots, y_n]$.

4\*. Create a set of possible predictions:
$
S_n = {xi_i^((m))[m] | ||tilde(xi)^((m))_i - tilde(z)^((m))_(n+1)|| < epsilon}.
$

5\*. Same as before

== Using patterns

1. $Y = (y_1, ..., y_n)$

2. Given $K, L:$ generate patterns (rus. _шаблоны_). For example:
$ K=10, L = 4: space A = mat(1,1,1,1; 1,1,1,2; dots.v, dots.v, dots.v, dots.v; 10,10,10,10) $
$ z_i^((10,10,10,10))=[y_(i-40), ..., y_(i-10), y_i] $
Note that in this example $A$ can have only elements with values from 1 to 10.

3. $forall alpha in A: alpha=(K_1, ..., K_L), K_i in overline(1\,..\,K)$
$
z^(alpha)_i = [y_(i-K_L-K_(L-1)-...K_1), ..., y_(i-K_L-K_(L-1)), y_(i-K_L), y_i]
$
Generate $Z^(alpha) = mat(z^alpha_(K_m-K_L);z^alpha_(K_m-K_L+1);dots.v;z^alpha_n) space forall alpha in A$

4. $forall alpha in A$:
$
tilde(z)^alpha_(n+1) = [y_(n+1-K_L-K_(L-1) - ...), ..., y_(n + 1 - K_L)].
$
5. $forall alpha in A$:
$
S^alpha_(n+1) =& {z^alpha_i [i+1] | ||tilde(z)_i^alpha - tilde(z)_(n+1)^alpha|| < epsilon} \
S_(n+1) =& union_alpha S^alpha_(n+1).
$
6. Classify point the point as predictable or not predictable.

#h(1.25em) 6.1. Cluster $S_(n+1) -> C_1, ..., C_l, C_0$, where $C_0$ is a noise cluster and $C_i, space i=overline(1\,..\,l)$ are sorted by size from largest ($C_1$) to smallest ($C_l$).

$
eta_1 =& (\|C_1\|) / (\|C_2\|) >> 1 -> "goto 6.2" \
eta_2 =& (\|C_1\|) / (sum_(i=1)^l\|C_i\|) > epsilon_1 -> "goto 6.2"
$

#h(1.25em) 6.2. Estimate the variance of cluster $C_1$. If $DD(C_1) < epsilon_2 => "goto 7"$, if $"IQR"(C_1) < epsilon_2 => "goto 7"$

#h(1.25em) 6.3. Identify the point as non-predictable and move to the next point.

7. Obtain a single prediction.

== Self-healing algorithms

These are used to make predictions if a value was skipped.

1. Forecast $h$ steps ahead.

2. Run self-healing unill convergence or max iteration is reached.

3. Move to step 1.

