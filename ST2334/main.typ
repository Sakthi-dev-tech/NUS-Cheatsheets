// Faithful content conversion of main.tex; compile with: typst compile main.typ typ.pdf
#set document(title: "ST2334 Cheatsheet")
#set page(paper: "a4", flipped: true, margin: 6mm, numbering: "1", number-align: center)
#set text(font: "New Computer Modern", size: 8pt, top-edge: "ascender", bottom-edge: "descender")
#set par(leading: 1.6pt, spacing: 1.2pt, first-line-indent: 0pt, justify: true)
#set columns(gutter: 4mm)
#set list(indent: 0pt, body-indent: 1em, spacing: 0pt, tight: true)
#set enum(indent: 0pt, body-indent: 1.3em, spacing: 0pt, tight: true)
#set heading(numbering: none)
#show heading: it => block(above: 3pt, below: 1pt, sticky: true)[#text(size: 9.6pt, weight: "bold", fill: rgb("174A74"), it.body)]
#show heading.where(level: 2): it => block(above: 3pt, below: 1pt, sticky: true)[#text(size: 8pt, weight: "bold", it.body)]
#show heading.where(level: 3): it => block(above: 0pt, below: 0pt, sticky: true)[#text(size: 7.2pt, style: "italic", it.body)]
#show raw: set text(font: "Nimbus Mono PS", size: 6.4pt)
#show raw.where(block: true): set block(above: 2pt, below: 2pt)
#show math.equation.where(block: true): set block(above: 2pt, below: 2pt)
#set table(inset: (x: 1.5pt, y: 1pt), stroke: 0.3pt)
#show figure: set block(above: 2pt, below: 2pt)
#set page(numbering: none)
#set page(background: { for i in range(1, 3) { place(top + left, dy: 6mm, dx: 6mm + (285mm + 4mm) * i / 3 - 2.0mm, line(angle: 90deg, length: 198mm, stroke: 0.15pt + rgb("777777"))) } })
#set par(leading: 2pt, spacing: 1.3pt)
#show math.equation.where(block: true): set block(above: 3pt, below: 3pt)

#block(width: 100%, above: 0pt, below: 7pt)[#set par(justify: false)
#align(center)[#text(size: 11pt, weight: "bold", fill: rgb("174A74"))[ST2334: Probability and Distributions]]]

#columns(3)[
#heading(level: 1, numbering: none)[1. Events and counting]
<events-and-counting>
$S$: possible outcomes; an event $A subset.eq S$; $A^c$: complement; $A inter B$: both; $A union B$: either. $ \( A union B \)^c = A^c inter B^c \, #h(2em) \( A inter B \)^c = A^c union B^c . $ $P \( S \) = 1 \, med P \( nothing \) = 0 \, med P \( A^c \) = 1 - P \( A \)$. Relative frequency $n_A \/ n$ approaches $P \( A \)$ as trials grow.

#text(fill: rgb("9A4D0B"), weight: "bold")[Counting:] For $r$ distinct items selected from $n$: order matters $arrow.r.double zws_n P_r = n ! \/ \( n - r \) !$; order does not matter $arrow.r.double binom(n, r) = n ! \/ \[ r ! \( n - r \) ! \]$.

#text(fill: rgb("9A4D0B"), weight: "bold")[Counting reminder:] These formulas choose without repetition; $zws_n P_r = r ! binom(n, r)$.

$P \( A union B \) = P \( A \) + P \( B \) - P \( A inter B \)$; if disjoint, $P \( A inter B \) = 0$. Equally likely outcomes: $P \( A \) = \| A \| \/ \| S \|$.

#text(fill: rgb("9A4D0B"), weight: "bold")[Inclusion--exclusion:] For overlapping events: add singles, subtract pairs, add triples, and alternate. No independence assumption is needed.

#text(fill: rgb("9A4D0B"), weight: "bold")[Three events:] $P \( A union B union C \) = P \( A \) + P \( B \) + P \( C \) - P \( A inter B \) - P \( A inter C \) - P \( B inter C \) + P \( A inter B inter C \)$.

