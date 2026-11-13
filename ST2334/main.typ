// Compile: typst compile main.typ main.pdf
// Authority: /home/sakthi/Downloads/lecturenotes-lean.md (chapters 1-7 + examples).
// Secondary: /home/sakthi/Documents/Obsidian Vault/100 Source Notes/Lectures/ST2334 Week {1-6,8-12} Video.md.
// Compared against /home/sakthi/Downloads/FormulaSheet_Tables.pdf: retain repeated
// formulas only as anchors for method selection, assumptions, or worked examples.
// Coverage audit: all 37 numbered subsections in lean chapters 1-7 mapped below.
// Ch1 -> §§1-2; Ch2 -> §3; Ch3 -> §4; Ch4 -> §§5-6;
// Ch5 -> §§7-8; Ch6 -> §§9-10; Ch7 -> §§9,11-12.
// Elementary axioms/counting, full family PMF/PDF/moments, joint expectation,
// covariance transforms and numerical tables are also on FormulaSheet_Tables.pdf.
// Named example-bank laws are in §3; R conventions are in §12.
// Extra proportion/variance CIs are secondary vault week 10 material.
// Semantic scan cues: teal labels, red pitfalls, pale-yellow decisive conditions.
#let cue-color = rgb("146267")
#let trap-color = rgb("A32935")
#let mark(body) = highlight(fill: rgb("FFF0B3"), body)
#let trap(body) = text(fill: trap-color, body)
#show strong: set text(fill: cue-color)
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
#set table(inset: (x: 1.5pt, y: 1pt), stroke: 0.3pt, fill: (x, y) => if y == 0 { rgb("EAF3F4") })
#show figure: set block(above: 2pt, below: 2pt)
#set page(numbering: none)
#set page(background: { for i in range(1, 3) { place(top + left, dy: 6mm, dx: 6mm + (285mm + 4mm) * i / 3 - 2.0mm, line(angle: 90deg, length: 198mm, stroke: 0.15pt + rgb("777777"))) } })
#set par(leading: 1.5pt, spacing: 1.1pt)
#show math.equation.where(block: true): set block(above: 2pt, below: 2pt)

#block(width: 100%, above: 0pt, below: 7pt)[#set par(justify: false)
#align(center)[#text(size: 11pt, weight: "bold", fill: rgb("174A74"))[ST2334: Probability and Statistics]#h(2em)#text(size: 6.5pt)[#text(fill: cue-color)[Teal: cues] · #trap[Red: traps] · #mark[Yellow: conditions]]]]

#columns(3)[
// Lean §§1.1-1.3; examples 1.8-1.33. Basic counting formulas: supplied formula sheet.
#heading(level: 1, numbering: none)[1. Events and counting strategies]
$S$: sample space; $A,B,C$: events; $A^c$: complement; $A inter B$: both; $A union B$: either. $P(A)=abs(A)/abs(S)$ requires #mark[equally likely outcomes]; counts need not be equally likely even when sequences are.

#strong[Choose a counting model:] #mark[Order matters] → permutations; #mark[order irrelevant] → combinations. Successive stages with fixed choice counts → multiply counts; disjoint cases → add counts. With replacement, $r$ ordered draws from $n$ choices give $n^r$. Consecutive objects → one block, then arrange within; alternating types → fix slots first. Identical objects → divide arrangements by factorials of repetition counts.

#strong[Restrictions:] Try all minus forbidden. “At least one” → $1-P("none")$. Example: #mark[15 picks without replacement] from 200 functions, 8 buggy:
$P("at least one bug")=1-binom(192,15)/binom(200,15)$.
For exactly $j$ buggy, use $binom(8,j)binom(192,15-j)/binom(200,15)$ ($j=0,...,8$). #trap[This is not a binomial experiment: draws are dependent.]

#strong[Overlaps:] $P(A union B)=P(A)+P(B)-P(A inter B)$. Three events: singles minus pairs plus triple. Disjoint positive-probability events cannot be independent. De Morgan: $(A union B)^c=A^c inter B^c$, $(A inter B)^c=A^c union B^c$.

