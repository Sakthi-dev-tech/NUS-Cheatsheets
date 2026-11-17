// Compile: typst compile main.typ main.pdf
// Source: /home/sakthi/Downloads/lecturenotes-lean.md, chapters 1-7 + examples.
// Secondary: Obsidian Vault/100 Source Notes/Lectures/ST2334 Week {1-6,8-12} Video.md.
// Distribution audit: Obsidian Vault/300 Main Notes/{Student t Distribution,
// F Distribution, Chi-Squared Distribution, Normal Distribution (Bell Curve),
// Discrete Uniform Distribution, Continuous Uniform Distribution, Bernoulli Trial,
// Bernoulli Process, Binomial Distribution, Geometric Distribution,
// Negative Binomial Distribution, Poisson Distribution, Exponential Distribution,
// Normal Variable Distributions, Choosing Distributions and Statistical Inference - Master Note}.
// Checked embedded week 5 Bernoulli summary and week 6 continuous summary.
// Arbitrary discrete-uniform variance notation corrected against the slide table.
// Deduplicated against /home/sakthi/Downloads/FormulaSheet_Tables.pdf (2026-11-16).
// FS references below use PDF page numbers, not the statistical tables' printed pages.
// Standard identities, distribution PMF/PDF/moments and mean CI/test formulas are
// referenced rather than copied. Numerical applications and intermediate derivation
// steps are retained. New CDF/quantile/power formulas follow directly by integration.
// Chapters: 1 -> §§1-2; 2 -> §§3,6; 3 -> §4; 4 -> §5;
// 5 -> §§7-8; 6 -> §§9-10; 7 -> §§9,11-12. No new syllabus topics added.
#let cue-color = rgb("146267")
#let trap-color = rgb("A32935")
#let mark(body) = highlight(fill: rgb("FFF0B3"), body)
#let trap(body) = text(fill: trap-color, body)
#let fs(body) = text(size: 7.3pt, fill: rgb("555555"))[↗ FS #body]
#show strong: set text(fill: cue-color)
#set document(title: "ST2334 Cheatsheet")
#set page(paper: "a4", flipped: true, margin: 6mm, numbering: none)
#set text(font: "New Computer Modern", size: 8pt, top-edge: "ascender", bottom-edge: "descender")
#set par(leading: 0.7pt, spacing: 0.8pt, first-line-indent: 0pt, justify: false)
#set columns(gutter: 4mm)
#set list(indent: 0pt, body-indent: 1em, spacing: 1pt, tight: true)
#set enum(indent: 0pt, body-indent: 1.3em, spacing: 1pt, tight: true)
#set heading(numbering: none)
#show heading.where(level: 1): it => block(above: 3pt, below: 1.5pt, sticky: true)[#text(size: 10pt, weight: "bold", fill: rgb("174A74"), it.body)]
#show heading.where(level: 2): it => block(above: 1.6pt, below: 1pt, sticky: true)[#text(size: 8.3pt, weight: "bold", fill: cue-color, it.body)]
#show raw: set text(font: "Nimbus Mono PS", size: 7pt)
#show math.equation.where(block: true): set block(above: 1.5pt, below: 1.5pt)
#set table(inset: (x: 2pt, y: 1.5pt), align: left + horizon, stroke: 0.3pt, fill: (x, y) => if y == 0 { rgb("EAF3F4") })
#set page(background: { for i in range(1, 3) { place(top + left, dy: 6mm, dx: 6mm + (285mm + 4mm) * i / 3 - 2mm, line(angle: 90deg, length: 198mm, stroke: 0.15pt + rgb("999999"))) } })

#align(center)[#text(size: 12pt, weight: "bold", fill: rgb("174A74"))[ST2334 · Methods, missing formulas & exam traps]]
#v(2pt)
#text(size: 7.5pt)[*Use with FormulaSheet_Tables.pdf.* FS = supplied sheet, *PDF page*. p1: probability/distributions; p2 §1: one mean, §2: two means/pooled variance; p3: normal/Poisson CDF; p6: $t$; pp7–12: $F$; p13: $chi^2$. Teal: cues · #trap[Red: traps] · #mark[Yellow: conditions].]
#v(3pt)

