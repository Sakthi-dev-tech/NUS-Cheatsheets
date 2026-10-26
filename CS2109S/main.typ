// Faithful content conversion of main.tex; compile with: typst compile main.typ typ.pdf
#set document(title: "CS2109S Cheatsheet")
#set page(paper: "a4", flipped: true, margin: 10mm, numbering: "1", number-align: center)
#set text(font: "New Computer Modern", size: 9pt, top-edge: "ascender", bottom-edge: "descender")
#set par(leading: 1.8pt, spacing: 1.35pt, first-line-indent: 0pt, justify: true)
#set columns(gutter: 4mm)
#set list(indent: 0pt, body-indent: 1em, spacing: 0pt, tight: true)
#set enum(indent: 0pt, body-indent: 1.3em, spacing: 0pt, tight: true)
#set heading(numbering: none)
#show heading: it => block(above: 3pt, below: 1pt, sticky: true)[#text(size: 10pt, weight: "bold", fill: rgb("146B82"), it.body)]
#show heading.where(level: 2): it => block(above: 3pt, below: 1pt, sticky: true)[#text(size: 9pt, weight: "bold", it.body)]
#show heading.where(level: 3): it => block(above: 0pt, below: 0pt, sticky: true)[#text(size: 8.1pt, style: "italic", it.body)]
#show raw: set text(font: "Nimbus Mono PS", size: 7.2pt)
#show raw.where(block: true): set block(above: 2pt, below: 2pt)
#show math.equation.where(block: true): set block(above: 2pt, below: 2pt)
#set table(inset: (x: 1.5pt, y: 1pt), stroke: 0.3pt)
#show figure: set block(above: 2pt, below: 2pt)
#set page(numbering: none)
#set text(fill: rgb("172B3A"))
#show raw.where(block: true): it => block(fill: rgb("F2F7F8"), stroke: 0.2pt + rgb("C9D8DE"), inset: 2pt, it)
#set page(background: { for i in range(1, 4) { place(top + left, dy: 10mm, dx: 10mm + (277mm + 4mm) * i / 4 - 2.0mm, line(angle: 90deg, length: 190mm, stroke: 0.2pt + rgb("C9D8DE"))) } })
#show strong: set text(font: "Nimbus Sans")
#show heading: it => block(above: 4pt, below: 1.5pt, sticky: true)[#stack(spacing: 0.7pt, text(font: "Nimbus Sans", size: 10pt, weight: "bold", fill: rgb("146B82"), it.body), line(length: 100%, stroke: 0.2pt + rgb("C9D8DE")))]
#show math.equation.where(block: true): it => block(width: 100%, fill: rgb("F2F7F8"), inset: 2pt, above: 1pt, below: 1pt)[#align(center, it)]


#columns(4)[
#text(font: "Nimbus Sans", size: 11.5pt, weight: "bold")[CS2109S CHEATSHEET]#v(1pt)#line(length: 100%, stroke: 0.8pt + rgb("146B82"))#v(2pt)

#heading(level: 1, numbering: none)[Agents and environments]
<agents-and-environments>
#strong[PEAS] Performance measure; Environment; Actuators; Sensors.

#strong[Observability] Full: complete relevant state. Partial: hidden state.

#strong[Dynamics] Static: unchanged while deciding. Dynamic: changes. Semi-dynamic: state fixed, score changes with time.

#strong[Other axes] Single/multi-agent; deterministic/stochastic; episodic/sequential; discrete/continuous; known/unknown rules.

#strong[Agent types] Reflex: condition--action rule. Goal-based: seek goal. Utility-based: rank outcomes. Learning: improve from experience.

#strong[Note:] Known rules do not imply fully observable state. In an unknown environment, balance exploration and exploitation.

#heading(level: 1, numbering: none)[Search problem]
<search-problem>
#strong[Specify] States $S$; start $s_0$; goal test $G \( s \)$; actions $A \( s \)$; transition $T \( s \, a \)$; step cost $c \( s \, a \, s' \)$.

#strong[Node] State + parent/path + cumulative cost $g \( n \)$. Branching factor $b$: successors per expansion.

#strong[Complete] Finds a solution whenever one exists.

#strong[Optimal] Returns a minimum-cost solution. Equal step costs make minimum depth equivalent.

#heading(level: 1, numbering: none)[Systematic search]
<systematic-search>
#strong[BFS] FIFO; smallest depth. Complete for finite $b$; optimal for equal costs. Exponential time/space.

#strong[IDS] Depth-limited DFS at $0 \, 1 \, 2 \, dots.h$. $O \( b^d \)$ time, $O \( b d \)$ DFS space. Complete for finite $b$ and solution depth; optimal for equal positive costs.

#strong[UCS] Priority by $g \( n \)$. Complete if $b < oo$, every cost $gt.eq epsilon.alt > 0$, and $C^(*) < oo$; optimal with nonnegative costs. Same as A, but heuristic is set to 0

#strong[Greedy] Priority by $h \( n \)$; ignores cost already paid; generally not optimal.

#strong[A] Priority by $g \( n \) + h \( n \)$; UCS when $h = 0$; usually exponential space.