In general, $P \( union.big_(i = 1)^n A_i \) = sum_(k = 1)^n \( - 1 \)^(k + 1) sum_(1 lt.eq i_1 < dots.h.c < i_k lt.eq n) P \( A_(i_1) inter dots.h.c inter A_(i_k) \)$.

#text(fill: rgb("9A4D0B"), weight: "bold")[Birthday bound:] For $k$ independent items in $m$ equally likely slots, $P \( upright("collision") \) = 1 - product_(i = 0)^(k - 1) \( 1 - i \/ m \)$; its 50% point is near $1.18 sqrt(m)$.

#text(fill: rgb("9A4D0B"), weight: "bold")[Union bound:] $P \( union.big_i A_i \) lt.eq sum_i P \( A_i \)$, without independence. For $n$ independent assignments to $m$ slots, collision probability $lt.eq binom(n, 2) \/ m$.

#heading(level: 1, numbering: none)[2. Conditional probability]
<conditional-probability>
#text(fill: rgb("9A4D0B"), weight: "bold")[Use:] Update a probability after learning $A$; require $P \( A \) > 0$. For an "at least one" event, try $1 - P \( upright("none") \)$.

$P \( B divides A \) = P \( A inter B \) \/ P \( A \)$, hence $ P \( A inter B \) = P \( A \) P \( B divides A \) = P \( B \) P \( A divides B \) . $ Chain: $P \( A inter B inter C \) = P \( A \) P \( B divides A \) P \( C divides A inter B \)$.

#text(fill: rgb("9A4D0B"), weight: "bold")[Independence:] $A perp B arrow.l.r.double P \( A inter B \) = P \( A \) P \( B \)$. Then $P \( B divides A \) = P \( B \)$ when $P \( A \) > 0$. Positive-probability disjoint events are dependent. Complements of independent events remain independent.

#text(fill: rgb("9A4D0B"), weight: "bold")[Use:] Split a target event $B$ into exhaustive, disjoint cases $A_i$.

$ P \( B \) = sum_i P \( A_i \) P \( B divides A_i \) . $ Two cases: $P \( B \) = P \( A \) P \( B divides A \) + P \( A^c \) P \( B divides A^c \)$.

#text(fill: rgb("9A4D0B"), weight: "bold")[Use:] Reverse evidence-to-cause probabilities with Bayes' rule.

$ P \( A_k divides B \) = frac(P \( A_k \) P \( B divides A_k \), sum_i P \( A_i \) P \( B divides A_i \)) . $

#text(fill: rgb("9A4D0B"), weight: "bold")[Two-case Bayes:] For cases $A \, A^c$, use $P \( A divides B \) = P \( A \) P \( B divides A \) \/ P \( B \)$ with the two-case $P \( B \)$ above.

#text(fill: rgb("9A4D0B"), weight: "bold")[Conditional product:] Always start with $P \( A inter B inter C \) = P \( A \) P \( B divides A \) P \( C divides A inter B \)$. If $B perp C divides A$, replace the last term by $P \( C divides A \)$; count $P \( A \)$ only once.

#text(fill: rgb("9A4D0B"), weight: "bold")[Simpson's paradox:] An aggregate comparison can reverse every subgroup comparison when subgroup weights differ; inspect conditional rates.

#heading(level: 1, numbering: none)[3. One random variable]
<one-random-variable>
$X : S arrow.r bb(R)$ assigns a number to each outcome; $R_X$ is its support/range. Discrete: countable values. Continuous: density over intervals.

#text(fill: rgb("9A4D0B"), weight: "bold")[PMF, discrete:] $f_X \( x \) = P \( X = x \) gt.eq 0$, $sum_(x in R_X) f_X \( x \) = 1$. Add masses to find $P \( X in B \) = sum_(x in B) f_X \( x \)$.

