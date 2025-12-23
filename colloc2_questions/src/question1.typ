= Entropy-Complexity

Given the time series data $Y = (y_1, dots, y_N)$, one can estimate the associated PDF as $P = (p_1, dots, p_M)$, where M is the amount of unique states the system can have. This allows the notion of Shannon entropy to be introduced:
$
H (P) = - sum_(j=1)^M p_j log (p_j). 
$
Then, the statistical complexity measure can also be calculated using the following rule:
$
C(P) = Q_(cal(J)) (P, P_U) S (P),
$
where $Q_(cal(J)) (P, P_U)$ is normalized Jensen-Shannon divergence between $P$ and the PDF of a uniform distribution
$
Q_(cal(J)) (P, P_U) = (cal(J) (P, P_U)) / (cal(J)_max)
$
and $S (P)$ is normalized Shannon entropy given by:
$
S (P) = (H (P)) / (H (P_U)) = (H (P)) / (log M).
$
Note that
$
cal(J) (P_1, P_2) = H ((P_1 + P_2) / (2)) - 1 / 2 (H (P_1) + H (P_2)),
$
therefore,
$
cal(J)_max =& cal(J) (P_U, P_C) = H ((P_U + P_C) / 2) - 1 / 2(H (P_U) - H (P_C)) = \
=& H ((P_U + P_C) / 2) + 1 / 2 log M - 1 / 2 dot 0 \
=& 1 / 2 log M - (M - 1) / (2 M) log (1 / (2 M)) - (1 / (2 M) + 1 / 2) log (1 / (2 M) + 1 / 2).
$