#strong[Birthday versus target:] $k$ independent items in $m$ equally likely slots ($k<=m$):
$P("any collision")=1-product_(i=0)^(k-1)(1-i/m)$.
50% near $k=1.18sqrt(m)$. Collision with *one fixed target* instead has probability $1-(1-1/m)^k$; needs order $m$ attempts. Union bound: $P(union.big_i A_i)<=sum_i P(A_i)$ without independence; any-collision bound $binom(k,2)/m$.

// Lean §§1.4-1.6; examples 1.34-1.45.
#heading(level: 1, numbering: none)[2. Conditioning and independence]
#strong[Reduced sample space:] $P(B divides A)=P(A inter B)/P(A)$, requiring $P(A)>0$.

#strong[Chain before independence:]
$P(A inter B inter C)=P(A)P(B divides A)P(C divides A inter B)$.
If $B perp C$ *given* $A$, the final factor becomes $P(C divides A)$; #trap[count $P(A)$ once]. #trap[Ordinary independence need not survive conditioning.] For $A perp B$, $P(A inter B)=P(A)P(B)$; all complement pairings remain independent.

#strong[Total probability → Bayes:] Partition $S$ into disjoint exhaustive cases $A_i$; $k$ selects one case:
$ P(B)=sum_i P(A_i)P(B divides A_i), quad P(A_k divides B)=frac(P(A_k)P(B divides A_k),P(B)). $
Two cases: $P(B)=P(A)P(B divides A)+P(A^c)P(B divides A^c)$.

#strong[Base-rate example (1.44):] Bug prior $0.01$, flag sensitivity $0.75$, false-positive rate $0.0001$:
$P("bug" divides "flag")=frac(0.01 times 0.75,0.01 times 0.75+0.99 times 0.0001) approx 0.987$.
#trap[Sensitivity is not the posterior probability]. Simpson's paradox: subgroup comparisons may reverse in the aggregate because subgroup weights differ.

// Lean chapter 2; examples 2.4,2.18,2.23-2.35; independent minima: example 3.15.
#heading(level: 1, numbering: none)[3. CDFs, expectations and transformations]
$X$ is a random variable, $x$ its value, $f_X$ its PMF/PDF, $F_X (x)=P(X<=x)$ its CDF. CDF: nondecreasing, right-continuous, limits 0 and 1. A density may exceed 1; only its *integral* is probability. Discrete: countable values; continuous: $P(X=x)=0$, so endpoints do not matter.

#strong[Integer endpoints:] For integer $a<=b$,
$P(a<=X<=b)=F_X (b)-F_X (a-1)$;
$P(X>=a)=1-F_X (a-1)$, $P(X>a)=1-F_X (a)$.
For general discrete support replace $F_X (a-1)$ by the left limit $F_X (a^-)$. Jump $F_X (x)-F_X (x^-)=P(X=x)$.

#strong[Continuous / transform:] $f_X (x)=frac(d F_X (x),d x)$ where differentiable. To find the law of $Y=g(X)$, start with $F_Y (y)=P(g(X)<=y)$, solve the inequality within the support, then differentiate if appropriate. A quantile $x_p$ solves $F_X (x_p)=p$ when unique. Uniform in area does not mean uniform radius: radial distance $R$ in an annulus $2<=R<=5$ gives $F_R (r)=(r^2-4)/21$ on $[2,5]$ and $R=sqrt(4+21U)$ for $U tilde U(0,1)$.

#strong[Average a function $g$ directly:] $E(g(X))=sum_x g(x)f_X (x)$ or $integral g(x)f_X (x) dif x$. #mark[Linearity needs no independence]. $V(X)=E(X^2)-E(X)^2$, $V(a X+b)=a^2V(X)$ for constants $a,b$. For nonlinear $g$, $V(g(X))=E(g(X)^2)-E(g(X))^2$; #trap[not $g(V(X))$]. SD has $X$'s units; variance has squared units.
For nonnegative integer $X$, $E(X)=sum_(j=1)^oo P(X>=j)$; for nonnegative continuous $T$, $E(T)=integral_0^oo P(T>t) dif t$.

