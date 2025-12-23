= Predictive clustering for trajectory forecasting

For $t = T+1, dots, T+L$ generate a perturbed trajectory:

1. $tilde(z)_t^alpha$ --- form truncated $z$ vector for point $T+1$ for pattern $alpha$.

2. $S^alpha_t = {z_i [-1] | rho(tilde(z)^alpha_i, space tilde(z)^alpha_t) < epsilon}$

3. $S_t = union_alpha S^alpha_t$.

4. $hat(y)_t^((i)) = "mean"(S_t) + cal(N)(0, sigma^2)$.

5. Repeat for each $alpha in A$.

To formulate a forecast for each point $t$:

1. Create a set of forecasted values
$
S_t = {hat(y)^((i))_t}_(i=1)^M.
$
2. Classify the point using a corresponding algorithm.

3. If the point is forecastable, choose its value.

You can also substitute steps 4 and 5 in the previous algorithm with the following:

4. Cluster $S_t$ obtaining $C_1, C_2, dots, C_l$.

5. For each cluster $hat(y)^((i))_t = "mean"(C_i)$. 

