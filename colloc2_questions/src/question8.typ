= Why we can forecast times series? Taken’s theorem with application for time series forecasting

== Smooth manifolds and smooth maps

Let $RR^k$ be a $k$-dimensional euclidean space (i.e. linear space with scalar product defined), then $x in RR^k, space x= (x_1, dots, x_k)$.

*Def. 1* Let $U subset RR^k, space V subset RR^l$ be two open sets. A mapping $f: U -> V$ is called _smooth_ if all partial derivatives $(partial^n f) / (partial x_(i_1) dots partial x_(i_k))$ exist and are continuous.

*Def. 2* A map $f: X -> Y$ is a _homemorphism_ if:

#h(1.25cm) 1. $f(X) = Y$ is a bijection;

#h(1.25cm) 2. $f$ and $f^(-1)$ are continuous.

*Def. 3* A map $f: X -> Y$ is a _diffeomorphism_ if:

#h(1.25cm) 1. $f$ and $f^(-1)$ are smooth;

#h(1.25cm) 2. $f$ is a homeomorphism.

If $f: X -> Y$ and $g: Y -> Z$ are smooth, then $g circle.tiny f: X -> Z$ is smooth as well.

*Def. 4* A set $M subset RR^k$ is a _smooth manifold_ of dimension $m$ if $forall x in M$ exists a neighbourhood $W inter M != emptyset$ which has a diffomorphic map to an open set $U subset RR^m$.

*Note.* Any diffeomorphism $g: U -> W inter M$ is called a parametrisation of $W inter M$. The inverse map $g^(-1): W inter M -> U$ is called a coordinate system on $W inter M$.

== Mathematical foundations for time series analysis

Let $phi^t (x)$ be a dynamical system, $P$ its phase space, $tau$ the time step between two consequtive observations and a scalar function $h: P -> RR$ the observation function of states of the dynamical system.

Denote states of the dynamical system $phi^t (x)$ as $arrow(x)(t_i), arrow(x)(t_(i+1)), dots$ and time series values of the observation function as $y_i = h(arrow(x)(t_i))$. Then:
$
y_i = h(arrow(x)(t_i)) = h(phi^(t_i)(x_0))
$
For the sake of simplicity denote $x(t_i)=x_i$. Given time step $tau$, state transitions for a dynamical system could be represented in the following way:
$
x_(i+1) = phi^tau (x_i), x_(i+2) = phi^(2 tau) (x_i), dots
$
Then, a system of equations can be constructed as follows:
$
cases(y_i = h(x_i) = Phi_0(x_i)\,, y_(i+2) = h(phi^tau (x_i)) = Phi_1(x_i)\,, dots, y_(i+m-1) = Phi_(m-1)(x_i).)
$
This system describes how z-vectors are constructed. Next, for $x_i in M^d subset P$, define $Lambda: M^d -> RR^m$ where 
$
Lambda(x_i) = (h(x_i), h(phi^tau (x_i)), dots, h(phi^((m-1)tau)(x_i))) = (y_i, dots, y_(i+m-1)).
$
There are several conditions placed upon $Lambda$:

1. $Lambda$ should be a bijection;

2. $Lambda$ should be Lipshitz continuous.

*Def. 5* A mapping $f: X -> Y$ is _Lipschitz continuous_ if there exists such $L >= 0$ that for all $x_i, x_j in X$ 
$
rho_X (f(x_i), f(x_j)) <= L dot rho_Y (x_i, x_j).
$

*Def. 6* A manifold is _compact_ if every open over of it has a finite subcover: if every collection $C$ of open subsets of X such that
$
X = union_(S in C) S,
$
there is finite subcollection $F subset.eq C$ such that
$
X = union_(S in F) S.
$
Functionally it is a generalization of the notion of closed sets.

*Theorem 1 (Taken's delay embedding theorem)* Let $M in RR^k$ be a compact smooth manifold, let $tau$ be the lag between obsetvation, and let $phi: M -> M$ be a diffeomorphism. Given an observation function $h: M -> RR$ that produces scalar time series data one can assert that for a generic $h$, the map
$
Lambda(x_i) = (x_i, h(phi(x_i)), dots, h(phi^((m-1)tau)(x_i)))
$
is an embedding (a smooth bijection) for $m > 2 k$.

*Corollary 1* The reconstructed observation space contains all topological invariants and dynamical features of the original attractor including periodic orbits, Lyapunov exponents and entropy.

Let $S$ be the image space of an embedding $Lambda$. Then, the following dynamic systems could be defined:
$
x_i =& Lambda^(-1) (z_i), x_(i+1) = phi^tau (x_i), \
z_(i+1) =& Lambda (x_(i+1)) = Lambda (phi^tau (x_i)) = Lambda (phi^tau (Lambda^(-1)(z_i))) = Psi (z_i), z_i in S.
$
Here, $z_i = (y_i, dots, y_(i+m-1))$ and the pair of systems can be denoted as $phi: M -> M$ and $Psi: S -> S$.

$Psi: S -> S$ can be used to predict future values of the time series. Given $z_(i+1) = Psi(z_i)$,
$
z_(i+1,m) = y_(i+m+1-1) = F(z_i) = F((y_i, dots, y_(i+m-1))).
$