#columns(3)[
// Lean §§1.1-1.3; examples 1.8-1.33.
= 1. Counting: choose the experiment
#fs[p1 · Counting and events]
== Model first
Order matters → permutations; irrelevant → combinations. Consecutive objects → block, then arrange inside. Alternating types → fill fixed slots. Successive stages → multiply; disjoint cases → add. Restrictions → all minus forbidden.

#trap[Equally likely sequences need not give equally likely counts.]

== Without replacement: count subsets
*Example:* 15 picks from 200 functions, 8 buggy. Let $J$ count bugs:
$P(J>=1)=1-binom(192,15)/binom(200,15)$; exactly $j$ bugs: $binom(8,j)binom(192,15-j)/binom(200,15)$, $j=0,...,8$.
#trap[Dependent draws: do not use a binomial model.]

== Birthday paradox: any matching pair
$k$ independent items; $m$ equally likely slots; $k<=m$:
$ P("any collision")=1-product_(i=0)^(k-1)(1-i/m). $
50% threshold $k approx 1.18sqrt(m)$; union-bound estimate $binom(k,2)/m$ (cap at 1).

For $k/m$ small: $P("any match") approx 1-e^(-k(k-1)/(2m))$. Independent uniform birthdays, no leap days: #mark[23 people → 50.7% chance of a match] (22 → 47.6%); $binom(23,2)=253$ pairs. If $k>m$, a match is certain.

Collision with *one fixed target*: $1-(1-1/m)^k$; needs order $m$ attempts, versus $sqrt(m)$ for any pair.

// Lean §§1.4-1.6; examples 1.34-1.45.
= 2. Conditioning: choose the denominator
#fs[p1 · Conditional probability and independence]
== Bayes workflow
Partition into disjoint exhaustive causes → prior × likelihood → normalize over causes.

*Flag example:* bug prior 0.01; sensitivity 0.75; false-positive rate 0.0001:
$ P("bug" divides "flag")=frac(0.01 times 0.75,0.01 times 0.75+0.99 times 0.0001) approx 0.987. $
#trap[Sensitivity is not the posterior probability.]

== Independence pitfalls
Chain rule first. Conditional independence given $A$ → count $P(A)$ once. Ordinary independence may disappear after conditioning. Simpson's paradox: subgroup weights can reverse aggregate comparisons.

// Lean §§2.1-2.3; examples 2.18,2.23-2.35.
= 3. CDFs, transformations & moments
#fs[p1 · One random variable]
== Small f versus capital F
*f*: mass (discrete) / density (continuous). *F*: accumulated probability. Continuous point probability is zero; density may exceed 1. Relations → FS p1.

== Integer endpoints
Integer $X$; integer bounds $a<=b$:
$ P(a<=X<=b)=F_X (b)-F_X (a-1), $
$P(X>a)=1-F_X (a)$. “At least” → previous integer before upper-tail lookup (FS p3). Noninteger support → previous support point / left limit.

== Transform first, then differentiate
$Y=g(X)$ → $F_Y (y)=P(g(X)<=y)$. Solve on the support; split cases for nonmonotone $g$, then differentiate (FS).

*Uniform area ≠ uniform radius:* annulus $2<=R<=5$:
$F_R (r)=(r^2-4)/21$ on $[2,5]$; generate $R=sqrt(4+21U)$ with dimensionless $U tilde U(0,1)$; $R,r$: radius.

== Moments / tail shortcut
Average $g(X)$ and $g(X)^2$ using FS expectation/variance. #mark[Linearity needs no independence.] Nonlinear $g$: #trap[variance is not $g(V(X))$]. SD has observation units; variance has squared units.

Nonnegative $T$ with finite mean:
$E(T)=integral_0^oo P(T>t) dif t$.

// Lean §§3.1-3.4; examples 3.13,3.15.
= 4. Joint laws: support before algebra
#fs[p1 · Joint distributions]
== Integration workflow
Sketch support → normalize → intersect event → integrate. Marginal: remove variable. Conditional: renormalize slice; marginal positive.

*Slice example:* $f(x,y)=12x(x+y)/13$ on $(0,1) times (1,2)$. At $x=0.5$, conditional density $(0.5+y)/2$ on $(1,2)$ gives $P(Y<=1.5 divides X=0.5)=7/16$.
Conditional mean = regression function / best mean-squared-error predictor (finite second moment).

== Factorization also needs product support
#mark[No forbidden pairs:] separate normalized factors identify independent marginals. #trap[A factorized expression on triangular support is insufficient.]

