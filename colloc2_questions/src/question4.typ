= Kolmogorov-Sinai Entropy

How to calculate the K-S entropy:

1. Subdivide the phase space into cells $A_i$ with side $epsilon$.

2. Take $rho_i = mu (A_i)$ -- measures of $A_i$ and the $f^(-k) (A_i)$ -- the set of all points that arrived to $A_i$ in $k$ steps.

3. Take 
$
A^((1))_i = A_i, \
A^((2))_(i_1 i_2) = A_(i_1) inter f^(-1) (A_(i_2)),\
A^((3))_(i_1 i_2 i_3) = A_(i_1) inter f^(-1) (A_(i_2)) inter f^(-2) (A_(i_3))
$ 
etc. up to $A^((k))_(i_1 dots i_k)$.

4. Calculate
$
H^((k)) = - sum_(i_1, dots, i_k) mu (A^((k))_(i_1 dots i_k)) log (mu (A^((k))_(i_1 dots i_k)))  
$
5. The K-S entropy would be:
$
K (mu) = lim_(epsilon -> 0) lim_(k -> + infinity) (H^((k+1)) - H^((k))).
$
Interpretation:

- $K (mu) > 0$ is indicative of chaos;

- $K (mu) = 0$ indicates that the system is deterministic.