$ f_(upright("BFS")) = d \, quad f_(upright("UCS")) = g $ $ f_(upright("greedy")) = h \, quad f_(upright(A^(*))) = g + h $

#strong[Note:] For cost-based search, accept a goal when removed from the priority queue, not when first generated.

#heading(level: 1, numbering: none)[A heuristics]
<a-heuristics>
$ 0 lt.eq h \( n \) lt.eq h^(*) \( n \) quad upright("(admissible)") $ $ h \( n \) lt.eq c \( n \, a \, n' \) + h \( n' \) quad upright("(consistent)") $

#strong[$h^(*) \( n \)$] True cheapest remaining path cost. Require $h \( upright("goal") \) = 0$.

#strong[Guarantees] Admissible $h$: optimal A tree search. Consistent $h$: optimal graph search with a closed set; consistency implies admissibility.

#strong[Dominance] Among admissible heuristics, if $h_1 \( n \) gt.eq h_2 \( n \)$, $h_1 \( n \)$ is more informed.

#strong[Construction] Solve a relaxed problem; precompute a pattern database; learn an estimate. The relaxed optimum is a lower bound.

#strong[Note:] With an inconsistent heuristic, graph search may need to reopen improved nodes.

#heading(level: 1, numbering: none)[Local search]
<local-search>
#strong[Idea] Keep a current state, generate neighbours, and return a state rather than a path. Low memory; usually incomplete/suboptimal.

$ s' = arg max_(u in N \( s \)) upright("eval") \( u \) $

#strong[Hill climbing] If $upright("eval") \( s' \) lt.eq upright("eval") \( s \)$, stop; otherwise set $s arrow.r s'$.

#strong[Failure modes] Local maximum: better than neighbours, not global. Plateau/shoulder: no immediate improvement.

#strong[Escapes] Random restarts; simulated annealing may sometimes accept a worse move.

#heading(level: 1, numbering: none)[Minimax and alpha--beta]
<minimax-and-alphabeta>
#strong[Setting] Finite two-player zero-sum perfect-information game; utility from MAX's viewpoint.

$ V \( s \) = cases(delim: "{", U \( s \) \, & s upright(" terminal"), max_(s') V \( s' \) \, & s upright(" MAX"), min_(s') V \( s' \) \, & s upright(" MIN")) $

#strong[Cost] Minimax time $O \( b^m \)$, depth-first space $O \( b m \)$; optimal against optimal play.

#strong[Alpha--beta] $alpha$: MAX's best lower bound; $beta$: MIN's best upper bound. Prune when $alpha gt.eq beta$. Same root move/value.

#strong[Ordering] Good moves first increase pruning; ideal time $O \( b^(m \/ 2) \)$.

#strong[Cutoff] Stop at depth limit; score nonterminal states with a cheap evaluation function. #strong[EVALUATION IS NOT EQUAL TO FINAL SCORE/TERMINAL NODE]

#heading(level: 1, numbering: none)[Learning setup and metrics]
<learning-setup-and-metrics>
#strong[Supervised] Labelled $\( x^(\( i \)) \, y^(\( i \)) \)$ pairs, assumed IID. Regression: real target. Classification: discrete class.

#strong[Unsupervised] Find structure in unlabelled inputs.

$ P = frac(T P, T P + F P) \, quad R = frac(T P, T P + F N) $ $ F_1 = frac(2 P R, P + R) $

#strong[Interpret] Precision: fraction of predicted positives correct. Recall: fraction of actual positives found.

#strong[Data split] Train fits parameters; validation selects settings; untouched test estimates generalisation.

#heading(level: 1, numbering: none)[Entropy and decision trees]
<entropy-and-decision-trees>
$ H \( Y \) = - sum_y p \( y \) log_2 p \( y \) \, quad 0 log 0 = 0 $

#strong[Note:] The log base has to be 2

$ H \( Y divides X \) = sum_x p \( x \) H \( Y divides X = x \) $ $ I G \( Y ; X \) = H \( Y \) - H \( Y divides X \) $

#strong[Binary entropy] For positive fraction $q$: $H = - q log_2 q - \( 1 - q \) log_2 \( 1 - q \)$. Pure: $0$; balanced: $1$ bit.

#strong[Tree] Internal node tests an attribute; branch is an outcome; leaf predicts a label. Split on highest immediate $I G$.

#strong[DTL bases] No rows $arrow.r$ parent majority; one label $arrow.r$ that label; no attributes $arrow.r$ current majority. Else split and recurse.

#strong[Overfitting] A tree can fit finite consistent categorical examples perfectly, including noise. Limit depth or require a minimum leaf size.

#strong[Real data] Bin continuous values; choose a rule for missing values.

#heading(level: 1, numbering: none)[Linear regression]
<linear-regression>
#strong[Intercept] Set $x_0 = 1$; $X in bb(R)^(n times \( d + 1 \))$, $w in bb(R)^(d + 1)$, $Y in bb(R)^n$.

$ h_w \( x \) = w^T x = sum_(j = 0)^d w_j x_j $ $ J \( w \) = frac(1, 2 n) parallel X w - Y parallel_2^2 $ $ w = \( X^T X \)^(- 1) X^T Y $