#strong[Slowest / fastest:] Independent $X_i$ with CDFs $F_i$, $i=1,...,m$; $M=max_i X_i$, $L=min_i X_i$:
$P(M<=t)=product_i F_i (t), quad P(L>t)=product_i [1-F_i (t)]$.
Two replicas each miss with probability $0.01$: first reply misses with probability $10^(-4)$; twice the load. #trap[Common failures invalidate the product.]

// Lean §2.4 and examples 2.7,2.9; distinct application concepts, absent from supplied sheet.
#strong[Size bias / inspection paradox:] Sampling an item overrepresents large groups or long gaps compared with sampling a group/gap uniformly. #mark[Identify the sampling unit] before averaging.
#strong[Entropy:] $H(X)=-sum_x f_X (x)log_2 f_X (x)$ bits (discrete); take $0 log_2 0=0$. Uniform probabilities maximize $H=log_2 m$ for $m$ possible values.
#strong[Named PMFs:] Zipf rank $x=1,...,m$: $f(x)=c/x$, $c=1/sum_(j=1)^m (1/j)$; $m$ is item count. Benford leading digit $D$: $P(D=d)=log_10(1+1/d)$, $d=1,...,9$. #trap[Benford is not universal]; it applies to suitable scale-spanning data.

// Lean §§3.1-3.4; examples 3.6-3.13. Marginal/conditional formulas also supplied.
#heading(level: 1, numbering: none)[4. Joint distributions and support]
#strong[Workflow:] Sketch support → normalize ($sum sum f=1$ or $integral integral f=1$) → intersect support with event → sum/integrate using those limits. Marginalize by removing the other variable; condition by fixing a slice and renormalizing. Limits may depend on the fixed value.
$ f_X (x)=integral f_(X,Y)(x,y) dif y, quad f_(Y divides X)(y divides x)=frac(f_(X,Y)(x,y),f_X (x)). $
Use sums for discrete variables; conditional ratio needs $f_X (x)>0$. $E(Y divides X=x)$ is the *regression function*: the conditional mean and best mean-squared-error predictor of $Y$ given $X=x$ (finite second moment).

#strong[Worked slice (3.13):] $f(x,y)=12x(x+y)/13$ on $0<x<1$, $1<y<2$; 0 otherwise. Then $f_X (x)=12x(x+1.5)/13$ and $f_(Y divides X)(y divides x)=(x+y)/(x+1.5)$ on the slice. At $x=0.5$, $P(Y<=1.5 divides X=0.5)=integral_1^(1.5)(0.5+y)/2 dif y=7/16$.

#strong[Independence check:] Require $f_(X,Y)(x,y)=f_X (x)f_Y (y)$ for all pairs. Factorization $C g(x)h(y)$ suffices only on #mark[*product support*] (no forbidden pairs). #trap[A factorized expression on triangular support is insufficient.]

#strong[Covariance / correlation:] $"Cov"(X,Y)=E(X Y)-E(X)E(Y)$; independence implies zero covariance, #trap[not conversely].
$V(a X+b Y)=a^2V(X)+b^2V(Y)+2 a b"Cov"(X,Y)$.
Independent sums *and differences* add variances. For many variables,
$V(sum_i X_i)=sum_i V(X_i)+2sum_(i<j)"Cov"(X_i,X_j)$.
$rho="Cov"(X,Y)/(sigma_X sigma_Y)$, where $sigma_X,sigma_Y$ are positive SDs: unit-free linear association, $-1<=rho<=1$. $rho=plus.minus 1$ means a perfect linear relation; zero correlation does not mean independence or no nonlinear relationship.