#text(fill: rgb("9A4D0B"), weight: "bold")[PDF, continuous:] $f_X \( x \) gt.eq 0$, $integral f_X \( x \) thin d x = 1$. Integrate area: $P \( a lt.eq X lt.eq b \) = integral_a^b f_X \( x \) thin d x$. Single points have probability zero; density height is not probability and may exceed 1.

#text(fill: rgb("9A4D0B"), weight: "bold")[CDF, either type:] $F_X \( x \) = P \( X lt.eq x \)$. Discrete: jump at $x$ is $P \( X = x \)$, and $P \( a lt.eq X lt.eq b \) = F_X \( b \) - F_X \( a^(-) \)$. Continuous: $F_X \( x \) = integral_(- oo)^x f_X \( t \) d t$, $f_X = F_(X')$, and interval probability is $F_X \( b \) - F_X \( a \)$. Invert $F_X$ for a quantile.

#text(fill: rgb("9A4D0B"), weight: "bold")[CDF check:] $F_X$ is right-continuous, never decreases, and tends to 0/1 at the extremes; inversion turns a percentile into a value.

#text(fill: rgb("9A4D0B"), weight: "bold")[Use:] Find an average or a transformed average without first finding the distribution of $g \( X \)$.

$ E \[ g \( X \) \] = sum_x g \( x \) f_X \( x \) quad upright("or") quad integral g \( x \) f_X \( x \) d x . $ $mu_X = E \( X \)$, $E \( a X + b Y + c \) = a E \( X \) + b E \( Y \) + c$, even without independence. $ "Var" \( X \) = E \[ \( X - mu_X \)^2 \] = E \( X^2 \) - mu_X^2 . $ $"Var" \( a X + b \) = a^2 "Var" \( X \)$. $sigma_X = sqrt(V \( X \))$ has the units of $X$; variance has squared units.

#text(fill: rgb("9A4D0B"), weight: "bold")[Tail-sum expectation:] For nonnegative integer $X$, $E \( X \) = sum_(k gt.eq 1) P \( X gt.eq k \) = sum_(k gt.eq 0) P \( X > k \)$. For nonnegative continuous $T$, $E \( T \) = integral_0^oo P \( T > t \) thin d t$. Use when the tail is easier than the PMF/PDF.

#text(fill: rgb("9A4D0B"), weight: "bold")[Inspection paradox:] A random arrival is more likely to fall in a long gap, so the expected wait can exceed what a naive average-gap calculation suggests.

#heading(level: 1, numbering: none)[4. Joint distributions]
<joint-distributions>
$f_(X \, Y) \( x \, y \)$: joint mass/density on the allowed pairs. For a region $D$, sum masses or integrate $f_(X \, Y)$ over $D$ to get $P \( \( X \, Y \) in D \)$. To ignore $Y$, marginalize: $ f_X \( x \) = sum_y f_(X \, Y) \( x \, y \) quad upright("or") quad integral f_(X \, Y) \( x \, y \) thin d y . $ Swap $X \, Y$ to get $f_Y \( y \)$. For a joint function $g$, $E \[ g \( X \, Y \) \] = sum_(x \, y) g \( x \, y \) f_(X \, Y) \( x \, y \)$ or a double integral.

#text(fill: rgb("9A4D0B"), weight: "bold")[Use:] Fix $X = x$ and renormalize its slice; require $f_X \( x \) > 0$.

$ f_(Y divides X) \( y divides x \) = frac(f_(X \, Y) \( x \, y \), f_X \( x \)) \, #h(2em) f_(X \, Y) = f_X f_(Y divides X) . $ Conditional mean (regression function): $E \( Y divides X = x \) = sum_y y f_(Y divides X) \( y divides x \)$, or integrate in $y$. It predicts $Y$ from $X = x$ under squared error.