*Example:* $x>0,y>0$, density zero elsewhere:
$ 2e^(-4x-y/2)=(4e^(-4x))(1/2 e^(-y/2)). $
Rates multiply to 2 → independent $X tilde "Exp"(4)$, $Y tilde "Exp"(1/2)$. FS moments: $E(X)=1/4$, $V(X)=1/16$; $E(Y)=2$, $V(Y)=4$.

== More than two variables
For variables $X_i$, $i=1,...,m$, with finite variances:
$ V(sum_i X_i)=sum_i V(X_i)+2sum_(i<j)"Cov"(X_i,X_j). $
Zero covariances → add variances. Correlation measures *linear* association; $rho=plus.minus 1$ means perfect linear relation (positive SDs).

== Fastest / slowest of independent variables
$F_i$: CDF of $X_i$; $L=min_i X_i$, $M=max_i X_i$:
$ P(M<=t)=product_i F_i (t), quad P(L>t)=product_i [1-F_i (t)]. $
Independent exponentials, rates $lambda_i>0$ → $L tilde "Exp"(sum_i lambda_i)$.
Two replicas each miss with probability 0.01 → first reply misses with probability $10^(-4)$. #trap[Shared failures invalidate the product.]

// Lean chapter 4; CDF/quantile entries derived from the listed families.
= 5. Distribution recognition & extra patterns
#fs[p1 · Common distributions; Poisson process and approximations]
== Choose what is counted
0/1 trial → Bernoulli; successes → Binomial; trials to first / $k$th success → Geometric / NB; fixed-window events → Poisson; next-event wait → Exponential. Equal listed values / constant interval density → discrete / continuous uniform.

Binomial/Geometric/NB need #mark[independent trials, same success probability]. NB: final trial succeeds.

== Discrete uniform on arbitrary values
FS p1 assumes $1,...,m$. For any $m$ equally likely values $x_i$ ($m$: count; $mu$: mean):
$mu=sum_i x_i/m$, $V(X)=sum_i x_i^2/m-mu^2$. Binomial with one trial = Bernoulli; NB with one target = Geometric.

== Conventions that change answers
*Trials versus failures:* R counts failures; subtract target successes from lecture variable. Shift mean/support, keep variance.

*Rate/scale:* $lambda>0$: inverse time; $beta=1/lambda$: mean/scale. Larger rate → shorter wait. Poisson parameter: expected *count*, rescale window. Memorylessness → FS p1.

*Normal:* symmetric about $mu$; inflections $mu plus.minus sigma$. Second parameter: *variance*. Normal mean ≠ normal raw data.

#block(breakable: false)[
== CDF / inverse patterns absent from FS
$F$: CDF; $x_p$: quantile, $0<p<1$; $Phi$: standard normal CDF. $a<b$: bounds; $mu$: mean; $sigma>0$: SD. All except $p,F,Phi$ have observation units; rate $lambda$: inverse units.
#table(columns: (0.8fr, 1.2fr, 1fr),
  table.header([*Law*], [*$F(x)$ on support*], [*$x_p$*]),
  [Uniform], [$ (x-a)/(b-a) $], [$ a+p(b-a) $],
  [Exp.], [$ 1-e^(-lambda x) $], [$ -ln(1-p)/lambda $],
  [Normal], [$ Phi((x-mu)/sigma) $], [$ mu+sigma Phi^(-1)(p) $],
)
]
CDF is 0 below support, 1 above finite support. #trap[Match support as well as coefficients.]

*Power pattern:* $c>0$ is an upper bound; $k>0$ is dimensionless shape. For $0<x<c$ (PDF zero elsewhere),
$ f(x)=k x^(k-1)/c^k, quad F(x)=(x/c)^k, quad x_p=c p^(1/k). $
Example: $f(x)=3x^2$ on $(0,1)$ → $F(x)=x^3$.

== Exponential moments: integration trick
Final moments → FS p1. Define
$ I_j=integral_0^oo x^j e^(-lambda x) dif x, quad I_0=1/lambda. $
Parts: $u=x^j$, $v=-e^(-lambda x)/lambda$ gives
$I_j=(j/lambda) I_(j-1)$, $j=1,2,...$.
Boundary terms vanish; moments $lambda I_1$, $lambda I_2$ → FS variance. $j$: nonnegative integer; $I_j$ units: observation units to $j+1$.

