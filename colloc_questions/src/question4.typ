= Filtration and smoothing using Fourier analysis: Fourier series, Fourier transform, DFT, FFT, SSFT.
== Fourier transform

Fourier series is a decomposition of a function $f in C[a, b]$ with a orthogonal function system ${g_k}_(k=0)^(+infinity)$ in some euclidean space:
$ 
f(x) = sum_(k=1)^(+infinity) c_k g_k(x), space (f, g_k) = integral_a^b f(x) g_k (x)d x = 0
$
If $g_k$ is a trigonometric system:
$
g_k in {1 / (2 l), 1 / sqrt(l) cos((pi x) / l), 1 / sqrt(l) sin((pi x) / l), ... }
$
Then $f(x)$:
$
f(x) =& a_0 / 2 + sum_(k=1)^(+infinity) [a_k cos((k pi x) / l) + b_k sin((k pi x) / l) ],\
a_k =& 1 / l integral_(-l)^l f(x) cos((k pi x) / l)d x, space a_(-k) = a_k,\
b_k =& 1 / l integral_(-l)^l f(x) sin((k pi x) / l)d x, space b_0 = 0, space b_(-k) = -b_k.
$
In a more general case:
$
f(x) = sum_(k = -infinity)^(+infinity) c_k e^(i w_k x), space w_k = (pi k) / l, space c_k = 1 / (2 l) integral_(-l)^l f(x) e^(-i w_k x)d x
$
Let us derive this statement. Since 
$ 
sin(k x) = (e^(i k x) - e^(-i k x)) / (2 i) " and " cos(k x) = (e^(i k x) + e^(- i k x)) / 2,
$
$f(x)$ can expressed in a following manner:
$
f(x) =& e^(i w_0 x) dot (a_0) / 2 + sum_(k=1)^(+infinity) [a_k (e^(i w_k x) + e^(-i w_k x)) / 2 + b_k (e^(i w_k x) - e^(-i w_k x) ) / (2 i) ] =\
=& a_0 / 2 e^(i w_0 x) + 1 / 2 sum_(k=1)^(+infinity) [a_k e^(i w_k x) + a_k e^(-i w_k x) - i b_k e^(i w_k x) + i b_k e^(-i w_k x) ] =\
=& a_0 / 2 e^(i w_0 x) + 1 / 2 sum_(k=1)^(+infinity) (a_k - i b_k) e^(i w_k x) + 1 / 2 sum_(k=1)^(+infinity) (a_k + i b_k) e^(-i w_k x) =\
=& sum_(k=-infinity)^(+infinity) c_k e^(i w_k x).
$
Then, since $a_(-k) = a_k$ and $b_(-k) = - b_k$,
$
c_k =& 1 / 2 (a_k - i b_k) = 1 / (2 l) integral_(-l)^l f(t) (cos((k pi t) / l) - i sin((k pi t) / l))d t =\
=& 1 / (2 l) integral_(-l)^l f(t) ((e^(i w_k t) + e^(- i w_k t)) / 2 - i (e^(i w_k t) - e^(- i w_k t)) / (2 i)) d t =\
=& 1 / (4 l) integral_(-l)^l f(t) dot 2 e^(-i w_k t)d t = 1 / (2 l) integral_(-l)^l f(t) e^(- i w_k t)d t.
$

== From Fourier series to Fourier transform

For $t in [-l, l]$:
$
f(t) = sum_(k=-infinity)^(+infinity) c_k e^(i w_k t).
$ 
However, for $l -> +infinity$ following assumptions should be made:

1. $f(t)$ is piecewise continuous and has one-sided derivative in $[-l, l]$.

2. Limit function $f(t) = lim_(l->+infinity) sum_(k=-infinity)^(+infinity) c_k e^(i w_k t)$ is absolutely integrable.

3. Limit function $f(t)$ is piecewise continuous and has one-sided derivatives at any point.

Let us define $Delta w_k = w_(k+1) - w_k, space k in ZZ$. Since $w_k = (pi k) / l$, $Delta w_k = pi / l$ and $1 / l = (Delta w_k) / pi$. Therefore, $f(t)$ can be represented as:
$
f(t) =& sum_(k = -infinity)^(+infinity) 1 / (2 l) integral_(-l)^l f(tau) e^(-i w_k tau)d tau dot e^(i w_k t) =\
=& sum_(k = -infinity)^(+infinity) 1 / (2 pi) integral_(-l)^l f(tau) e^(-i w_k tau)d tau dot e^(i w_k t) Delta w_k =\
=& 1 / (2 pi) sum_(k = -infinity)^(+infinity) hat(F)_l (w_k, t) Delta w_k. 
$
And if $l -> +infinity$, then $Delta w_k -> 0$ and
$
f(t) = 1 / (2 pi) integral_(-infinity)^(infinity) hat(F)_l (w, t)d w,
$
where $hat(F)_l (w, t) = integral_(-infinity)^(+infinity) f(tau) e^(- i w tau)d tau dot e^(i w t)$.

