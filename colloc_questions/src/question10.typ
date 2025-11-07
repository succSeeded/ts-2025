= Clusterization for time series: DBSCAN, Wishart, metrics

== DBSCAN algorithm

=== Parameters

- tolerance $epsilon$

- $"minPts"$ --- minimum number of points in $epsilon$-neighbourhood to determine the core point.

=== Point types

- _core point_ --- a point that has at least $"minPts"$ points inside of its $epsilon$-neighbourhood including itself.

- _border point_ --- a point with less than $"minPts"$ points in its $epsilon$-neighbourhood but is reachable from a core point

- _noise point_ --- every other point.

=== Reachability

$q$ is _directly reachable_ from $p$ if $q$ is in its $epsilon$-neighbourhood.

$q$ is _reachable_ from $p$ if there exists a chain of points that includes $p$ and $q$ such that each next point is directly reachable from a previous one.

=== Algorithm

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

3. Cluster expansion.

- For each point $q$ in the current cluster

#h(1.25cm) - if $q$ is not visited $->$ mark it as visited, find its $epsilon$-neighbourhood and if it contains at least $"minPts"$ points, add them to the cluster too.

=== Advantages

- DBSCAN can find clusters of any shape

- It does not require setting the number of clusters

- It is robust to outliers

=== Disadvantages

- This algorithm is very sensitive to its hyperparameter values

- The results vary depending in distance metric you choose

- Does not work well if data has differing cluster densities

=== Hyperparameter selection

- $"minPts"$ is usually selected to be $>="# of features"+1$

- $epsilon$ can be selected base on graph of distances to k-th nearest neighbours: it is mostly selected as the point of a sharp bend in the graph.

== Density and graph clusterization algorithm

Wishart algorithm modified by Lapko nad Chentsov.

=== Density estimation

Density function is given by the following expression:

$ p(x) = K / (V_K (x) dot n), $

where: 

- $V_K (x)$ is the volume of $K$-dimensional hypersphere with center at $x$ that contains $K$ points,

- $d_K (x)$ --- radius of the sphere (a.k.a. dist. to the $K$-th nearest neighbour),

- $n$ --- the total \# of points.

=== Connectivity graphs

- _Connectivity graph_ $G(Z_n, U_n)$ is a graph where $Z_n$ is the set of all vertices and $U_n$ --- the set of edges. So $X_i$ is connected to $X_j$ if 
$
d(X_i, X_j) <= d_K (x_i), space i != j.
$
- Connectivity subgraph $G(Z_i, U_i)$ is a graph where $Z_i = {X_1, X_2, ..., X_i}$ and $U_i$ is the set of edges connecting points in $Z_i$.

=== Height significance of a cluster

A cluster $C_l$ is height significant w.r.t. height $h > 0$ if 
$
max{|p(X_i) - p(X_j)| space forall X_i, space X_j in C_l} >= h.
$
=== Algorithm

1. Prepare the data.

- Calculate $d_K (x) space forall x in "data"$

- Sort the data based n $d_K (x)$ in ascending order

2. Initialization.

- Set counter $i = 1$

- Denote cluster label for $i$-th point as $w(x_i)$

3. Process points in sorted order.

For each point in subgraph $G(Z_i, U_i)$ do the following depending on the scenario:

A. Isolated vertex.

- If $X$ is not connected to any other vertex create new cluster.

B. Connected to only one cluster $C_l$.

- If cluster is complete $w(x_i)=0$ or in layman's terms we label $x_i$ as noise.

- If cluster is not complete we label this point with class label.

C. Connected to multiple clusters.

- If all clusters as complete we lable the point as noise.

- Determine the number of significant cluters (in terms of height significance) $Z(h)$. If $Z(h) > 1$ then label all significant clusters as complete and delete insignificant clusters (by assigning them to noise) and assign the point to noise too: $w(x_i) = 0$. If there is only signle significant cluster combine all clusters into one $C_l_1$, $w(x) = l_1$.

4. Update the counter $i = i+1$, if $i <= n$ goto step 3.

=== Advantages

- Algorithm itself determines the \# of clusters.

- Tends to label more points as noise the other algorithms do\*.

- Can find clusters of arbitrary form.

- Not sensitive to noise.

=== Disadvantages

- Sensitive to choice of hyperparameters.

- Optimal hyperparameter values are hard to determine.

- Slow.

=== Hyperparameter selection

Grid search is usually used, but clusterization results have to be able to be compared with each other. This can be achieved using metrics. 

1. Silhouette score $cal(O)(n^2)$

Denote the avg. distance from point $i$ to all other points in a cluster as $a(i)$.

Denote minimum avg. distance between $i$ and other cluster(s?) as $b(i)$.

$ 
S(i) =& (b(i) - a(i)) / (max{a(i), b(i)}), \
S =& "mean"(S(i)).
$

2. Halinski-Harabaz index $cal(O)(n)$
$ 
"SSB" =& sum |C_k| dot ||C_k - C||^2, \
"SSW" =& sum ||X - C_k||^2, \
"CH" =& ( ("SSB") / (K - 1) ) / ( "SSW" / (N - K) ),
$
where:

- $"SSB"$ --- intercluster dispersion,

- $"SSW"$ --- intracluster dispersion,

- $K$ --- the number of clusters,

- $N$ --- the number of points,

- $|C_k|$ --- the number of elements in the cluster $C_k$,

- $C$ --- center of all data.

3. Davies-Bondeu index $cal(O)(n)$
$
s_i =& 1 / (|C_i|) sum ||X - C_i|| \
R_(i j) =& (s_i + s_j) / (||C_i - C_j||) \
D_i =& max_(j, space i!=j) R_(i j) \
"DB" =& 1 / K sum D_i, space "DB" in [0, infinity)
$
The lower $"DB"$ the better.

4. Vaname ratio criterion.

// TSS is general variance
$
"TSS" = sum ||X_i - C||^2 \
"BSS" = sum |C_k| dot ||C_k - C||^2 \
"VR" = "TSS" / "BSS" in [0,1]
$
The closer to 0, the worse clustering is.