// Lean chapter 4; full PMF/PDF, mean and variance table is on the supplied sheet.
#heading(level: 1, numbering: none)[5. Distribution choice and conventions]
$p$: success probability; $q=1-p$; $n$: fixed number of trials; $k$: target successes. Bernoulli process requires #mark[independent trials with the same $p$].
#table(columns: (1fr,1.5fr),
  table.header([*Question*], [*Model / trap*]),
  [Equiprobable values $x_1,...,x_m$], [Discrete uniform; PMF $1/m$],
  [Constant density on $[a,b]$], [Uniform$(a,b)$; prob. $="length"/(b-a)$],
  [One success/failure trial], [Bernoulli$(p)$],
  [Successes in $n$ trials], [Binomial$(n,p)$; fixed $n$],
  [Trials through first success], [Geometric$(p)$; $x>=1$],
  [Trials through $k$th success], [NB$(k,p)$; $x>=k$],
  [Events in a fixed window], [Poisson$(r t)$; rate $r$, duration $t$],
  [Wait for next Poisson event], [Exponential$(r)$; mean $1/r$],
)
For arbitrary uniform values, $E(X)=sum_i x_i/m$, $V(X)=sum_i x_i^2/m-E(X)^2$. For NB, trial $x$ must succeed; first $x-1$ trials have $k-1$ successes → $binom(x-1,k-1)p^k q^(x-k)$. If a variable counts #mark[*failures*] before the $k$th success (R convention), subtract $k$ from the lecture trial-count variable; shift support/mean, keep variance. Geometric $P(X>j)=q^j$ for integer $j>=0$.

#strong[Rate versus count:] Poisson mean $lambda=r t$ is a count; exponential rate $r$ has inverse-time units. Rescale the window before using Poisson. Disjoint-window counts are independent in the process model. Exponential memorylessness: $P(T>s+t divides T>s)=P(T>t)$, $s,t>=0$; elapsed time does not change the remaining wait's distribution. Independent lifetimes exceeding $t$ with probability $p_t$ → survivor count Bin$(n,p_t)$; for exponential rate $r$, $p_t=e^(-r t)$.

#heading(level: 1, numbering: none)[6. Approximations and normal tails]
#strong[Binomial → Poisson:] Large $n$, small $p$, $lambda=n p$. Small individual probabilities matter. Example: Bin$(1000,0.0001)$ → Pois$(0.1)$; $P(X>=2) approx 1-e^(-0.1)(1+0.1)=0.00468$.

#strong[Binomial → normal:] If $n p>5$, $n q>5$ (guideline), use $Y tilde N(n p,n p q)$. #mark[Correct the *integer event* by 0.5] before standardizing:
#table(columns: (1fr,1fr),
  table.header([*Discrete event*], [*Normal event*]),
  [$a<=X<=b$], [$a-0.5<Y<b+0.5$],
  [$X<=k$ / $X<k$], [$Y<k+0.5$ / $Y<k-0.5$],
  [$X>=k$ / $X>k$], [$Y>k-0.5$ / $Y>k+0.5$],
  [$X=k$], [$k-0.5<Y<k+0.5$],
)
Here $a,b,k$ are integers. Standardize using SD $sqrt(n p q)$, not variance $n p q$.

#strong[Normal notation:] $X tilde N(mu,sigma^2)$ → $Z=(X-mu)/sigma tilde N(0,1)$. $Phi(z)=P(Z<=z)$; right tail $1-Phi(z)$; $Phi(-z)=1-Phi(z)$. Quantile $z_alpha$ has *upper* area $alpha$. For $P(X>x)=alpha$, solve $x=mu+sigma z_alpha$. The second parameter of $N$ is #trap[variance, not SD].

// Lean §§5.1-5.3; vault week 8 clarifies finite SRS dependence and SD vs SE.
#heading(level: 1, numbering: none)[7. Sampling, sums and CLT]
Population = all units/outcomes of interest; sample = selected observations. A *parameter* is a fixed population quantity; a *statistic* is a function of the sample, random before observing data. Upper case ($overline(X),S^2$) is random; lower case ($overline(x),s^2$) is observed. iid = independent, identically distributed observations. Repeated-sample law = *sampling distribution*.

#strong[Sampling design:] SRS without replacement from $N$ units gives each of the $binom(N,n)$ size-$n$ subsets equal probability; draws are dependent. With replacement from a fixed distribution gives iid draws. Large sample size cannot repair biased sampling or dependence.

