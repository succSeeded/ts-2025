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

$y_1, y_2, ..., y_tau$

1. $K=10, space L=4->$ generate patterns $A = mat(1,1,1,1;dots.v,dots.v,dots.v,dots.v;10,10,10,10)$

$omega(y_i)={0,1},$ where 1 stands for local extremum and 0 for other parts.

2. $forall y_i\, omega(y_i)=1:$ sample $z$ vectors
$ forall alpha in A: Z^alpha = {z^alpha_i | omega(y_i)=1} $

3. Cluster $Z^alpha -> c^alpha_1, c^alpha_2, ..., c^alpha_m$

$ Xi^alpha = {xi_i^alpha | xi^alpha_i = "centroid"(c^alpha_i)} $

Inference Stage:

$i=tau+1:$
1. $forall alpha: z_i^alpha$

2. $n=|union_alpha {xi_i^alpha \| \|xi_i^alpha-z_i^alpha\|<epsilon}|$

3. $r=n/(union_alpha Xi^alpha)$

4. If $r > r_("crit"): omega(y_i)=1$
If $r < r_("crit"): omega(y_i)=0$

== How to choose $r_("crit")?$

Validation dataset:

$ 
forall y_i in& "Validation" and omega(y_i)=1: r_i \
forall y_i in& "Validation" and omega(y_i)=0: r_i
$

Choose $r_("crit")$ based on how "risky" you are. Plot the probability distributions (assumingly $r$ value against some kind of probability?)

== Predictive clustering for forecasting

Local normalization:

Given $z^alpha_i in$ Train Data, take
$
(z^alpha_i - min(tilde(z)^alpha_i)) / (max(tilde(z)^alpha_i) - min(tilde(z)^alpha_i))
$
And somehow use this with testing data.

== Updating the algorithm

$y_1, y_2, ..., y_tau$

1. $K=10, space L=4->$ generate patterns $A = mat(1,1,1,1;dots.v,dots.v,dots.v,dots.v;10,10,10,10)$

$omega(y_i)={0,1},$ where 1 stands for local extremum and 0 for other parts.

2. $forall y_i\, omega(y_i)=1:$ sample $z$ vectors
$ forall alpha in A: Z^alpha = {z^alpha_i | omega(y_i)=1}, space forall z^alpha_i: (z^alpha^i - min(z^alpha_i)) / (max(z^alpha_i) - min(z^alpha_i)) $

3. Cluster $Z^alpha -> c^alpha_1, c^alpha_2, ..., c^alpha_m$

$
Xi^(alpha\,0) =& {xi_i^alpha | xi^alpha_i = "centroid"(c^alpha_i)},\ 
Xi^(alpha\,1), ...
$

Inference Stage:

$i=tau+1:$
1. $forall alpha: z_i^alpha$

2. $n_i=|union_alpha {xi_i^alpha \| \|xi_i^alpha-z_i^alpha\|<epsilon, xi_i^alpha in Xi^(alpha\,i)}|, space i = overline(0\,1\,...)$

3. $r_i=n_i/(union_alpha Xi^alpha), space i=overline(0\,1\,...)$

4. If $r > r_("crit"): omega(y_i)=1$
If $r < r_("crit"): omega(y_i)=0$

Take
$
X_1 =& [y_1^((1)), y_2^((1)), ..., y^(tau_1)^((1))], space l_1 = 0, \
X_2 =& [y_1^((2)), y_2^((2)), ..., y^((2))_(tau_2)], space l_2 = 1, \
... \
X_k =& [y_1^((k)), y_2^((k)), ..., y^((k))^(tau_k)], space l_k = abs(0)
$

1. $forall X_i, l_i = 1:$ sample and cluster $z$ vectors --- extract clusters which are common for the given class.

2. $forall X_i, l_i = 0:$ sample and cluster $z$ vectors, then extract clusters common for class 0.

Inference stage: obtain clusters for new time series, count neigbours among zeros and ones and choose clusters with more neighbours.

$ z_i ->_("norm") z^("normed")_i ->_("fit polynomials") [alpha_1, beta_1, alpha_2, beta_2, ...] $

Here the last term is a vector of coeficients.

= Neural networks for time series

== Form dataset

- Use time windows:
$
X =& [y_(t-n), y_(t-n+1), dots, y_(t-1)] \
y =& [y_t] - "one-step ahead prediction" \
y =& [y_t, y_(t+1), ..., y_(t+h-1)] - "h-step ahead prediction"
$
- You can add other features

== Neural network acrhitectures

=== 1. FNN

Take $X$ as input of size $n$ and make the output layer the size of number of steps ahead you want to predict.

Problem: these models do not account for time dependence.

=== 2. RNN

Problem: RNNs do not have long-term memory, as earlier outputs decay and may not be accounted for in the end.

=== 3. LSTM

\<Import pic\>

=== 4. CNN

Idea: let us use 1D filters to extract local patterns (motives). Use dialation ot increase lookback period.

Example:

1. $"kernel" =3, d=1: [y_(t-2), y_(t-1), y_t]$

2. $"kernel" =3, d=2: [y_(t-4), y_(t-2), y_t]$

But here you can sometimes use data from the future thus breaking causality. To deal with this problem TCNN was developed.

=== 5. TCNN

Idea: Combine properties of CNN and LSTM to make thing good.

- retain causality (solved by causal convolutions --- left padding with size $k-1$ is used when applying filters instead of values to the right of one that the filter is applied to);

- enable parallelization;

- long effective memory (solved by using all sorts of different dialations).

Temporal (TCNN) block.

Input $->$ Causal dialated convolution $->$ Normalization $->$ Activation function $->$ Backprop $->$ Causal dialated convolution $->$ Normalization $->$ Activation function $->$ Output

Deep TCNN: skip connections.

TCNN Block gets some data as input and summed with it. Note that 1D convolution is used to adjuct the sizes.

=== 6. Transformers

...

=== 7. VAE

VAE (_variational autoencoder_) architecture:

1. Encoder: Input $->$ CNN/RNN $->$ Flatten $->$ FC $->$ $mu, space log(sigma^2)$, a.k.a. latent distribution of data

2. Sampling: $z = mu + sigma dot epsilon, space epsilon ~ cal(N)(0,1)$

3. Decoder: z $->$ FC $->$ Reshape $->$ CNN/RNN $->$ output

4. ELBO loss (maximization task)

$ "ELBO" = EE[log p(x | z)] - K dot L(q(z | x)||p(z)) -> max $

= Chaotic time series analysis

$
cases(dot(x)=sigma(y-x)\,, dot(y)=x(rho-z)-y\,, dot(z)=x y - beta z\.) 
$

$x(t), y(t), z(t)$ --- time series. If we are able to constuct and solve this kind of equations, we will be able to get their values for any point in time. 

