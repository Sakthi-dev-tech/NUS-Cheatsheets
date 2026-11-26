// Compile: typst compile main.typ main.pdf
// Sources: /home/sakthi/Documents/Obsidian Vault/100 Source Notes/Lectures/
// CS2109S Lecture {1,...,11}.md and their embedded lecture figures.
// Symbol audit: family-local keys define letters, indices, dimensions, operators,
// and overloaded notation; shared ML/index/operator conventions apply throughout.
// Formula audit: explicit scalar gradients, batch objective/update, penalty derivatives,
// kernel ridge solution/maps, chain rule, conv output, RNN readout/stack/concat, residuals.
// Supporting notes: 300 Main Notes/AI Gradient Descent Variants.md and AI Learning Algorithms.md.
// Course conventions: regularise intercept; column-packed attention.
// Corrections: L4 MAE has no square; L7 elastic net uses (1-rho), and
// the normal equation's slide lambda absorbs n; L8 softmax uses exp(z_k).
#let teal = rgb("146B82")
#let pale = rgb("EFF5F7")
#let rule = rgb("C9D8DE")
#let mark(body) = highlight(fill: rgb("FFF0B3"), body)
#let trap(body) = text(fill: rgb("A32935"), body)
#set document(title: "CS2109S Cheatsheet - Lectures 1-11")
#set page(paper: "a4", flipped: true, margin: 6mm, numbering: none)
#set text(font: "New Computer Modern", size: 7.5pt, fill: rgb("172B3A"), top-edge: "ascender", bottom-edge: "descender")
#set par(leading: 0.6pt, spacing: 1.3pt, justify: false)
#set columns(gutter: 4mm)
#set heading(numbering: none)
#show heading: it => block(above: 3pt, below: 1pt, sticky: true)[
  #stack(spacing: 0.7pt,
    text(font: "Nimbus Sans", size: 9.5pt, weight: "bold", fill: teal, it.body),
    line(length: 100%, stroke: 0.3pt + rule))
]
#show strong: set text(font: "Nimbus Sans", weight: "semibold")
#show math.equation.where(block: true): it => block(width: 100%, fill: pale, inset: 1pt, above: 1pt, below: 1pt)[#align(center, it)]
#set table(inset: (x: 2pt, y: 1.5pt), stroke: 0.25pt + rule,
  fill: (x, y) => if y == 0 { pale })
#show table: set text(size: 7.6pt)
#set page(background: {
  for i in range(1, 4) {
    place(top + left, dy: 6mm, dx: 6mm + (285mm + 4mm) * i / 4 - 2mm,
      line(angle: 90deg, length: 198mm, stroke: 0.2pt + rule))
  }
})

#columns(4)[
#text(font: "Nimbus Sans", size: 10pt, weight: "bold")[CS2109S · EQUATION SHEET]#linebreak()
#text(size: 7.5pt)[Lectures 1-11 · #mark[Conditions] · #trap[Pitfalls]]

// L1: task specification and environment properties.
= PEAS framework
*P — Performance measure:* criteria for success. *E — Environment:* external world the agent operates in. *A — Actuators:* means of acting. *S — Sensors:* means of perceiving.
*Self-driving taxi:* P: safety, legality, speed, comfort; E: roads, traffic, pedestrians, weather; A: steering, accelerator, brakes, signals; S: cameras, lidar, GPS, speedometer.

= Types of task environments
*Fully vs partially observable:* sensors reveal all decision-relevant state vs incomplete/noisy information (chess vs driving).

*Single-agent vs multi-agent:* one agent vs other agents whose decisions affect outcomes; competitive or cooperative.

*Deterministic vs stochastic:* current state + action uniquely determines next state vs probabilistic outcomes. #trap[Partial observation can make deterministic dynamics appear random.]

*Episodic vs sequential:* each percept–action episode is independent vs actions affect future states/decisions (image classification vs driving).

*Static vs dynamic:* environment unchanged vs may change while agent deliberates. *Semi-dynamic:* world unchanged, but performance score changes with time (timed chess).