For iid $X_i$, $i=1,...,n$, with population mean $mu$, variance $sigma^2$ ($0<sigma^2<oo$), let $Q=sum_(i=1)^n X_i$ be the total:
$ overline(X)=Q/n, quad S^2=frac(sum_(i=1)^n (X_i-overline(X))^2,n-1). $
$ E(overline(X))=mu, quad V(overline(X))=sigma^2/n, quad "SE"(overline(X))=sigma/sqrt(n). $
$E(Q)=n mu$, $V(Q)=n sigma^2$, $"SD"(Q)=sigma sqrt(n)$.
$E(S^2)=sigma^2$ for iid finite variance, even if nonnormal ($n>=2$). Compute $s^2=(sum_i x_i^2-n overline(x)^2)/(n-1)$; the $n-1$ reflects one fitted mean. SD describes observations; SE is the SD of a statistic (estimated by $s/sqrt(n)$ if $sigma$ is unknown).

#strong[Mean versus total:] Exact if population normal; approximately for large $n$ by CLT:
$overline(X) approx N(mu,sigma^2/n)$; $Q approx N(n mu,n sigma^2)$.
$P(overline(X)>a) approx 1-Phi((a-mu)sqrt(n)/sigma)$;
$P(Q>b) approx 1-Phi((b-n mu)/(sigma sqrt(n)))$.
$a,b$: mean/total thresholds; standardized statistics are unit-free.

#strong[CLT versus LLN:] CLT gives an approximately normal *standardized mean*, not normal raw data. LLN gives $P(abs(overline(X)-mu)>epsilon) -> 0$ for each fixed tolerance $epsilon>0$. Neither guarantees that every successive average is closer to $mu$.

#strong[How large?] Notes use $n>=30$ for large-sample inference; shape matters. Strong skew/outliers may need far more; independence and finite variance still matter. For two samples, assess *both* sizes; for pairs, count pairs.

#mark[Halving SE needs $4n$], #trap[not $2n$].

// Lean §§5.4-5.6; examples 5.13, 5.17, 5.20. Vault week 9: mean/variance independence.
#block(breakable: false)[
#heading(level: 1, numbering: none)[8. Sampling laws and tail tables]
#strong[Notation:] $nu,m,k$ below are positive integer degrees of freedom (df); $alpha$ is a tail probability. All critical values here use *upper tails*: $P(W>w_alpha)=alpha$, so the CDF quantile is at $1-alpha$. For normal and $t$, lower cutoff is $-w_alpha$; this sign shortcut fails for $chi^2$ and $F$.
]

#strong[Chi-squared:] Independent $Z_j tilde N(0,1)$, $j=1,...,nu$:
$ U=sum_(j=1)^nu Z_j^2 tilde chi^2(nu), quad E(U)=nu, quad V(U)=2nu. $
Nonnegative, right-skewed. Independent chi-squared variables add df. For iid #mark[*normal*] observations,
$U=(n-1)S^2/sigma^2 tilde chi^2(n-1)$.
Also $overline(X) perp S^2$ under normal sampling. #trap[Unbiased $S^2$ alone does not imply a chi-squared law.]

#strong[Variance-tail example (5.13):] $n=6$, $sigma^2=4$ $"ms"^2$. Find $c$ with $P(S^2>c)=0.05$:
$5c/4=chi^2(5;0.05)=11.07 arrow.r c=8.856 " ms"^2$.
For $P(S^2<c)=0.05$, use the upper-tail $0.95$ cutoff instead.

#strong[Student's t:] If $Z tilde N(0,1)$ and $U tilde chi^2(nu)$ are independent,
$T=Z/sqrt(U/nu) tilde t(nu)$.
Symmetric, heavier tails than normal; approaches normal as $nu$ grows. Under iid normal sampling,
$ T=frac(sqrt(n)(overline(X)-mu),S) tilde t(n-1). $
Exact for normal samples, any $n>=2$; estimated $sigma$ makes the denominator random.