Then, *Fourier transform* can be defined as:
$
hat(f)(w) = cal(F)(f(t)) = integral_(-infinity)^(+infinity) f(t) e^(-i w t) d t.
$
And *inverse Fourier transform* would be:
$
f(t) = cal(F)^(-1)(hat(f)(w)) = 1 / (2 pi) integral_(-infinity)^(+infinity) hat(f) (w) e^(i w t) d w.
$

Properties of Fourier transform:

1. Linearity.

2. $cal(F)(f * g) = hat(f)(w) dot hat(g)(w)$, where $f * g = integral_(-infinity)^(+infinity) f(tau) g(t - tau) d tau$ i.e. convolution.

3. $cal(F)(f dot g) = hat(f)(w) + hat(g)(w)$.

== Discrete Fourier transform

DFT (discrete Fourier transform) is an operation that transforms $f(t)$ to $f_0, f_1, dots, f_n$. Direct and inverse DFT respectively:
$
hat(f)_k =& sum_(j = 0)^(n-1) f_j exp(-i (2 pi j k) / n), \
f_k =& sum_(j = 0)^(n-1) hat(f)_j exp(i (2 pi j k) / n).
$
It has algorithmic complexity of $cal(O)(n^2)$ and is essentially a matrix multiplication:
$
  mat(hat(f)_0; dots.v; dots.v; dots.v; hat(f)_(n-1)) = mat(1, 1, 1, dots, 1; 1, w_n, w_n^2, dots, w_n^(n-1); 1, w_n^2, w_n^4, dots, w_n^(2(n-1)); dots.v, dots.v, dots.v, dots.down, dots.v; 1, w_n^(n-1), w_n^(2(n-1)), dots, w_n^((n-1)(n-1))) mat(f_0; dots.v; dots.v; dots.v; f_(n-1))
$
where $w_n = exp(- (2 pi i) / n)$.

== Fast Fourier transform

FFT (fast Fourier transform) is a family of algorithms that arose from need for a... faster version of DFT. Let us consider Cooley-Tukey algorithm. It relies on two properties of DFT:

- $w_n^(j k) = exp(-i (2 pi j k) / n)$ is periodic: $w_n^(j k) = w_n^(j(k + n)) = w_n^(k(j + n))$.

- $w_n^(j k)$ is symmetric: $w_n^(k + n / 2) = -w_n^(k)$.

The algorithm step-by-step:

1. Split $f$ into even and odd terms: $f_"even" = {f_(2 k)}_(k=0)^(n / 2 - 1)$ and $f_"odd" = {f_(2 k + 1)}_(k=0)^(n / 2 - 1)$

2. Let $G(k) = "DFT"(f_"even")$ and $H(k) = "DFT"(f_"odd")$ which takes $cal(O)(n^2 / 4)$ operations each and $cal(O)(n^2 / 2)$ total.

Therefore,
$
hat(f)_k =& sum_(j=0)^(n / 2 - 1) f_(2 j) exp(-i (2 pi k (2 j)) / n) + sum_(j=0)^(n / 2 - 1) f_(2 j + 1) exp(-i (2 pi k (2 j + 1)) / n) =\
=& G(k) + w_n^k H(k), space k = 0,1,dots, n / 2 - 1.
$
Taking the periodicity of $w_n$ into account,
$
hat(f)_(k + n / 2) = G(k + n / 2) + w_n^(k + n / 2) H(k + n / 2) = G(k) - w_n^k H(k)
$
which implies that $H(k + n / 2) = H(k)$ and $G(k + n / 2) = G(k)$. This implies that for $k in {n / 2, dots, n-1}$ $hat(f)_k$ can be calculated using the values from a period before:
$
f_(k + n / 2) = G(k + n / 2) + w_n^(k + n / 2) H(k + n / 2) = G(k) - w_n^k H(k), space k = 0, dots, n / 2 - 1.
$
3. Recursion. It can be used to calculate $H(k)$ and $G(k)$, moreover, when $n = 2^m$ recursion can be applied untill the end.

*FFT complexity.* Total number of recursions is $m = log_2 n$, hence it is $cal(O)(n log_2 n)$.

*Matrix form.* 
$
hat(f) = F^(2^m) f = mat(E^(2^(m-1)), D^(2^(m-1)); D^(2^(m-1)), E^(2^(m-1))) mat(F^(2^(m-1)), 0; 0, F^(2^(m-1))) mat(f_"even"; f_"odd"),
$
where $E^n$ is $n times n$ identity matrix and
$
D^n = mat(1, 0, 0, dots, 0; 0, w_n, 0, dots, 0; 0, 0, w_n^2, dots, 0; dots.v, dots.v, dots.v, dots.down, dots.v; 0, dots, dots, dots, w_n^n).
$

== Short time Fourier transform

STFT (Gabor transform) is given by:
$
G(f)(t, w) = hat(f)_g (t, w) = integral_(-infinity)^(+infinity) f(tau) e^(-i w tau) g(tau - t) d tau,
$
where $g(t) = exp(-(t - tau)^2 / alpha^2)$ is a Gaussian kernel function, but it is not necessary to use specifically this kernel function.

STFT can easily be discretized by applying FFT in eahc window. The result of STFT is a spectrogram: a plot of frequency against time.