*Discrete vs continuous:* distinct/countable vs continuously varying states, time, percepts or actions; classify each separately.

*Known vs unknown:* transition/outcome rules given vs must be learned. #trap[Known ≠ fully observable: rules can be known while state is hidden.] Unknown rules motivate exploration; exploitation uses current knowledge for reward.

// L1-L2: search formulation, algorithms, heuristic conditions.
= Search and heuristics
$ s'=T(s,a), quad g(n')=g(n)+c(s,a,s') $
$s,s'$: states; $a$: action; $T$: transition; $g$: path cost; $c$: step cost; $h$: estimated remaining cost; $h^*$: true minimum remaining cost. Same cost units. $n$: node; $n'$: successor node; $f$: queue priority; $b$: branching factor; $d$: shallowest goal depth; $m$: maximum depth.
#table(columns: (auto, 1fr, 1fr),
 [*Search*], [*Priority / order*], [*Time; space*],
 [BFS], [FIFO; least depth], [Exponential; exponential],
 [IDS], [DFS limits $0,1,…$], [$O(b^d)$; $O(b d)$],
 [UCS], [$f(n)=g(n)$], [Exponential; exponential],
 [Greedy], [$f(n)=h(n)$], [No general guarantees],
 [A\*], [$f(n)=g(n)+h(n)$], [Generally exponential],
)
BFS/IDS: complete if finite $b$; optimal with equal positive step costs. UCS/A\*: completeness needs finite $b$, $c>=epsilon>0$, finite optimal cost $C^*$. $epsilon$: positive lower bound on step cost. UCS optimal with nonnegative costs.

$ 0<=h(n)<=h^*(n) quad "admissible" $
$ h(n)<=c(n,a,n')+h(n') quad "consistent" $
$ h("goal")=0, quad "consistent" => "admissible" $
A\* optimality: tree → admissible; closed-set graph → consistent. #trap[Inconsistent $h$: reopen improved closed nodes. Goal-test on pop, not generation.]

$ h_1 (n)>=h_2 (n) quad forall n quad => quad h_1 "dominates" h_2 $
$h_1,h_2$: candidate heuristic functions. For admissible heuristics, $max(h_1,h_2)$ admissible; #trap[sum need not be]. Relaxed optimum gives a lower bound; pattern databases precompute it.

// L3: local search, minimax, alpha-beta.
= Local and adversarial search
$ s'=arg max_(u in N(s)) E(u) $
$ s <- cases(s' & E(s')>E(s), s & "otherwise: stop") $
$s$: current state; $u$: neighbour candidate; $s'$: best neighbour; $N(s)$: neighbour set; $E$: score to maximise. Hill climbing can stop at local maxima/plateaus; incomplete/suboptimal.

$ V(s)=cases(U(s) & "terminal", max_(s' " child") V(s') & "MAX", min_(s' " child") V(s') & "MIN") $
$s,s'$: state/child; $U$: terminal utility; $V$: backed-up value; MAX maximises, MIN minimises. Finite two-player zero-sum perfect-information game.

$ alpha_0=-infinity, quad beta_0=infinity $
$ alpha <- max(alpha,V) quad "at MAX" $
$ beta <- min(beta,V) quad "at MIN" $
$ alpha>=beta quad => quad "prune" $
$alpha$: MAX lower bound; $beta$: MIN upper bound; subscript 0: initial values (same utility units as $V$). Minimax: time $O(b^m)$, DFS space $O(b m)$. Perfect ordering: alpha-beta time $O(b^(m/2))$, same root value. #trap[Cutoff evaluation ≠ terminal utility; A\* heuristic conditions do not apply.]

// L1, L4, L6: retain only context needed for reading the equations.
= Notation and evaluation
$n$: example count; $d$: feature count; $i$: example index; $j$: feature/weight index; $K$: output/class count; $x$: input; $y$: target; $hat(y)$: prediction; $w$: weights; $J$: mean objective; $ell$: single-example loss. Superscript $(i)$: example index; subscript $j$: feature component. These ML symbols apply below. Counts/probabilities dimensionless; MSE in squared target units.