#strong[Normal equation] Inverse form needs full column rank; #strong[inversion costs roughly] $O \( d^3 \)$. If singular, remove redundant features

#strong[MAE] $1 / n sum_i \| hat(y)^(\( i \)) - y^(\( i \)) \|$.

#strong[Note:] The $1 \/ 2$ in $J$ only simplifies derivatives. Compute every gradient component from the same old $w$.

#heading(level: 1, numbering: none)[Gradient descent and convexity]
<gradient-descent-and-convexity>
$ w_i arrow.l w_i - eta frac(nabla J \( w_i \), nabla w_i) $

#strong[Note:] $J$ here refers to the loss function $arrow.r$ taking the partial derivative of it relative to $w_i$

#strong[Rate] Large $eta$: overshoot/diverge. Small $eta$: slow.

#strong[Batch size] Full batch: $n$ examples/update. Mini-batch: $b$. SGD: $1$. Updates/epoch: $ceil.l n \/ b ceil.r$.

#strong[Tradeoff] Smaller batches give cheaper, noisier updates; noisy steps do not guarantee a global minimum.

$ J \( t u + \( 1 - t \) v \) lt.eq t J \( u \) + \( 1 - t \) J \( v \) $

#strong[Convexity] For $0 lt.eq t lt.eq 1$. If $J$ is twice differentiable on a convex domain, it is convex iff $nabla^2 J \( w \) succ.curly.eq 0$ everywhere. Every local minimum is global.

#strong[Strict convexity] The inequality is strict for $u eq.not v$ and $0 < t < 1$; $nabla^2 J \( w \) succ 0$ everywhere is sufficient, but not necessary. A minimiser, if it exists, is unique.

#strong[Linear MSE] Here $nabla^2 J = X^T X \/ n succ.curly.eq 0$; strict convexity holds iff $X$ has full column rank. Penalising every weight with $lambda parallel w parallel_2^2$ ($lambda > 0$) also makes it strict.

#heading(level: 1, numbering: none)[Scaling and feature maps]
<scaling-and-feature-maps>
$ x'_(min max) = frac(x - min x, max x - min x) $ $ x'_(upright("std")) = frac(x - mu, sigma) $

#strong[Why scale?] Uneven scales cause zig-zag GD updates. Fit scaling on training data; reuse on validation/test. Handle constant features separately.

#strong[Feature map] $phi.alt : bb(R)^d arrow.r bb(R)^M$, e.g. $phi.alt \( x \) = \( 1 \, x \, x^2 \)$.

#strong[Effect] $w^T phi.alt \( x \)$ may be nonlinear in raw $x$ but remains linear in $w$; a fixed map preserves convexity of linear-MSE/logistic-BCE in $w$.

#heading(level: 1, numbering: none)[Logistic classification]
<logistic-classification>
$ sigma \( z \) = frac(1, 1 + e^(- z)) $ $ sigma' \( z \) = sigma \( z \) \( 1 - sigma \( z \) \) $

#strong[Model] $p = h_w \( x \) = sigma \( w^T x \)$ estimates class-1 probability. At threshold $0.5$, boundary is $w^T x = 0$.

$ ell_(upright("BCE")) \( y \, p \) = - y log p - \( 1 - y \) log \( 1 - p \) $ $ J \( w \) = 1 / n sum_i ell_(upright("BCE")) \( y^(\( i \)) \, sigma \( w^T x^(\( i \)) \) \) $

#strong[Gradient] $nabla J \( w \) = X^T \( p - Y \) \/ n$. Logistic + BCE is convex in $w$ for fixed features; sigmoid alone is not globally convex.

#strong[Threshold] $p gt.eq tau$ predicts class 1; boundary $w^T x = log \( tau \/ \( 1 - tau \) \)$.

#strong[Note:] For $y = 1$, BCE is $- log p$; for $y = 0$, it is $- log \( 1 - p \)$. A confident wrong prediction is costly.

#heading(level: 1, numbering: none)[Multiclass vs multilabel]
<multiclass-vs-multilabel>
#strong[Multiclass] Exactly one of $K$ classes. One-vs-one: $binom(K, 2)$ classifiers + votes. One-vs-rest: $K$ classifiers + highest score.

#strong[Multilabel] Any subset; $y in { 0 \, 1 }^K$. Binary relevance: one independent classifier/label; ignores dependencies.

#strong[Powerset] Treat each observed label set as one class; retains combinations but may create many sparse classes.

#heading(level: 1, numbering: none)[Generalisation and tuning]
<generalisation-and-tuning>
#strong[Underfit] Too little capacity $arrow.r$ high bias.

#strong[Overfit] Good training fit, poor unseen-data fit; often high variance across training samples.

#strong[Parameters] Learned weights. #strong[Hyperparameters:] rate, batch size, feature map, tree depth.

#strong[Tune] Grid, random, or local search on validation data; use held-out test only for final assessment.

#strong[Improve] Relevant low-noise data, suitable model capacity, pruning/regularisation.

]