== Approximation & continuity correction
Approximating laws → FS p1. Poisson: *small individual probabilities*. Normal: $n p>5$, $n(1-p)>5$ (guideline), where $n$ is trials and $p$ success probability. Correct event *before* standardizing.

$X$: integer count; $Y$: normal approximation; $k$: integer cutoff. Interval rule → FS p1.
#table(columns: (1fr, 1fr),
  table.header([*Discrete event*], [*Normal event*]),
  [$X<=k$ / $X<k$], [$Y<k+0.5$ / $Y<k-0.5$],
  [$X>=k$ / $X>k$], [$Y>k-0.5$ / $Y>k+0.5$],
  [$X=k$], [$k-0.5<Y<k+0.5$],
)

// Lean §2.4, examples 2.7,2.9; earlier named example-bank coverage retained.
= 6. Other lecture patterns
== Entropy, ranks & leading digits
Discrete entropy in bits; $m$: number of possible values:
$H(X)=-sum_x f_X (x)log_2 f_X (x)$; $0 log_2 0=0$.
Uniform probabilities maximize entropy at $log_2 m$.

*Zipf:* rank $x=1,...,m$, normalization constant $c$:
$f(x)=c/x$, $c=1/(sum_(j=1)^m 1/j)$.
*Benford:* leading digit $D=d$, $d=1,...,9$:
$P(D=d)=log_10(1+1/d)$.
Applies to suitable scale-spanning data; not universal.

== Size bias / inspection paradox
Items overrepresent large groups; random times overrepresent long gaps. #mark[Identify the sampling unit] before averaging.

// Lean §§5.1-5.3; secondary week 8 sampling-design explanation.
= 7. Sampling, sums & CLT
== Sampling design
*Parameter:* fixed population quantity. *Statistic:* sample function; uppercase random, lowercase observed. iid = independent, identically distributed.

Without replacement: equally likely subsets, dependent draws. With replacement: iid draws. #trap[Large n cannot repair bias or dependence.]

== Mean versus total
$X_i$, $i=1,...,n$: iid observations; population mean $mu$, variance $sigma^2>0$; $Q$: total; $S^2$: sample variance.
$overline(X)=Q/n$, $Q=sum_(i=1)^n X_i$; $S^2=sum_i (X_i-overline(X))^2/(n-1)$.
#table(columns: (0.8fr, 1fr, 1fr),
  table.header([*Statistic*], [*Mean*], [*Variance*]),
  [$overline(X)$], [$mu$], [$ sigma^2/n $],
  [$Q$], [$n mu$], [$n sigma^2$],
)
Normal population → exact; otherwise CLT approximation (large $n$, finite variance).

For mean threshold $a$ or total threshold $b$:
$ P(overline(X)>a) approx 1-Phi((a-mu)sqrt(n)/sigma), $
$ P(Q>b) approx 1-Phi((b-n mu)/(sigma sqrt(n))). $
#trap[Standardize with SD, never variance.]

== SD, SE & sample variance
SD: observation spread. SE: SD of a statistic.
$ "SE"(overline(X))=sigma/sqrt(n), quad E(S^2)=sigma^2, $
$ s^2=(sum_i x_i^2-n overline(x)^2)/(n-1). $
$x_i,overline(x),s^2$: observed data, mean, variance; $s$ estimates $sigma$. Unbiased variance needs iid finite variance, not normality.

== CLT versus LLN
CLT: standardized mean → normal. LLN: tolerance $epsilon>0$,
$P(abs(overline(X)-mu)>epsilon)->0$ as $n->oo$.
Neither guarantees improvement each step. Large $n>=30$ is a guideline; skew/tails may need more. Check both groups; count pairs. #mark[Half the SE → four times n.]

// Lean §§5.4-5.6; normal-sample independence from secondary week 9.
= 8. Sampling laws & table direction
#fs[p6 · t; pp7–12 · F; p13 · chi-squared]
== Upper tails and degrees of freedom
$w_alpha$: upper-tail cutoff, area $alpha$ (CDF $1-alpha$). $nu,m,k$: positive integer df. Normal/$t$: negate for lower cutoff. #trap[Do not negate chi-squared/F cutoffs.]