*Operators:* $T$ superscript = transpose; $*$ superscript = optimum; $norm(·)$ = Euclidean norm, $norm(·)_1$ = L1 norm; $abs(·)$ = absolute value; $nabla$ = gradient, $nabla^2$ = Hessian, $partial$ = partial derivative; $bb(R)$ = real numbers. $ln,log$ natural; $e$ base; $exp(z)=e^z$. $O$ = asymptotic order; argmax/min returns the maximising/minimising argument; $ceil(·),floor(·)$ round up/down. Primes on functions = derivatives; on variables = transformed/next values.

$ P=frac("TP","TP"+"FP"), quad R=frac("TP","TP"+"FN") $
$ F_1=frac(2P R,P+R)=frac(2"TP",2"TP"+"FP"+"FN") $
TP/TN: true positive/negative; FP/FN: false positive/negative counts. $P$: precision; $R$: recall; $F_1$: harmonic mean of $P,R$. #trap[Zero denominator → undefined.]

Train fits parameters/preprocessing; validation tunes hyperparameters; test estimates generalisation. IID: independent, identically distributed. Underfit: high bias; overfit: low train/high test error, often high variance.

// L4: probabilities, entropy, information gain.
= Entropy and decision trees
$ p(y)=n_y/n, quad p(x)=n_x/n, quad p(y divides x)=n_(x y)/n_x $
$X$: splitting attribute; $x$: its value; $Y$: label variable; $y$: label value; $n$: row count; $n_y,n_x,n_(x y)$: label/attribute/joint counts; $p$: empirical probability; $H$: entropy (bits); IG: information gain.

$ H(Y)=-sum_y p(y)log_2 p(y), quad 0 log_2 0:=0 $
$ H(Y divides X=x)=-sum_y p(y divides x)log_2 p(y divides x) $
$ H(Y divides X)=sum_x p(x)H(Y divides X=x) $
$ "IG"(Y;X)=H(Y)-H(Y divides X) $
$ H_"binary" (q)=-q log_2 q-(1-q)log_2(1-q) $
$q$: positive fraction; $H_"binary"$: binary entropy; $X_"split"$: chosen attribute. $H(0)=H(1)=0$, $H(1/2)=1$ bit. #trap[Child entropy weighted by child sample fraction.]

$ X_"split"=arg max_X "IG"(Y;X) $
DTL bases: empty → parent majority; pure → label; no attributes → current majority. Greedy IG need not give smallest tree; prune/limit depth to reduce overfit.

// L5: normal equation, loss, all gradient forms and scaling.
= Linear regression and losses
$x in bb(R)^(d+1)$: augmented feature vector; $x_0=1$; $w_j$: feature-$j$ weight ($w_0$: intercept); $X in bb(R)^(n times (d+1))$: design matrix, row $i=(x^((i)))^T$; $Y in bb(R)^n$: targets; $hat(y)^((i))$: example-$i$ prediction. MSE/MAE: mean squared/absolute error; $J$: half-MSE.
$ hat(y)=w^T x=sum_(j=0)^d w_j x_j $
$ "MSE"=frac(1,n)sum_(i=1)^n (hat(y)^((i))-y^((i)))^2 $
$ "MAE"=frac(1,n)sum_(i=1)^n abs(hat(y)^((i))-y^((i))) $
$ J(w)=frac(1,2 n)norm(X w-Y)^2=frac("MSE",2) $
$ frac(partial J,partial w_j)=frac(1,n)sum_(i=1)^n (hat(y)^((i))-y^((i)))x_j^((i)) $
$ nabla J=frac(1,n)X^T (X w-Y), quad nabla^2 J=X^T X/n $
$ X^T X w=X^T Y, quad w^*=(X^T X)^(-1)X^T Y $
#mark[Full column rank] required for inverse; otherwise $w^*=X^+Y$ ($X^+$: pseudoinverse) or ridge. Matrix formation $O(n d^2)$; solve $O(d^3)$.