#strong[F ratio:] Independent $U tilde chi^2(m)$, $V tilde chi^2(k)$:
$F=(U/m)/(V/k) tilde F(m,k)$.
For two independent normal samples,
$(S_1^2/S_2^2)(sigma_2^2/sigma_1^2) tilde F(n_1-1,n_2-1)$.
#mark[Numerator df comes first]. #trap[Reverse the ratio → swap df].
$F(m,k;1-alpha)=1/F(k,m;alpha)$.


// Lean §§6.1-6.5,7.3,7.6-7.7; vault weeks 10-12.
// SE table is deliberately retained despite supplied formulas: shared CI/test selection.
#heading(level: 1, numbering: none)[9. Choose one method for CI and test]
Let $theta$ be the target population mean/difference; $hat(theta)$ its observed estimate; $theta_0$ its null value; $e$ the observed standard error; $c$ the critical value. One shared calculation:
$ "CI": hat(theta) plus.minus c e, quad w=frac(hat(theta)-theta_0,e). $
Here $z$ denotes the standard normal reference law. For a $100(1-alpha)%$ two-sided CI, use $c=z_(alpha/2)$ or $t_(nu;alpha/2)$ according to the row. Use the #mark[*same* SE and reference law] for the test. $w$ is the observed unit-free statistic.

#strong[One mean:] $theta=mu$, $hat(theta)=overline(x)$.
#block(breakable: false)[#table(columns: (1.8fr, 1fr, 0.9fr),
  table.header([*Conditions*], [*$e$*], [*Law*]),
  [Known $sigma$; normal or large $n$], [$sigma/sqrt(n)$], [$z$],
  [Unknown $sigma$; normal], [$s/sqrt(n)$], [$t(n-1)$],
  [Unknown $sigma$; large $n$], [$s/sqrt(n)$], [Approx. $z$],
)]
#trap[Known $sigma$ alone does not justify a small nonnormal sample]. Given variance → take its square root for SD.

#block(breakable: false)[
#strong[Two independent means:] $theta=mu_1-mu_2$, $hat(theta)=overline(x)_1-overline(x)_2$. For group $j=1,2$, $n_j$ is its size, $s_j^2$ its sample variance, $sigma_j^2$ its population variance.
#table(columns: (1.6fr, 1.4fr, 0.9fr),
  table.header([*Conditions*], [*$e$*], [*Law*]),
  [Known variances; normal or both large], [$sqrt(sigma_1^2/n_1+sigma_2^2/n_2)$], [$z$],
  [Unknown, unequal; both large], [$sqrt(s_1^2/n_1+s_2^2/n_2)$], [Approx. $z$],
  [Unknown, equal; normal], [$s_p sqrt(1/n_1+1/n_2)$], [$t(n_1+n_2-2)$],
  [Unknown, equal; both large], [$s_p sqrt(1/n_1+1/n_2)$], [Approx. $z$],
)
]
$ s_p^2=frac((n_1-1)s_1^2+(n_2-1)s_2^2,n_1+n_2-2), quad s_p=sqrt(s_p^2). $
Pool #mark[*variances*, weighted by df], not SDs or an unweighted average. Equal population variance must be justified; the notes' $1/2<=s_1/s_2<=2$ is only a rough diagnostic. Normal pooled $t$ is exact even if a sample is large. Small, unequal-variance samples are outside the listed lecture procedures; #trap[do not silently pool].

#strong[Matched pairs:] Same subject/unit twice or meaningful matching → define $D_i=X_i-Y_i$ consistently; $n$ is the *number of pairs*. Analyze the one sample of differences:
$ theta=mu_D=mu_1-mu_2, quad hat(theta)=overline(d)=sum_(i=1)^n d_i/n, $
$ s_D^2=frac(sum_(i=1)^n(d_i-overline(d))^2,n-1), quad e=s_D/sqrt(n). $
Use $t(n-1)$ for normal differences, or approximate $z$ for large $n$. Pairs must be independent across $i$; dependence within a pair is allowed. Normality applies to *differences*. #trap[Do not replace $s_D^2$ by $s_1^2+s_2^2$]: covariance matters.

