#set page(
  paper: "a4",
  numbering: "1",
)

#set text(
  size: 16pt,
)

#set par(
  justify: true,
)

#set enum(numbering: "1.")

0. $alpha in A$, $Z^alpha$ for $t = T+1, ..., T+L$:

For each $alpha in A$:

1. $tilde(z)^alpha_t$ -- form truncated $z$ vector for point $T+1$ for pattern $alpha$

2. $S^alpha_t = {z_i [-1] \| rho (tilde(z)^alpha_i\, space tilde(z)^alpha_t) < epsilon}$

3. $S_t = union_alpha S^alpha_t$

4. $hat(y)_t^omega = "mean"(S_t) + cal(N)(0, sigma^2)$

Note that steps 1 and 2 generate a permuted trajectory.

Repeat this $M$ times, where $M$ is the number of new trajectories

For $t=T+1, ..., T+L$:

1. For set of possible predicted values $S_t = {hat(y)_t^((i))}^M_(i=1)$

2. Apply an algorithm for point classification

For $t=T+1,...,T+L$:

For each $alpha in A$:

1. $tilde(z)^alpha_t$

2. $S_t^alpha = {z^alpha_i [-1] \| rho(tilde(z)_i, space tilde(z)^alpha_t) < epsilon}$

3. $S_t = union_alpha S_t^alpha$

4. Cluster $S_t$ into $C_1, C_2, ..., C_l$. To overcome computational problems use $l^*$ largest clusters.

5. Set predictions ${hat(y)^((1))_t, ..., y^((l))_t}$, where $hat(y)^((i))_t="mean"(C_i)$.

IMPORT THE PICTURE (abount training $T_1, T_2,$ etc.), VERY IMPORTANT!!!

== DBSCAN algorithm

1. Parameters: 

- $epsilon$

- $"minPts"$ -- minimum number of points in $epsilon$-neighbourhood to determine the core point.

2. Point types: 

- core point -- a point that hase at least $"minPts"$ points inside of its $epsilon$-neighbourhood including itself.

- border point -- a point with less than $"minPts"$ points in its $epsilon$-neighbourhood but is reachable from a core point

- noise point -- every other point.

*Def.* #h(0.5cm) $q$ is directly reachable from $p$ if $q$ is in its $epsilon$-neighbourhood.

*Def.* #h(0.5cm) $q$ is reachable from $p$ if there exists a chain of points that includes $p$ and $q$ such that each next point is directly reachable from a previous one.

Algorithm:

1. Initialization.

- All points are marked as unvisisted
- An empty list of clusters is created.

2. Marking the points one-by-one.

- For each point $p$:

#h(1.25cm) - if $p$ is visited $->$ skip

#h(1.25cm) - mark $p$ as visited

#h(1.25cm) - calculate the number of points in $epsilon$-neighbourhood of $p$ (including $p$ itself).

#h(1.25cm) - if the \# of neighbours $< "minPts" -> $ mark $p$ as noisy point

#h(1.25cm) - otherwise:

#h(2.5cm) - create a new cluster;

#h(2.5cm) - add all neighbours to this cluster;

#h(2.5cm) - recuresively grow the cluster by adding points reachable from the core points.

3. CLuster expansion.

- For each point $q$ in the current cluster

#h(1.25cm) - if $q$ is not visited $->$ mark it as visited, find its $epsilon$-neighbourhood and if it contains at least $"minPts"$ points, add them to the cluster too.

Advantages:

- DBSCAN can find clusters of any shape

- It does not require setting the number of clusters

- It is robust to outliers

Disadvantages:

- This algorithm is very sensitive to its hyperparameter values

- The results vary depending in distance metric you choose

- Does not work well if data has differing cluster densities

Hyperparameter selection:

- $"minPts"$ is usually selected to be $>="# of features"+1$

- $epsilon$ can be selected base on graph of distances to k-th nearest neighbours: it is mostly selected as the point of a sharp bend in the graph.