= Gradient descent and batches
$ J=frac(1,n)sum_(i=1)^n ell_i, quad w_j <- w_j-eta frac(partial J,partial w_j) $
$ w <- w-eta frac(1,B)sum_(i in cal(B)) nabla_w ell_i $
$ell_i$: loss of example $i$; $cal(B)$: batch index set; $B$: batch size; $eta>0$: learning rate (update in weight units). Full $B=n$; mini $1<B<n$; SGD $B=1$; updates/epoch $ceil(n/B)$.
#trap[Simultaneous updates use the same old weights.] Large $eta$ can diverge; small is slow. Small batch: cheaper/noisier; nonconvex loss has no global guarantee.

= Scaling, feature maps, convexity
$x$: one raw feature; $a,b$: train min/max; $mu,sigma_x$: train mean/std; $x'_"minmax",x'_"std"$: scaled values. Reuse train statistics; handle zero denominators.
$ x'_"minmax"=(x-a)/(b-a), quad x'_"std"=(x-mu)/sigma_x $
$ phi:bb(R)^d -> bb(R)^M, quad h_w (x)=w^T phi(x) $
$phi$: feature map; $M$: transformed dimension; $h_w$: prediction; $w$: transformed-feature weights. E.g. $phi(x)=(1,x,x^2)$; fixed $phi$ remains linear in $w$.

$ J(t u+(1-t)v)<=t J(u)+(1-t)J(v) $
$u,v$: parameter vectors; $t in [0,1]$: interpolation ratio; $J$: objective on convex domain. Strict: $<$ for $u!=v$, $0<t<1$.
$ nabla^2 J(w) succ.curly.eq 0 quad forall w quad <=> quad J " convex" $
$ nabla^2 J(w) succ 0 quad forall w quad => quad J " strictly convex" $
$succ.curly.eq 0/succ 0$: positive semidefinite/definite. Twice differentiable required. Convex → local minima global; strict → at most one minimiser. Half-MSE strict iff $X$ full column rank; fixed features preserve convexity, learned NN features generally do not.

// L6: sigmoid/BCE, component and matrix gradients, thresholds and class counts.
= Logistic regression and BCE
$sigma$: sigmoid; $z$: linear score; $p$: class-1 probability; $y in {0,1}$: target; $ell$: binary cross-entropy (BCE); $J$: mean BCE. $x,w,X,Y,n,i,j$: linear-regression key.
$ sigma(z)=frac(1,1+e^(-z)), quad sigma'(z)=sigma(z)(1-sigma(z)) $
$ z=w^T x, quad p=sigma(z), quad y in {0,1} $
$ ell(y,p)=-y ln p-(1-y)ln(1-p) $
$ frac(partial ell,partial p)=frac(p-y,p(1-p)), quad frac(partial ell,partial z)=p-y $
$ J=frac(1,n)sum_(i=1)^n ell(y^((i)),p_i) $
$ frac(partial J,partial w_j)=frac(1,n)sum_(i=1)^n (p_i-y^((i)))x_j^((i)) $
$ nabla J=X^T (p-Y)/n $
$p_i$: example-$i$ probability; $p$ in matrix formula is vector $(p_1,…,p_n)^T$. Logistic+BCE convex; sigmoid itself nonconvex. Sigmoid+half-squared loss: $frac(partial ell,partial z)=(p-y)p(1-p)$; may be nonconvex.

$ hat(y)=bold(1)[p>=tau], quad w^T x=ln(tau/(1-tau)) $
$tau in (0,1)$: threshold; $bold(1)[·]$: 1 if true, 0 otherwise. At $tau=0.5$, boundary $w^T x=0$. Confident mistakes → high BCE.