#strong[Units:] Estimates, SE and CI endpoints use response units; variances use squared units; df and probabilities are unit-free.

// Lean §§6.1-6.4; examples 6.7,6.11,6.17.
#heading(level: 1, numbering: none)[10. Estimation and precision]
An estimator $hat(Theta)$ is *unbiased* for fixed $theta$ if $E(hat(Theta))=theta$. Among unbiased estimators, lower variance is preferable. Example: $X_i tilde U(0,theta)$ gives $E(overline(X))=theta/2$, so $2overline(X)$ estimates $theta$ without bias. $overline(X)$ estimates $mu$; $S^2$ estimates $sigma^2$.

#strong[CI interpretation:] In repeated random samples, a $100(1-alpha)%$ CI procedure covers the fixed parameter a proportion $1-alpha$ of the time. The realized endpoints are fixed; do not assign this probability to the parameter after seeing the interval. A CI for the *mean* is not a range containing that proportion of individual observations.

#strong[Margin / sample size:] For known $sigma$, normal or sufficiently large $n$, margin $E=z_(alpha/2)sigma/sqrt(n)$. To target margin $E_0>0$,
$ n_min=ceil((z_(alpha/2)sigma/E_0)^2). $
$ceil(dot)$ means round up to the next integer. $E,E_0,sigma$ have response units. Unknown $sigma$ → prior/pilot planning SD. Higher confidence → wider CI; larger $n$ → narrower CI; halving margin needs $4n$.



#strong[One-mean CI (6.11):] Normal memory usage, $n=7$, $overline(x)=10$ GB, #mark[$s^2=0.08$] $"GB"^2$:
$10 plus.minus t_(6;0.025) sqrt(0.08)/sqrt(7) = 10 plus.minus 0.262 = (9.738,10.262) " GB"$.
Use $s=sqrt(0.08)$, not $0.08$.

// Secondary vault week 10: approximate Wald interval for a Bernoulli proportion.
#strong[Proportion CI (vault):] $X$ successes in $n$ iid Bernoulli trials, $hat(p)=X/n$; $p$ is the population success probability. With enough successes and failures (roughly $n hat(p),n(1-hat(p))>=5$), approximate $100(1-alpha)%$ CI:
$hat(p) plus.minus z_(alpha/2)sqrt(hat(p)(1-hat(p))/n)$.
#trap[Poor near 0/1 or with small counts]. Target dimensionless margin $E_0$: $n=ceil(z_(alpha/2)^2 p_*(1-p_*)/E_0^2)$, with prior estimate $p_*$, or conservative $p_*=0.5$ if unknown. #trap[Approximate planning, not exact coverage].


// Secondary vault week 10 extension; derived from authoritative §5.4 pivot.
#block(breakable: false)[
#strong[Variance CI (normal iid only):] A quick inversion of the $chi^2$ pivot gives
$ (frac((n-1)s^2,chi^2(n-1;alpha/2)), frac((n-1)s^2,chi^2(n-1;1-alpha/2))). $
This is a $100(1-alpha)%$ CI for $sigma^2$; take square roots for a CI for $sigma$. #mark[Larger critical value] goes in the #mark[*lower* endpoint's denominator]. No symmetric $plus.minus$ form.
]

// Lean §§7.1-7.8; examples 7.6-7.9,7.15; vault weeks 11-12 for interpretation.
// Example 7.8 p-value recomputed from s^2=6.5 (0.0062445); source rounds to 0.0063.
#heading(level: 1, numbering: none)[11. Hypothesis tests: direction and evidence]
State the target and hypotheses about *parameters*, choose $alpha$ and direction before seeing the result, check model/design, compute $w$ using §9, then report the $p$-value and a conclusion in context. Under $H_0:theta=theta_0$, let $W$ have the selected standard normal or $t(nu)$ law. Let $G(w)=P(W<=w)$ and $w_gamma$ satisfy $P(W>w_gamma)=gamma$.