== Chi-squared: sums of squares / variance
Independent $Z_j tilde N(0,1)$, $j=1,...,nu$:
$ U=sum_(j=1)^nu Z_j^2 tilde chi^2(nu), quad E(U)=nu, quad V(U)=2nu. $
Nonnegative, right-skewed (not necessarily mostly above mean). $E(Z_j^2)=1$, $E(Z_j^4)=3$ → variance of each square 2. Large $nu$: $(U-nu)/sqrt(2nu) approx N(0,1)$.
Independent chi-squared laws add df. iid #mark[normal] data:
$ (n-1)S^2/sigma^2 tilde chi^2(n-1), quad overline(X) perp S^2. $
Deviations sum to zero → $n-1$ df. Scaling removes units, not unknown variance.
#trap[Unbiased sample variance alone does not imply this law.]

*Example:* $n=3$, $s^2=6$, $sigma^2=4$ → statistic 3, df 2. Lower-tail 5% needs upper-tail 95%, #trap[not the 5% column]. FS p13 lists only upper tails 5%, 1%, 0.1%.

== Student's t: normal / estimated scale
Independent $Z tilde N(0,1)$ and $U tilde chi^2(nu)$:
$T=Z/sqrt(U/nu) tilde t(nu)$.
Real-valued, symmetric about zero. Small random SD → extreme ratios / heavier tails.
$ E(T)=0 quad (nu>1), quad V(T)=nu/(nu-2) quad (nu>2). $
Mean undefined for $nu<=1$; no finite variance for $nu<=2$. Large $nu$ → normal; prefer actual $t$ cutoffs.

One-sample statistic → FS p2 §1; exact for normal data, $n>=2$, df $n-1$. Central $1-alpha$: $plus.minus t_(nu;alpha/2)$; upper tail $alpha$: $t_(nu;alpha)$.

== F: ratio of scaled chi-squared variables
Independent $U tilde chi^2(m)$, $V tilde chi^2(k)$:
$(U/m)/(V/k) tilde F(m,k)$.
Nonnegative, right-skewed; divide each component by *its own df*. Dimensionless $W tilde F(m,k)$:
$E(W)=k/(k-2)$ for $k>2$;
$ V(W)=frac(2k^2(m+k-2),m(k-2)^2(k-4)) quad (k>4). $
#mark[Denominator df k] controls moments: no finite mean if $k<=2$; no finite variance if $k<=4$.
Independent normal samples; sizes $n_1,n_2$, variances $sigma_1^2,sigma_2^2$:
$ (S_1^2/S_2^2)(sigma_2^2/sigma_1^2) tilde F(n_1-1,n_2-1). $
Raw variance ratio has this law only for equal population variances.
#mark[Numerator df first.] Reciprocate ratio → swap df:
$F(m,k;1-alpha)=1/F(k,m;alpha)$.
Here $F(m,k;alpha)$ denotes an upper-tail critical value.

// Lean chapters 6-7; all supplied mean SE/CI/test formulas replaced by references.
= 9. Select the inference method
#fs[p2 §1 · One mean; p2 §2 · Independent means]
== Design → FS table
One sample → §1; independent groups → §2; matched/repeated → differences, then §1. Check each group size; count *pairs*.

== Known SD? Normal? Equal variances?
Known SD → $z$ if normal or large. Unknown SD + normal → exact $t$; large nonnormal → approximate $z$ per notes. #trap[Known SD alone does not justify small nonnormal samples.]

Pooling needs *equal population variances*. Weight variances by df; do not pool SDs. SD ratio between 1/2 and 2 is only a rough diagnostic. Normal pooled $t$ stays exact for large samples too.

#trap[Small unequal-variance groups: do not silently pool.]

== Pairs / nonzero null difference
Fix subtraction direction; pairs independent across subjects; normality concerns *differences*. Within-pair covariance prevents adding group variances blindly.

For null mean difference $delta_0$, replace the FS zero-null numerator by $(overline(x)_1-overline(x)_2)-delta_0$; keep its SE and reference law.

// Lean §§6.1-6.5; proportion/variance CIs from secondary week 10.
= 10. Estimation & precision
== Unbiasedness / interpretation
Unbiased estimator $hat(Theta)$ of fixed $theta$: $E(hat(Theta))=theta$. Compare variance *among unbiased estimators*.

*Example:* $X_i tilde U(0,theta)$ → sample mean has mean $theta/2$; use $2overline(X)$ to estimate $theta$ without bias.

95% CI: procedure covers fixed parameter in 95% of repeated samples. Realized interval is fixed. #trap[Not a range for 95% of observations.]

