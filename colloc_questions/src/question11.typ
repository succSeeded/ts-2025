= Time series forecasting with neural networks

== Form dataset

- Use time windows:
$
X =& [y_(t-n), y_(t-n+1), dots, y_(t-1)] \
y =& [y_t] - "one-step ahead prediction" \
y =& [y_t, y_(t+1), ..., y_(t+h-1)] - "h-step ahead prediction"
$
- You can add other features

== Neural network acrhitectures

=== FNN

Take $X$ as input of size $n$ and make the output layer the size of number of steps ahead you want to predict.

Problem: these models do not account for time dependence.

=== RNN

Problem: RNNs do not have long-term memory, as earlier outputs decay and may not be accounted for in the end.

=== LSTM

\<Import pic\>

=== CNN

Idea: let us use 1D filters to extract local patterns (motives). Use dialation ot increase lookback period.

Example:

1. $"kernel" =3, d=1: [y_(t-2), y_(t-1), y_t]$

2. $"kernel" =3, d=2: [y_(t-4), y_(t-2), y_t]$

But here you can sometimes use data from the future thus breaking causality. To deal with this problem TCNN was developed.

=== TCNN

Idea: Combine properties of CNN and LSTM to make thing good.

- retain causality (solved by causal convolutions --- left padding with size $k-1$ is used when applying filters instead of values to the right of one that the filter is applied to);

- enable parallelization;

- long effective memory (solved by using all sorts of different dialations).

Temporal (TCNN) block.

Input $->$ Causal dialated convolution $->$ Normalization $->$ Activation function $->$ Backprop $->$ Causal dialated convolution $->$ Normalization $->$ Activation function $->$ Output

Deep TCNN: skip connections.

TCNN Block gets some data as input and summed with it. Note that 1D convolution is used to adjuct the sizes.

=== Transformers

...

=== VAE

VAE (_variational autoencoder_) architecture:

1. Encoder: Input $->$ CNN/RNN $->$ Flatten $->$ FC $->$ $mu, space log(sigma^2)$, a.k.a. latent distribution of data

2. Sampling: $z = mu + sigma dot epsilon, space epsilon ~ cal(N)(0,1)$

3. Decoder: z $->$ FC $->$ Reshape $->$ CNN/RNN $->$ output

4. ELBO loss (maximization task)

$ "ELBO" = EE[log p(x | z)] - K dot L(q(z | x)||p(z)) -> max $