#text(fill: rgb("9A4D0B"), weight: "bold")[Independent variables:] $X perp Y arrow.l.r.double f_(X \, Y) \( x \, y \) = f_X \( x \) f_Y \( y \)$. Quick test: support is a product with no forbidden pairs, and $f_(X \, Y) = C thin g \( x \) h \( y \)$; $g \, h$ need not be PMFs/PDFs. Then $E \[ g_1 \( X \) h_1 \( Y \) \] = E \[ g_1 \( X \) \] E \[ h_1 \( Y \) \]$.

#text(fill: rgb("9A4D0B"), weight: "bold")[Use:] Measure joint linear movement or the variance of a sum.

$ "Cov" \( X \, Y \) = E \[ \( X - mu_X \) \( Y - mu_Y \) \] = E \( X Y \) - E \( X \) E \( Y \) \, $ $ "Var" \( a X + b Y \) = a^2 V \( X \) + b^2 V \( Y \) + 2 a b "Cov" \( X \, Y \) . $ $"Cov" \( a X + b \, c Y + d \) = a c "Cov" \( X \, Y \)$. Independence gives covariance zero, but zero covariance need not mean independence.

#text(fill: rgb("9A4D0B"), weight: "bold")[Independent difference:] If $X perp Y$, $V \( X + Y \) = V \( X - Y \) = V \( X \) + V \( Y \)$; the minus sign does not subtract variance.

For many variables: $V \( sum_i X_i \) = sum_i V \( X_i \) + 2 sum_(i < j) "Cov" \( X_i \, X_j \)$. $rho_(X \, Y) = "Cov" \( X \, Y \) \/ \( sigma_X sigma_Y \)$, where $sigma_X = sqrt(V \( X \))$; $- 1 lt.eq rho lt.eq 1$. Correlation is unit-free and measures linear association.

#heading(level: 1, numbering: none)[5. Discrete families]
<discrete-families>
Let $p = P \( upright("success") \)$, $q = 1 - p = P \( upright("failure") \)$; $n$ is fixed trials; $k$ is a target count; $x$ is the realized value. Bernoulli process: identical, independent trials.

#heading(level: 2, numbering: none)[Which count?]
<which-count>
#strong[Uniform:] $k$ equiprobable values $x_i$: $P \( X = x_i \) = 1 \/ k$, $E \( X \) = sum x_i \/ k$, $V \( X \) = sum x_i^2 \/ k - \[ E \( X \) \]^2$.

#strong[Bernoulli:] One success/failure trial: $X tilde.op upright("Bern") \( p \)$, $P \( X = x \) = p^x q^(1 - x)$, $x = 0 \, 1$; $E = p \, med V = p q$.

#strong[Binomial:] Successes in $n$ trials: $X tilde.op upright("Bin") \( n \, p \)$, $P \( X = x \) = binom(n, x) p^x q^(n - x)$, $x = 0 \, dots.h \, n$; $E = n p \, med V = n p q$.

#strong[Geometric:] Trials through first success ($k = 1$ in NB): $P \( X = x \) = q^(x - 1) p$, $x gt.eq 1$; $E = 1 \/ p \, med V = q \/ p^2$.

#strong[Negative binomial:] Trials until $k$th success: $P \( X = x \) = binom(x - 1, k - 1) p^k q^(x - k)$, $x gt.eq k$; $E = k \/ p \, med V = k q \/ p^2$.

#strong[Poisson:] Count in a fixed window: $P \( X = x \) = e^(- lambda) lambda^x \/ x !$, $x gt.eq 0$; $E = V = lambda$. For rate $r$ per unit and window $t$, $lambda = r t$; disjoint-window counts are independent in a Poisson process.

#text(fill: rgb("9A4D0B"), weight: "bold")[Rare binomial approximation:] For large $n$, small $p$, fixed $lambda = n p$: $upright("Bin") \( n \, p \) approx upright("Pois") \( lambda \)$.

#text(fill: rgb("9A4D0B"), weight: "bold")[Benford:] For the leading digit $D in { 1 \, dots.h \, 9 }$ of some scale-spanning data, $P \( D = d \) = log_10 \( 1 + 1 \/ d \)$; it is not a universal law for every dataset.