*Multiclass:* one class; OvO $binom(K,2)=K(K-1)/2$ models + votes; OvR $K$ models + argmax score. *Multilabel:* $y in {0,1}^K$; binary relevance $K$ independent models; powerset up to $2^K$ label sets (sparse).

// L7: all penalties, derivatives, primal/dual equations and maps.
= Regularisation
$ J_"reg" (w)=J(w)+lambda R(w), quad lambda>=0 $
$R$: penalty; $J_"reg"$: regularised objective; $lambda$: validation-tuned strength (units make $lambda R$ match $J$). #mark[Course penalises all weights, including $w_0$.]
#table(columns: (auto, 1fr),
 [*Penalty*], [*$R(w)$*],
 [L1 / Lasso], [$norm(w)_1=sum_(j=0)^d abs(w_j)$],
 [L2 / Ridge], [$1/2 norm(w)^2=1/2 sum_(j=0)^d w_j^2$],
 [Elastic net], [$rho norm(w)_1+(1-rho)/2 norm(w)^2$],
)
$R_1,R_2$: L1/L2 penalties; $rho in [0,1]$: mixture (1=L1, 0=L2); $s_j$: L1 subgradient component; $partial_(w_j)R_1$: set of valid subgradients. L1 can give exact zeros.
$ frac(partial R_2,partial w_j)=w_j, quad s_j in partial_(w_j) R_1 $
$ s_j in cases({op("sign")(w_j)} & "if " w_j!=0, [-1,1] & "if " w_j=0) $
At zero choose any $s_j in [-1,1]$; sign gives $+1/-1$ for positive/negative weight. Elastic-net subgradient: $rho s_j+(1-rho)w_j$.

*Ridge with half-MSE:*
$ J_"reg"=frac(1,2 n)norm(X w-Y)^2+frac(lambda,2)norm(w)^2 $
$ nabla J_"reg"=X^T (X w-Y)/n+lambda w $
$ w^*=(X^T X+n lambda I)^(-1)X^T Y $
$I$: $(d+1)$-identity. $lambda>0$ → invertible, unique even if rank deficient. #trap[Slides absorb $n$: $lambda_"slide"=n lambda$.]

= Dual models and kernels
$ V=op("span"){x^((1)),…,x^((n))}, quad w=w_parallel+w_perp $
$ w_parallel in V, quad w_perp perp V, quad norm(w)^2=norm(w_parallel)^2+norm(w_perp)^2 $
$V$: span of training inputs; $w_parallel$: projection into $V$; $w_perp$: orthogonal component ($perp$: perpendicular). Only $w_parallel$ affects training scores; L2 forces $w_perp^*=0$.
$ w^*=sum_(i=1)^n alpha_i x^((i))=X^T alpha $
$ h_alpha (x)=f(sum_(i=1)^n alpha_i k(x^((i)),x)) $
$ k(u,v)=phi(u)^T phi(v), quad K_(i t)=k(x^((i)),x^((t))) $
$alpha in bb(R)^n$: dual coefficients; $f$: output function; $u,v$: inputs; $t$: second example index; $K$: $n times n$ Gram matrix (not class count). Kernel trick avoids explicit $phi$.

$ J(alpha)=frac(norm(K alpha-Y)^2,2 n)+frac(lambda,2)alpha^T K alpha $
$ alpha^*=(K+n lambda I_n)^(-1)Y quad (lambda>0) $
$I_n$: identity. This gives one optimum; coefficients representing $w$ may be nonunique if $K$ singular.

*Polynomial degree $r$; RBF width $s>0$:*
$ k_"poly" (u,v)=(1+u^T v)^r $
$ k_"RBF" (u,v)=exp(-norm(u-v)^2/(2s^2)) $
$ phi_"poly2" (x)=(1,sqrt(2)x,x^2) $
$ phi_j^"RBF" (x)=e^(-x^2/(2s^2))frac(x^j,s^j sqrt(j!)) quad (j>=0) $
Scalar $x$ in maps; $j$: map-coordinate index; $j!$: factorial; $s$: RBF width in input units; $r$: polynomial degree. $r>=1$ integer; RBF map infinite-dimensional. Valid Gram matrix: symmetric positive semidefinite. #trap[$phi=(1,x,x^2)$ gives $k=1+u v+u^2v^2$, not $(1+u v)^2$.]