#table(columns: (0.7fr, 1fr, 1.3fr),
  table.header([*$H_1$*], [*Reject if*], [*$p$-value*]),
  [$theta>theta_0$], [$w>w_alpha$], [$1-G(w)$],
  [$theta<theta_0$], [$w<-w_alpha$], [$G(w)$],
  [$theta!=theta_0$], [$abs(w)>w_(alpha/2)$], [$2(1-G(abs(w)))$],
)
The notes use strict rules: reject if $p<alpha$; otherwise #mark[*fail to reject*]. #mark[Keep the signed $w$] for a one-sided test. If evidence points opposite $H_1$, the one-sided $p$-value exceeds $0.5$; #trap[do not halve a two-sided $p$-value blindly].

#strong[Critical-value check:] At 5% two-sided, $z_(alpha/2)=1.960$; at 5% one-sided, $z_alpha=1.645$. At 1% two-sided use $z_0.005=2.576$, not $z_0.01=2.326$. For $t$, use the correct df and tail column.

#strong[CI ↔ test:] A #mark[matching two-sided] level-$alpha$ test rejects iff the $100(1-alpha)%$ CI excludes $theta_0$ (same model, SE and df). Boundary is included under the notes' strict rejection rule. A 95% two-sided CI matches a 5% two-sided test, not a 5% one-sided test.

#strong[What the p-value says:] Under $H_0$, probability of a statistic at least as extreme in the specified direction(s). It is not $P(H_0 " true" divides "data")$, not an effect size, and not the probability that the result was due to chance. Failure to reject is insufficient evidence against $H_0$; #trap[it does not prove no effect]. Statistical significance alone does not show practical importance.

#strong[Same data, different uncertainty (7.7-7.8):] Scores $20,19,24,22,25$, assumed normal; $overline(x)=22$, $n=5$, test $mu_0=16$ two-sided at $alpha=0.01$.
#table(columns: (1fr, 1.2fr, 1fr),
  table.header([*Variance info*], [*Statistic / cutoff*], [*$p$ / decision*]),
  [Known $sigma^2=5$], [$z=6$; $2.576$], [$1.97 times 10^(-9)$; reject],
  [Unknown; $s^2=6.5$], [$t=5.26$; $t_(4;0.005)=4.604$], [$0.00624$; reject],
)
#trap[Do not use a normal tail for a small-sample $t$ statistic], even when the statistic looks large.

#strong[Paired test (7.15):] Choose $D=$ after minus before throughput (requests/s). For 8 independent normal differences, $overline(d)=24.25$, $s_D=25.39$; $H_0:mu_D=0$, $H_1:mu_D>0$.
$t=24.25/(25.39/sqrt(8))=2.70>t_(7;0.05)=1.895$, $p=0.0153<0.05$: reject; evidence of increased mean throughput. 

#heading(level: 1, numbering: none)[12. Errors, power and final checks]
#table(columns: (1fr, 1.1fr, 1.1fr),
  table.header([*Reality*], [*Fail to reject*], [*Reject*]),
  [$H_0$ true], [Correct: $1-alpha$], [Type I: $alpha$],
  [$H_0$ false at $theta_1$], [Type II: $beta$], [Power: $1-beta$],
)
$alpha=P("reject" divides H_0 " true")$;
$beta=P("fail to reject" divides theta=theta_1)$ for a *specified* alternative $theta_1$. At fixed sample size/effect, reducing $alpha$ generally increases $beta$; more data can raise power at fixed $alpha$.

// Lean example 7.5: exact error probabilities from a discrete rejection region.
#strong[Exact error calculation (7.5):] $X tilde "Bin"(20,p)$; reject $H_0:p=0.25$ if $X>8$. Then $alpha=P_(p=0.25)(X>=9)=0.0409$. At alternative $p=0.5$, $beta=P_(p=0.5)(X<=8)=0.2517$, power $=0.7483$. #mark[Use the null for $alpha$, the specified alternative for $beta$]; use exact binomial tails here.

// Lean §9, examples 5.2,5.12,5.15,5.18: generic convention, not a full software table.
#strong[R:] `d*`: PMF/PDF; `p*`: CDF; `q*`: quantile; `lower.tail=FALSE`: upper tail.

]