#heading(level: 1, numbering: none)[6. Continuous families]
<continuous-families>
#heading(level: 2, numbering: none)[Choose by the question]
<choose-by-the-question>
#strong[Uniform $U \( a \, b \)$:] Equal density over $\[ a \, b \]$: $f \( x \) = 1 \/ \( b - a \)$; $F \( x \) = \( x - a \) \/ \( b - a \)$ for $a lt.eq x lt.eq b$; $E = \( a + b \) \/ 2$, $V = \( b - a \)^2 \/ 12$. For $U tilde.op U \( 0 \, 1 \)$, $P \( U lt.eq u \) = u$, $0 lt.eq u lt.eq 1$.

#strong[Exponential $upright("Exp") \( lambda \)$:] Wait for the next event in a Poisson process with rate $lambda > 0$: $f \( x \) = lambda e^(- lambda x)$, $F \( x \) = 1 - e^(- lambda x)$, $P \( X > x \) = e^(- lambda x)$ for $x gt.eq 0$; $E = 1 \/ lambda$, $V = 1 \/ lambda^2$.

#strong[Normal $N \( mu \, sigma^2 \)$:] Symmetric bell shape, often for sums of many small independent effects: $f \( x \) = e^(- \( x - mu \)^2 \/ \( 2 sigma^2 \)) \/ \( sigma sqrt(2 pi) \)$; $E = mu \, med V = sigma^2$.

Exponential memorylessness: $P \( X > s + t divides X > s \) = P \( X > t \)$, $s \, t gt.eq 0$. $lambda$ is events per unit time; its reciprocal is the mean wait.

#text(fill: rgb("9A4D0B"), weight: "bold")[Pareto reset:] For $T tilde.op upright("Pareto") \( x_m \, alpha \)$, $P \( T > t \) = \( x_m \/ t \)^alpha$, $t gt.eq x_m$. It is not memoryless. If $alpha > 1$ and restarting costs nothing, a fresh run has smaller expected wait than continuing after $t > alpha x_m$; otherwise compare costs.

#text(fill: rgb("9A4D0B"), weight: "bold")[Rate reminder:] For exponential waits use the rate, not a count over an arbitrary window; if mean wait is $mu$, set $lambda = 1 \/ mu$.

#text(fill: rgb("9A4D0B"), weight: "bold")[Uniform annulus:] For a point uniform in area with radius $2 lt.eq R lt.eq 5$, $F_R \( r \) = \( r^2 - 4 \) \/ 21$ for $2 lt.eq r lt.eq 5$. To sample it, take $U tilde.op U \( 0 \, 1 \)$ and set $R = sqrt(4 + 21 U)$; start with $P \( R lt.eq r \)$.

#text(fill: rgb("9A4D0B"), weight: "bold")[Use:] Convert a normal value to standard normal $Z$ and read $Phi \( z \) = P \( Z lt.eq z \)$.

$ Z = \( X - mu \) \/ sigma tilde.op N \( 0 \, 1 \) \, #h(2em) P \( X lt.eq x \) = Phi \( \( x - mu \) \/ sigma \) . $ Normal symmetry: $Phi \( z \) = 1 - Phi \( - z \)$. Upper-tail cutoff $z_alpha$: $P \( Z gt.eq z_alpha \) = alpha$; $z_0.05 approx 1.645$, $z_0.025 approx 1.960$, $z_0.01 approx 2.326$.

#text(fill: rgb("9A4D0B"), weight: "bold")[Binomial to normal:] If $n p > 5$ and $n q > 5$ (guideline), approximate $X tilde.op upright("Bin") \( n \, p \)$ by $Y tilde.op N \( n p \, n p q \)$. Apply a $0.5$ continuity correction: $P \( X lt.eq k \) approx P \( Y < k + 0.5 \)$, $P \( X = k \) approx P \( k - 0.5 < Y < k + 0.5 \)$, and $P \( X > k \) approx P \( Y > k + 0.5 \)$.

]