== Required sample size: one mean
Known $sigma$; normal or large sample. Margin $E_0>0$; confidence $100(1-alpha)%$:
$ n_min=ceil((z_(alpha/2)sigma/E_0)^2). $
$z_(alpha/2)$: upper-tail normal cutoff; $ceil(dot)$: round up. $E_0,sigma$: response units. Unknown SD → pilot/prior estimate. Higher confidence → wider CI; half margin → four times $n$.

== Proportion CI / planning (vault)
$X$: successes in $n$ iid Bernoulli trials; $p$: success probability; $hat(p)=X/n$. With roughly $n hat(p),n(1-hat(p))>=5$:
$ hat(p) plus.minus z_(alpha/2)sqrt(hat(p)(1-hat(p))/n). $
Approximate $100(1-alpha)%$ CI; #trap[poor near 0/1 or small counts]. For dimensionless margin $E_0$:
$ n_min=ceil(z_(alpha/2)^2 p_*(1-p_*)/E_0^2). $
$p_*$: prior estimate (0.5 conservative); approximate planning, not exact coverage.

#block(breakable: false)[
== Variance CI: normal iid only
$n$: sample size; $s^2$: observed variance. Let $q_gamma=chi^2(n-1;gamma)$ be the *upper-tail* cutoff. A $100(1-alpha)%$ CI for $sigma^2$ is
$ ( (n-1)s^2/q_(alpha/2), (n-1)s^2/q_(1-alpha/2) ). $
#mark[Larger cutoff in the lower endpoint's denominator.] Take square roots for a CI for SD. No symmetric ± form.
]

// Lean §§7.1-7.8; examples 7.7-7.8 and 7.15.
= 11. Hypothesis tests: direction & evidence
== Procedure
State parameter and hypotheses → choose direction/$alpha$ → check assumptions → FS statistic → tail area → conclusion in context.

$theta$: parameter; $theta_0$: null value; $w$: observed statistic; $G$: CDF of its null law ($z$ or $t$); $w_gamma$: upper-tail cutoff of area $gamma$.
#block(breakable: false)[
#table(columns: (0.9fr, 1.1fr, 1.1fr),
  table.header([*$H_1$*], [*Reject if*], [*p-value*]),
  [$theta>theta_0$], [$w>w_alpha$], [$1-G(w)$],
  [$theta<theta_0$], [$w < -w_alpha$], [$G(w)$],
  [$theta!=theta_0$], [$abs(w)>w_(alpha/2)$], [$2(1-G(abs(w)))$],
)
]
Reject if p-value $<alpha$; else *fail to reject*. One-sided: keep sign; opposite-direction evidence → p-value above 0.5.

== CI ↔ two-sided test
Same model, SE, df: level-$alpha$ two-sided test rejects iff $100(1-alpha)%$ CI excludes null; boundary included. #trap[95% two-sided CI does not match 5% one-sided test.]

== What a p-value does not mean
Under null: chance of results at least as extreme in chosen direction(s). Not probability null is true or effect size. Failure to reject ≠ no effect; significance ≠ practical importance.

== Worked paired test
After minus before: 8 independent normal differences, mean 24.25, SD 25.39 requests/s. Test zero versus positive: $t=24.25/(25.39/sqrt(8))=2.70$, df 7. p-value 0.0153 → reject at 5%; increased mean throughput.

// Lean example 7.5; R conventions from lecture §9.
= 12. Errors, power & final checks
== Error probabilities
#table(columns: (0.9fr, 1fr, 1fr),
  table.header([*Reality*], [*Fail to reject*], [*Reject*]),
  [Null true], [Correct], [Type I: $alpha$],
  [Alternative true], [Type II: $beta$], [Power: $1-beta$],
)
$alpha$: rejection probability under null; $beta$: nonrejection probability at specified alternative $theta_1$. Fixed size/effect: smaller $alpha$ generally raises $beta$; more data can raise power.

== Exact discrete error calculation
$X tilde "Bin"(20,p)$; reject $p=0.25$ if $X>=9$: $alpha=0.0409$. At $p=0.5$, $beta=P(X<=8)=0.2517$; power 0.7483. #mark[Null for alpha; alternative for beta.] Keep cutoffs exact.

*R:* `d*`: PMF/PDF; `p*`: CDF; `q*`: quantile; `lower.tail=FALSE`: upper tail.
]