= Hyperplanes and margins
$ w^T x=0, quad w!=0, quad h_w (x)=op("sign")(w^T x) $
$ "dist"(x)=frac(abs(w^T x),norm(w)) $
$ gamma(w)=min_i frac(y^((i))w^T x^((i)),norm(w)), quad w^* in arg max_w gamma(w) $
Raw $x in bb(R)^d$; #mark[no dummy feature]. $y^((i)) in {-1,+1}$, correctly separated; $gamma$: margin in feature units; $w$: normal. Positive scaling preserves plane/distance. Dual classifier: $f=op("sign")$; sign at 0 = 0.

// L8: FCNN, activations, multiclass, chain rule and backpropagation.
= FC neural networks
$ a^0=x, quad z^l=W^l a^(l-1)+b^l, quad a^l=g_l (z^l) $
$l=1,…,L$: layer index; superscript $l$ labels layer; $L$: depth excluding input; $m_l$: width ($m_0=d$); $a^l,z^l$: activation/pre-activation vectors; $W^l,b^l$: weight matrix/bias vector; $g_l$: activation; $a^0=x$: input.
$ W^l in bb(R)^(m_l times m_(l-1)), quad b^l in bb(R)^(m_l) $
$ N_"FC"=sum_(l=1)^L (m_(l-1)+1)m_l $
$N_"FC"$: parameter count including biases. Notes store transposed $W$. #trap[Shared parameters counted once. All affine layers collapse to one affine map.]

#block(breakable: false)[
#table(columns: (auto, 1fr, 1fr),
 [*$g$*], [*$g(z)$*], [*$g'(z)$*],
 [Identity], [$z$], [$1$],
 [Sigmoid], [$sigma(z)$], [$sigma(z)(1-sigma(z))$],
 [Tanh], [$tanh(z)$], [$1-tanh^2(z)$],
 [ReLU], [$max(0,z)$], [$bold(1)[z>0]$],
 [Leaky], [$max(a z,z)$], [$a$ if $z<0$; 1 if $z>0$],
)
]
Table: $z$ scalar pre-activation; $g,g'$: activation/derivative; $a in (0,1)$: leaky slope (not activation $a^l$). Choose derivative at 0; sigmoid/tanh saturation → small gradients.

= Output heads and losses
*Regression:* identity; $K$ outputs:
$ J=frac(1,2 n)sum_(i=1)^n sum_(k=1)^K (hat(y)_k^((i))-y_k^((i)))^2 $
*Binary/multilabel:* sigmoid per output + BCE. *Multiclass:* softmax + CCE (one-hot target):
$ p_k=frac(e^(z_k),sum_(j=1)^K e^(z_j)), quad sum_k p_k=1 $
$ ell=-sum_(k=1)^K y_k ln p_k=-ln p_"true" $
$k,j$: output/class indices; $z_k$: logit; $p_k$: class probability; $y_k$: one-hot target component; $p_"true"$: true-class probability; $ell$: CCE; $J$: mean loss. Softmax unchanged by $z_k <- z_k-max_j z_j$ (numerical stability).

= Chain rule and backpropagation
$ frac(partial ell,partial x)=sum_r frac(partial ell,partial u_r)frac(partial u_r,partial x) $
$x$: scalar input for chain rule; $u_r$: intermediate scalar nodes; $r$: branch index; $ell$: loss. #mark[Multiply along paths; sum over all branches.]

$ delta^l=frac(partial ell,partial z^l), quad ⊙ := "elementwise product" $
$ delta^L=(a^L-y) ⊙ g'_L (z^L) quad "squared loss" $
$ delta^L=p-y quad "sigmoid+BCE / softmax+CCE" $
$ delta^l=((W^(l+1))^T delta^(l+1)) ⊙ g'_l (z^l) $
$ frac(partial ell,partial W^l)=delta^l (a^(l-1))^T, quad frac(partial ell,partial b^l)=delta^l $
$ nabla J_"reg"=frac(1,B)sum_(i in cal(B)) nabla ell_i+lambda nabla R $
$delta^l$: gradient w.r.t. layer pre-activation; $delta^L$: output gradient; $p$: output-probability vector; $y$: target vector. Other layer symbols: FC key; $B,cal(B),ell_i$: batch key. Last line includes penalty gradient.

// L9: convolution shapes, operation, pooling, counts.
= CNNs and Pooling
$I_H,I_W$: input height/width; $K_H,K_W$: kernel height/width; $C_"in",C_"out"$: input/output channel counts; $O_H,O_W$: output height/width. $P_H,P_W$: padding per side; $S_H,S_W$: strides (all spatial sizes in pixels).
$ O_H=1+floor((I_H+2P_H-K_H)/S_H) $
$ O_W=1+floor((I_W+2P_W-K_W)/S_W) $
Output $O_H times O_W times C_"out"$; floor discards incomplete patch.
$ Z_c=X ∗ W_c+b_c, quad A_c=g(Z_c) $
$X$: input tensor; $∗$: patch × kernel sum over space #mark[and input channels]#text[;] $c$: output channel; $W_c$: shared kernel; $b_c$: scalar channel bias; $g$: activation; $Z_c,A_c$: pre/post-activation maps.
$ N_"conv"=(K_H K_W C_"in"+1)C_"out" $
$ N_"pool"=0, quad D_"flatten"=O_H O_W C_"out" $
$N$: parameter counts; $D_"flatten"$: flattened length. Pool max/mean independently per channel; same shape formula with pool window; channels unchanged. #trap[Bias per output channel, not pixel.]

// L10: embeddings, RNN, outputs, stacking, bidirectionality, generation.
= Embeddings and RNNs
$ N_"embed"=V E, quad h^0=0 $
$V$: vocabulary count; $E$: embedding width; $N_"embed"$: table parameter count. $T$: sequence length; $t$: time index; superscript $t$: time, not power; $h^0$: initial zero state. Token index selects a table row.

$ h^t=g(W_x x^t+W_h h^(t-1)+b) $
$ W_x in bb(R)^(H times E), quad W_h in bb(R)^(H times H), quad b in bb(R)^H $
$x^t in bb(R)^E$: token embedding; $h^t in bb(R)^H$: hidden state; $H$: hidden width; $W_x,W_h$: input/recurrent weights; $b$: bias; $g$: usually tanh.
$ o^t=W_y h^t+b_y, quad hat(y)^t=g_"out" (o^t) $
$ W_y in bb(R)^(K times H), quad b_y,o^t in bb(R)^K $
$ N_"RNN"=H E+H^2+H, quad N_"head"=(H+1)K $
$W_y,b_y$: head weights/bias; $K$: output count; $hat(y)^t$: output; $g_"out"$: identity/sigmoid/softmax; $o^t$: logits; $N_"RNN",N_"head"$: core/head parameter counts. #trap[Weights shared over time; count independent of $T$.]

*Stacked: separate weights at each layer $l$:*
$ h^(l,t)=g_l (W_x^l h^(l-1,t)+W_h^l h^(l,t-1)+b^l) $
$h^(l,t)$: layer-$l$ state at time $t$; layer-specific $W_x^l,W_h^l,b^l,g_l$ as above; $h^(0,t)=x^t$. *Bidirectional / pooled readout:*
$ h^t=op("concat")(h_"forward"^t,h_"backward"^t) $
$ overline(h)=frac(1,T)sum_(t=1)^T h^t $
$h_"forward"^t,h_"backward"^t$: directional states; concat joins them (width $2H$); $overline(h)$: mean state. #trap[Bidirectional needs full input.]

Aligned many→many: output each step; many→one: final/pooled state; one→many: input conditions $h^0$/first token; unaligned many→many: encoder-decoder. SOS starts; EOS/length cap stops. Teacher forcing feeds previous true token; inference feeds prediction (mismatch). Scheduled sampling: true/predicted with probabilities $p,1-p$ ($p$: teacher-forcing probability).

// L11: self-attention, masks, position, cross-attention, residuals.
= Self-attention: Column Convention
$ X in bb(R)^(D times T), quad Q=W_q X, quad K=W_k X, quad V=W_v X $
$ W_q,W_k in bb(R)^(d_k times D), quad W_v in bb(R)^(d_v times D) $
$ S=K^T Q, quad A="softmax"_"col" (S/sqrt(d_k)), quad C=V A $
$X$: token-column matrix; $D$: token width; $T$: sequence length; $W_q,W_k,W_v$: learned projections; $d_k,d_v$: key/value widths; $Q,K$: queries/keys ($d_k times T$); $V$: values ($d_v times T$); $S,A$: scores/weights ($T times T$); $C$: contexts ($d_v times T$). #trap[Here $K,V$ are matrices.]

$"softmax"_"col"$: column-wise softmax. Row $i$: key provider; column $t$: query token.
$ s_(i t)=(k^i)^T q^t $
$ alpha_(i t)=frac(exp(s_(i t)/sqrt(d_k)),sum_(j=1)^T exp(s_(j t)/sqrt(d_k))) $
$ c^t=sum_(i=1)^T alpha_(i t)v^i, quad sum_i alpha_(i t)=1 $
$q^t,k^i,v^i$: query/key/value vectors; $s_(i t)$: raw match score; $alpha_(i t)=A_(i t)$: attention weight; $c^t$: context column; $j$: key index in denominator. Scale avoids softmax saturation. Equal scores → uniform $1/T$. Weighted sum uses #mark[values], not keys.

= Causal mask and position
$ A="softmax"_"col" (S/sqrt(d_k)+M) $
$ M_(i t)=cases(0 & "if " i<=t, -infinity & "if " i>t) $
$M$: causal mask matrix; $M_(i t)$: key-$i$/query-$t$ mask entry; $i<=t$: visible token. #mark[Column-query convention]: allowed on/above diagonal. #trap[Row-packed convention transposes it.] Add mask before softmax; future weights = 0.

$ theta_j (t)=t/10000^(2j/D) $
$ "PE"_(2j) (t)=sin theta_j (t), quad "PE"_(2j+1) (t)=cos theta_j (t) $
$"PE"_r (t)$: positional encoding dimension $r$ at position $t$; $D$: even token width; $j=0,…,D/2-1$: sine/cosine pair index; $theta_j$: angle in radians; 10000: fixed base. Zero-based dimensions (notes one-based). Add PE to token embedding; no learned sinusoidal PE parameters.

= Cross-attention and residuals
Encoder $E_"enc" in bb(R)^(D_e times T_x)$; decoder $D_"dec" in bb(R)^(D_d times T_y)$; $D_e,D_d$: widths; $T_x,T_y$: lengths.
$ Q=W_q D_"dec", quad K=W_k E_"enc", quad V=W_v E_"enc" $
$ C=V "softmax"_"col" (K^T Q/sqrt(d_k)) $
$Q,K,V$: queries/keys/values; $W_q,W_k,W_v$: projections; $d_k,d_v$: key/value widths (self-attention key); $A$: $T_x times T_y$ weights; $C$: $d_v times T_y$ context. #mark[Q from decoder; K,V from encoder.]

$ z^t=x^t+c^t, quad h^t=z^t+"FFNN"(z^t) $
$x^t$: token input; $c^t$: attention context; $z^t$: residual sum; $h^t$: output; FFNN: feed-forward network. Equal widths required (or project). FFNN shared per position. Encoder: self-attention → FFNN; decoder: masked self-attention → cross-attention → FFNN; residuals around each. #trap[Autoregressive generation remains sequential.] Attention weights require $T^2$ storage.
]
