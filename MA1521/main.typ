// Faithful content conversion of main.tex; compile with: typst compile main.typ typ.pdf
#set document(title: "MA1521 Cheatsheet")
#set page(paper: "a4", flipped: true, margin: 10mm, numbering: "1", number-align: center)
#set text(font: "New Computer Modern", size: 8pt, top-edge: "ascender", bottom-edge: "descender")
#set par(leading: 2.2pt, spacing: 1.5pt, first-line-indent: 0pt, justify: true)
#set columns(gutter: 10mm)
#set list(indent: 0pt, body-indent: 1em, spacing: 0pt, tight: true)
#set enum(indent: 0pt, body-indent: 1.3em, spacing: 0pt, tight: true)
#set heading(numbering: none)
#show heading: it => block(above: 3pt, below: 1pt, sticky: true)[#text(size: 9.6pt, weight: "bold", fill: rgb("0000FF"), it.body)]
#show heading.where(level: 2): it => block(above: 3pt, below: 1pt, sticky: true)[#text(size: 8pt, weight: "bold", it.body)]
#show heading.where(level: 3): it => block(above: 0pt, below: 0pt, sticky: true)[#text(size: 7.2pt, style: "italic", it.body)]
#show raw: set text(font: "Nimbus Mono PS", size: 6.4pt)
#show raw.where(block: true): set block(above: 2pt, below: 2pt)
#show math.equation.where(block: true): set block(above: 2pt, below: 2pt)
#set table(inset: (x: 1.5pt, y: 1pt), stroke: 0.3pt)
#show figure: set block(above: 2pt, below: 2pt)
#show math.equation.where(block: true): set block(above: 9pt, below: 9pt)
#set table(stroke: none, inset: (x: 1.5pt, y: 0pt))

#block(width: 100%, above: 0pt, below: 7pt)[#set par(justify: false)
#align(center)[#text(size: 17pt, weight: "bold", fill: rgb("000000"))[MA1521 Cheatsheet]]]

#columns(4)[
#heading(level: 1, numbering: none)[Ch 0: Real Numbers & Functions]
<ch-0-real-numbers-functions>
#heading(level: 2, numbering: none)[Properties]
<properties>
- #strong[Triangle Inequality:] $\| x + y \| lt.eq \| x \| + \| y \|$

- #strong[Absolute Value:]

  - $\| - x \| = \| x \|$

  - $\| x y \| = \| x \| \| y \|$

  - $sqrt(x^2) = \| x \|$

  - $\| x \| < r arrow.l.r.double - r < x < r$ (for $r > 0$)

#heading(level: 1, numbering: none)[Ch 1: Limits and Continuity]
<ch-1-limits-and-continuity>
#heading(level: 2, numbering: none)[Theorems & Laws]
<theorems-laws>
- #strong[Limit Laws:] For sums, differences, products, and quotients (denom $eq.not 0$), the limit of the operation is the operation of the limits.

- #strong[Squeeze (Sandwich) Theorem:] If $g \( x \) lt.eq f \( x \) lt.eq h \( x \)$ near $c$ and $lim_(x arrow.r c) g \( x \) = lim_(x arrow.r c) h \( x \) = L$, then $lim_(x arrow.r c) f \( x \) = L$.

- #strong[Intermediate Value Theorem (IVT):] If $f$ is continuous on $\[ a \, b \]$ and $k$ is between $f \( a \)$ and $f \( b \)$, there exists $c in \[ a \, b \]$ such that $f \( c \) = k$.

#heading(level: 2, numbering: none)[Special Trig Limits]
<special-trig-limits>
- #strong[Small Angle Approximation:] $ lim_(x arrow.r 0) frac(sin x, x) = 1 quad upright("and") quad lim_(x arrow.r 0) frac(1 - cos x, x) = 0 $

- #strong[Note:] $lim_(n arrow.r oo) frac(sin n, n) = 0$ (by Squeeze Thm).

- #emph[Application:] $lim_(n arrow.r oo) n sin (k / n) = k$.

#heading(level: 2, numbering: none)[Continuity]
<continuity>
$f$ is continuous at $c$ if: $ lim_(x arrow.r c) f \( x \) = f \( c \) $

#heading(level: 1, numbering: none)[Ch 2: Derivatives]
<ch-2-derivatives>
#heading(level: 2, numbering: none)[Definition]
<definition>
$ f' \( x \) = lim_(h arrow.r 0) frac(f \( x + h \) - f \( x \), h) $

#heading(level: 2, numbering: none)[Table of Derivatives]
<table-of-derivatives>
#figure(
  align(center)[#table(
    columns: 2,
    align: (left,left,),
    [$\( x^n \)' = n x^(n - 1)$], [$\( cot x \)' = - csc^2 x$],
    [$\( e^x \)' = e^x$], [$\( sec x \)' = sec x tan x$],
    [$\( ln x \)' = 1 \/ x$], [$\( csc x \)' = - csc x cot x$],
    [$\( sin x \)' = cos x$], [$\( sin^(- 1) x \)' = 1 / sqrt(1 - x^2)$],
    [$\( cos x \)' = - sin x$], [$\( tan^(- 1) x \)' = frac(1, 1 + x^2)$],
    [$\( tan x \)' = sec^2 x$], [$\( sec^(- 1) x \)' = frac(1, \| x \| sqrt(x^2 - 1))$],
  )]
  , kind: table
  )

#heading(level: 2, numbering: none)[Parametric Differentiation]
<parametric-differentiation>
For $x = f \( t \) \, y = g \( t \)$: $ frac(d y, d x) = frac(g' \( t \), f' \( t \)) quad upright("and") quad frac(d^2 y, d x^2) = frac(frac(d, d t) \( y' \), frac(d x, d t)) $

#heading(level: 1, numbering: none)[Ch 3: Applications of Differentiation]
<ch-3-applications-of-differentiation>
#heading(level: 2, numbering: none)[Lines & Approximations]
<lines-approximations>
- #strong[Tangent Line:] $y - y_0 = m \( x - x_0 \)$ where $m = f' \( x_0 \)$.

- #strong[Normal Line:] $y - y_0 = - 1 / m \( x - x_0 \)$.

- #strong[Linear Approximation (Linearization):] $ f \( x \) approx L \( x \) = f \( a \) + f' \( a \) \( x - a \) $

- #strong[Newton's Method (Root Finding):] $ x_(n + 1) = x_n - frac(f \( x_n \), f' \( x_n \)) $

#heading(level: 2, numbering: none)[Theorems]
<theorems>
- #strong[Rolle's Theorem:] If $f$ is continuous on $\[ a \, b \]$, differentiable on $\( a \, b \)$, and $f \( a \) = f \( b \)$, there is a $c in \( a \, b \)$ where $f' \( c \) = 0$.

- #strong[Mean Value Theorem (MVT):] Under the same conditions, there is a $c in \( a \, b \)$ where: $ f' \( c \) = frac(f \( b \) - f \( a \), b - a) $

- #strong[L'Hôpital's Rule:] For forms $0 / 0$ or $oo / oo$: $ lim_(x arrow.r c) frac(f \( x \), g \( x \)) = lim_(x arrow.r c) frac(f' \( x \), g' \( x \)) $

#heading(level: 1, numbering: none)[Ch 4: Integrals]
<ch-4-integrals>
#heading(level: 2, numbering: none)[Riemann Sum Definition]
<riemann-sum-definition>
The definite integral $integral_a^b f \( x \) thin d x$ is defined as: $ lim_(n arrow.r oo) {sum_(k = 1)^n (frac(b - a, n)) f (a + k (frac(b - a, n)))} $

#heading(level: 2, numbering: none)[Fundamental Theorem of Calculus]
<fundamental-theorem-of-calculus>
- #strong[Part 1:] $integral_a^b f \( x \) thin d x = F \( b \) - F \( a \)$ ($F$ is antiderivative of $f$).

- #strong[Part 2:] $frac(d, d x) integral_a^x f \( t \) thin d t = f \( x \)$.

#heading(level: 2, numbering: none)[Common & Trig Integrals]
<common-trig-integrals>
- $integral ln x thin d x = x ln x - x + C$

- $integral tan x thin d x = ln \| sec x \| + C$

- $integral cot x thin d x = ln \| sin x \| + C$

- $integral sec x thin d x = ln \| sec x + tan x \| + C$

- $integral csc x thin d x = ln \| csc x - cot x \| + C$

#heading(level: 2, numbering: none)[Techniques]
<techniques>
- #strong[Integration by Parts:] $ integral u thin d v = u v - integral v thin d u $

- #strong[Substitution:] $ integral f \( g \( x \) \) g' \( x \) thin d x = integral f \( u \) thin d u $

#heading(level: 2, numbering: none)[Tangent Half-Angle ($z = tan (theta / 2)$)]
<tangent-half-angle-ztanleftfractheta2right>
Used for rational functions of $sin theta \, cos theta$:

- $sin theta = frac(2 z, 1 + z^2) \, quad cos theta = frac(1 - z^2, 1 + z^2)$

- $d theta = frac(2, 1 + z^2) thin d z$

- #strong[Limits:] $0 arrow.r 0 \, quad pi / 2 arrow.r 1 \, quad pi arrow.r oo$

#heading(level: 1, numbering: none)[Ch 5: Applications of Integration]
<ch-5-applications-of-integration>
#heading(level: 2, numbering: none)[Area Between Curves]
<area-between-curves>
- #strong[Vertical Strips:] $A = integral_a^b \| f \( x \) - g \( x \) \| thin d x$

- #strong[Horizontal Strips:] $A = integral_c^d \| f \( y \) - g \( y \) \| thin d y$

#heading(level: 2, numbering: none)[Volume of Revolution]
<volume-of-revolution>
- #strong[Disk Method (about x-axis):] $ V = pi integral_a^b \[ f \( x \) \]^2 thin d x $

- #strong[Washer Method (about x-axis):] $ V = pi integral_a^b (\[ f \( x \) \]^2 - \[ g \( x \) \]^2) thin d x $

- #strong[Shell Method (about y-axis):] $ V = 2 pi integral_a^b x \| f \( x \) \| thin d x $

#heading(level: 2, numbering: none)[Surface Area of Revolution]
<surface-area-of-revolution>
- #strong[About the x-axis:] For $y = f \( x \)$ from $a$ to $b$: $ S = 2 pi integral_a^b f \( x \) sqrt(1 + \[ f' \( x \) \]^2) thin d x $

- #strong[About the y-axis:] For $x = g \( y \)$ from $c$ to $d$: $ S = 2 pi integral_c^d g \( y \) sqrt(1 + \[ g' \( y \) \]^2) thin d y $

- #strong[For parametric equations (about x-axis):] $ S = 2 pi integral_c^d y \( t \) sqrt((frac(d x, d t))^2 + (frac(d y, d t))^2) thin d t $

#heading(level: 2, numbering: none)[Arc Length]
<arc-length>
- For $y = f \( x \)$ from $a$ to $b$ (and vice versa for $x = g \( y \)$): $ L = integral_a^b sqrt(1 + \[ f' \( x \) \]^2) thin d x $

- For parametric equations: $ L = integral_c^d sqrt((frac(d x, d t))^2 + (frac(d y, d t))^2) thin d t $

#heading(level: 1, numbering: none)[Ch 6: Infinite/Convergent Series]
<ch-6-infiniteconvergent-series>
#heading(level: 2, numbering: none)[Sum of Geometric Series]
<sum-of-geometric-series>
$ S_n = sum_(i = 1)^n a_i dot.op r^(i - 1) = a_1 (frac(1 - r^n, 1 - r)) $

- Diverges if $\| r \| gt.eq 1$

- Converges to $frac(a, 1 - r)$ if $\| r \| < 1$

#heading(level: 2, numbering: none)[Series]
<series>
#heading(level: 3, numbering: none)[p-Series]
<p-series>
$ sum_(n = 1)^oo 1 / n^p $

- Converges if $p > 1$

- Diverges if $p lt.eq 1$

#heading(level: 3, numbering: none)[Harmonic Series]
<harmonic-series>
$ sum_(n = 1)^oo 1 / n $

- #strong[Never Converges]

- Specific case of #strong[p-series] when #emph[p = 1]

#heading(level: 2, numbering: none)[Test for Convergence]
<test-for-convergence>
#heading(level: 3, numbering: none)[Integral Test]
<integral-test>
- For a series $sum a_n$ where $a_n = f \( n \)$ and $f \( x \)$ are continuous, positive, and decreasing for $x gt.eq 1$:

- Converges #strong[if and only if:]

$ integral_1^oo f \( x \) thin d x upright(" converges") $

#heading(level: 3, numbering: none)[n-th Term Test (Divergence Test)]
<n-th-term-test-divergence-test>
- If $sum a_n$ converges, then $lim_(n arrow.r oo) a_n = 0$

- Diverges if not, but converse (if q, then p) is not necessarily true (e.g. harmonic series)

#heading(level: 3, numbering: none)[Comparison Test]
<comparison-test>
- Suppose $0 lt.eq a_n lt.eq b_n$

  - If $sum b_n$ converges, then $sum a_n$ converges

  - If $sum a_n$ diverges, then $sum b_n$ diverges

#heading(level: 2, numbering: none)[Ratio Test]
<ratio-test>
$ L = lim_(n arrow.r oo) lr(|c_(n + 1) / c_n|) quad upright("then") quad R = 1 / L $

- If $L < 1$: #strong[Absolutely Convergent]

- If $L > 1$: #strong[Divergent]

- If $L = 1$: #strong[Inconclusive]

#heading(level: 2, numbering: none)[Root Test]
<root-test>
$ L = lim_(n arrow.r oo) root(n, \| a_n \|) $

- Conclusions are identical to Ratio Test

#heading(level: 2, numbering: none)[Alternating Series Test]
<alternating-series-test>
$ sum \( - 1 \)^(n - 1) b_n upright(" with ") b_n > 0 $

- If $b_n$ is decreasing $\( b_(n + 1) lt.eq b_n \)$ and $lim_(n arrow.r oo) b_n = 0$, then the series converges.

#heading(level: 2, numbering: none)[Power Series]
<power-series>
$ sum_(n = 0)^oo c_n dot.op \( x - a \)^n upright(", centered at ") a $

- Radius of Convergence

  - The series converges abs for $\| x - a \| < R$ and diverges for $\| x - a \| > R$

  - $R = 1 / L arrow.r.double.long L$ is the limit from Ratio or Root test applied to coeffs

- #strong[Take note:] Within radius of convergence, can be differentiated and integrated term-by-term

#heading(level: 2, numbering: none)[Taylor and Maclaurin Series]
<taylor-and-maclaurin-series>
#heading(level: 3, numbering: none)[Taylor Series]
<taylor-series>
$ f \( x \) = sum_(n = 0)^oo frac(f^(\( n \)) \( a \), n !) \( x - a \)^n $

- Representation of a function $f \( x \)$ as a power series centred at $x = a$

#heading(level: 3, numbering: none)[Maclaurin Series]
<maclaurin-series>
- Taylor Series centred at $a = 0$

#heading(level: 3, numbering: none)[Important Maclaurin Series]
<important-maclaurin-series>
- $e^x = sum_(n = 0)^oo frac(x^n, n !) = 1 + x + frac(x^2, 2 !) + frac(x^3, 3 !) + dots.h$

- $\( 1 + x \)^k = 1 + k x + frac(k \( k - 1 \), 2 !) x^2 + frac(k \( k - 1 \) \( k - 2 \), 3 !) x^3 + dots.h$

- $frac(1, 1 + x) = sum_(n = 0)^oo \( - 1 \)^n x^n = 1 - x + x^2 - x^3 + dots.h$ (converges for $\| x \| < 1$)

- $l n \( 1 + x \) = x - x^2 / 2 + x^3 / 3 - x^4 / 4 + dots.h$ (converges for $- 1 < x lt.eq 1$)

- $sin x = sum_(n = 0)^oo frac(\( - 1 \)^n x^(2 n + 1), \( 2 n + 1 \) !) = x - frac(x^3, 3 !) + frac(x^5, 5 !) - dots.h$

- $cos x = sum_(n = 0)^oo frac(\( - 1 \)^n x^(2 n), \( 2 n \) !) = 1 - frac(x^2, 2 !) + frac(x^4, 4 !) - dots.h$

- $tan^(- 1) x = sum_(n = 0)^oo frac(\( - 1 \)^n x^(2 n + 1), 2 n + 1) = x - x^3 / 3 + x^5 / 5 - dots.h$ (converges for $\| x \| lt.eq 1$)

#heading(level: 1, numbering: none)[Ch 7: Vectors and Geometry of Space]
<ch-7-vectors-and-geometry-of-space>
#heading(level: 2, numbering: none)[3D Coordinates & Vectors]
<d-coordinates-vectors>
- #strong[Distance:] $ \| P_1 P_2 \| = sqrt(\( x_2 - x_1 \)^2 + \( y_2 - y_1 \)^2 + \( z_2 - z_1 \)^2) $

- #strong[Equation of Sphere:] $ \( x - h \)^2 + \( y - k \)^2 + \( z - l \)^2 = r^2 $

- #strong[Length:] $lr(bar.v.double upright(bold(a)) bar.v.double) = sqrt(a_1^2 + a_2^2 + a_3^2)$

- #strong[Unit Vector:] $upright(bold(u)) = upright(bold(a)) / lr(bar.v.double upright(bold(a)) bar.v.double)$

#heading(level: 2, numbering: none)[The Dot Product]
<the-dot-product>
- $upright(bold(a)) dot.op upright(bold(b)) = a_1 b_1 + a_2 b_2 + a_3 b_3 = lr(bar.v.double upright(bold(a)) bar.v.double) lr(bar.v.double upright(bold(b)) bar.v.double) cos theta$

- $upright(bold(a)) perp upright(bold(b)) arrow.l.r.double upright(bold(a)) dot.op upright(bold(b)) = 0$

#heading(level: 2, numbering: none)[Projections]
<projections>
- #strong[Scalar Projection (comp):] $ upright("comp")_(upright(bold(a))) upright(bold(b)) = frac(upright(bold(a)) dot.op upright(bold(b)), lr(bar.v.double upright(bold(a)) bar.v.double)) $

- #strong[Vector Projection (proj):] $ upright("proj")_(upright(bold(a))) upright(bold(b)) = (frac(upright(bold(a)) dot.op upright(bold(b)), lr(bar.v.double upright(bold(a)) bar.v.double)^2)) upright(bold(a)) $

- #strong[Point to Plane Distance:] $ D = frac(\| a x_0 + b y_0 + c z_0 - d \|, sqrt(a^2 + b^2 + c^2)) $

#heading(level: 2, numbering: none)[The Cross Product]
<the-cross-product>
- #strong[Definition:] $ upright(bold(a)) times upright(bold(b)) = mat(delim: "|", upright(bold(i)), upright(bold(j)), upright(bold(k)); a_1, a_2, a_3; b_1, b_2, b_3) $

- #strong[Magnitude:] $lr(bar.v.double upright(bold(a)) times upright(bold(b)) bar.v.double) = lr(bar.v.double upright(bold(a)) bar.v.double) lr(bar.v.double upright(bold(b)) bar.v.double) sin theta$

- $upright(bold(a)) times upright(bold(b))$ is orthogonal to both $upright(bold(a))$ and $upright(bold(b))$.

- #strong[Point Q to Line PR Dist:] $d = lr(bar.v.double accent(P Q, ⃗) times accent(P R, ⃗) bar.v.double) / lr(bar.v.double accent(P R, ⃗) bar.v.double)$

#heading(level: 2, numbering: none)[Lines & Planes]
<lines-planes>
- #strong[Line (Vector):] $upright(bold(r)) = upright(bold(r))_0 + t upright(bold(v))$

- #strong[Line (Parametric):] $x = x_0 + a t$, $y = y_0 + b t$, $z = z_0 + c t$

- #strong[Plane (Vector):] $upright(bold(n)) dot.op \( upright(bold(r)) - upright(bold(r))_0 \) = 0$

- #strong[Plane (Scalar):] $A \( x - x_0 \) + B \( y - y_0 \) + C \( z - z_0 \) = 0$

#heading(level: 1, numbering: none)[Ch 8: Functions of Several Variables]
<ch-8-functions-of-several-variables>
#heading(level: 2, numbering: none)[Arc Length Formula]
<arc-length-formula>
- Let C be: $r \( t \) = chevron.l f \( t \) \, g \( t \) \, h \( t \) chevron.r$, $a lt.eq t lt.eq b$

- $f'$, $g'$ and $h'$ are continuous

$ s = integral_a^b sqrt(f' \( t \)^2 + g' \( t \)^2 + h' \( t \)^2) thin d t $

#heading(level: 2, numbering: none)[Surface Area of a 2D Surface in 3D]
<surface-area-of-a-2d-surface-in-3d>
- For $z = f \( x \, y \)$ over region $D$: $ S = integral.double_D sqrt(1 + (f_x)^2 + (f_y)^2) thin d A $

#heading(level: 2, numbering: none)[Tangent Plane & Linear Approx]
<tangent-plane-linear-approx>
- #strong[Tangent Plane:] $z = f \( a \, b \) + f_x \( a \, b \) \( x - a \) + f_y \( a \, b \) \( y - b \)$

- #strong[Linear Approximation:] $f \( x \, y \) approx f \( a \, b \) + f_x \( a \, b \) d x + f_y \( a \, b \) d y$

#heading(level: 2, numbering: none)[Second Partials Test]
<second-partials-test>
Let $D = f_(x x) \( a \, b \) f_(y y) \( a \, b \) - \[ f_(x y) \( a \, b \) \]^2$:

- $D > 0 \, f_(x x) \( a \, b \) > 0 arrow.r.double.long$ Local Minimum

- $D > 0 \, f_(x x) \( a \, b \) < 0 arrow.r.double.long$ Local Maximum

- $D < 0 arrow.r.double.long$ Saddle Point

- $D = 0 arrow.r.double.long$ Test is Inconclusive

#heading(level: 2, numbering: none)[Chain Rule]
<chain-rule>
- Given: $z = f \( x \, y \)$, where $x = g \( s \, t \)$ and $y = h \( s \, t \)$ (all are differentiable by s and t) $ frac(partial z, partial s) = frac(partial f, partial x) frac(partial x, partial s) + frac(partial f, partial y) frac(partial y, partial s) $ #strong[for each $i = 1 \, dots.h \, m$]

#heading(level: 2, numbering: none)[Change of Variables (Jacobian)]
<change-of-variables-jacobian>
For a one-to-one transformation $x = x \( u \, v \)$ and $y = y \( u \, v \)$: $ integral.double_R f \( x \, y \) thin d A = integral.double_S f \( x \( u \, v \) \, y \( u \, v \) \) lr(|frac(partial \( x \, y \), partial \( u \, v \))|) thin d u thin d v $ where the Jacobian $J$ is given by: $ J = frac(partial \( x \, y \), partial \( u \, v \)) = mat(delim: "|", f_(x u), f_(x v); f_(y u), f_(y v)) $ and the area elements are related by: $ d A = \| J \| thin d u thin d v \, #h(2em) frac(partial \( u \, v \), partial \( x \, y \)) = 1 / J $

For 3 variables $x = x \( u \, v \, w \)$, $y = y \( u \, v \, w \)$, and $z = z \( u \, v \, w \)$: $ integral.triple_R f \( x \, y \, z \) thin d V & = integral.triple_S f \( x \( u \, v \, w \) \, y \( u \, v \, w \) \, z \( u \, v \, w \) \)\
 & quad times lr(|frac(partial \( x \, y \, z \), partial \( u \, v \, w \))|) thin d u thin d v thin d w $

#heading(level: 2, numbering: none)[Common Case]
<common-case>
#heading(level: 3, numbering: none)[Polar Coordinates]
<polar-coordinates>
Using the transformation $x = r cos theta$ and $y = r sin theta$, the Jacobian is $\| J \| = r$. Therefore: $ d A = r thin d r thin d theta $

#heading(level: 3, numbering: none)[Cylindrical Coordinates]
<cylindrical-coordinates>
Using $x = r cos theta \, quad y = r sin theta \, quad z = z \,$ the Jacobian is $ lr(|frac(partial \( x \, y \, z \), partial \( r \, theta \, z \))|) = r . $ Hence, $ d V = r thin d r thin d theta thin d z $

#heading(level: 3, numbering: none)[Spherical Coordinates]
<spherical-coordinates>
Using $ x = rho sin phi.alt cos theta \, quad y = rho sin phi.alt sin theta \, quad z = rho cos phi.alt \, $

where $rho$ is length from origin, $phi.alt$ is angle from positive z-axis, and $theta$ is angle from positive x-axis in xy-plane. \
with $rho gt.eq 0$, $0 lt.eq phi.alt lt.eq pi$, $0 lt.eq theta < 2 pi$, the Jacobian is $ lr(|frac(partial \( x \, y \, z \), partial \( rho \, phi.alt \, theta \))|) = rho^2 sin phi.alt . $ Hence, $ d V = rho^2 sin phi.alt thin d rho thin d phi.alt thin d theta $

#heading(level: 1, numbering: none)[Ch 9: Ordinary Differential Equations]
<ch-9-ordinary-differential-equations>
#heading(level: 2, numbering: none)[Separable Equations]
<separable-equations>
- #strong[Form:] $y' = g \( x \) h \( y \)$

- #strong[Solution:] $integral frac(1, h \( y \)) thin d y = integral g \( x \) thin d x$

#heading(level: 2, numbering: none)[First-Order Linear ODEs]
<first-order-linear-odes>
- #strong[Form:] $y' + P \( x \) y = Q \( x \)$

- #strong[Factor:] $I \( x \) = exp (integral P \( x \) thin d x)$

- #strong[Solution:] $y = frac(1, I \( x \)) integral I \( x \) Q \( x \) thin d x$

#heading(level: 2, numbering: none)[Bernoulli Equations]
<bernoulli-equations>
- #strong[Form:] $y' + P \( x \) y = Q \( x \) y^n$ ($n eq.not 0 \, 1$)

- #strong[Substitution:] $v = y^(1 - n)$

- #strong[Linearized:] $v' + \( 1 - n \) P \( x \) v = \( 1 - n \) Q \( x \)$

#heading(level: 1, numbering: none)[Trigonometric Identities]
<trigonometric-identities>
#heading(level: 2, numbering: none)[Pythagorean]
<pythagorean>
- $sin^2 x + cos^2 x = 1$

- $sec^2 x - 1 = tan^2 x$

#heading(level: 2, numbering: none)[Double Angle]
<double-angle>
- $sin 2 x = 2 sin x cos x$

- $cos 2 x = 2 cos^2 x - 1 = 1 - 2 sin^2 x$

#heading(level: 2, numbering: none)[Power-Reduction (Half-Angle)]
<power-reduction-half-angle>
$ cos^2 x = frac(1 + cos 2 x, 2) $ $ sin^2 x = frac(1 - cos 2 x, 2) $

#heading(level: 2, numbering: none)[Product-to-Sum]
<product-to-sum>
$ sin A cos B = 1 / 2 [sin \( A + B \) + sin \( A - B \)] $ $ cos A cos B = 1 / 2 [cos \( A + B \) + cos \( A - B \)] $

#heading(level: 2, numbering: none)[Special Inverse & Hyperbolic Integrals]
<special-inverse-hyperbolic-integrals>
- $integral 1 / sqrt(a^2 - x^2) thin d x = sin^(- 1) (x / a) + C$

- $integral frac(1, a^2 + x^2) thin d x = 1 / a tan^(- 1) (x / a) + C$

- $integral frac(1, x sqrt(x^2 - a^2)) thin d x = 1 / a sec^(- 1) lr(|x / a|) + C$

- $integral 1 / sqrt(x^2 + a^2) thin d x = ln \| x + sqrt(x^2 + a^2) \| + C$

- $integral 1 / sqrt(x^2 - a^2) thin d x = ln \| x + sqrt(x^2 - a^2) \| + C$

#heading(level: 2, numbering: none)[Trigonometric Substitution]
<trigonometric-substitution>
Used for integrals containing radicals of quadratic forms:

- #strong[Form] $sqrt(a^2 - x^2)$: Let $x = a sin theta$, $d x = a cos theta thin d theta$ \
  (Relies on $1 - sin^2 theta = cos^2 theta$)

- #strong[Form] $sqrt(a^2 + x^2)$: Let $x = a tan theta$, $d x = a sec^2 theta thin d theta$ \
  (Relies on $1 + tan^2 theta = sec^2 theta$)

- #strong[Form] $sqrt(x^2 - a^2)$: Let $x = a sec theta$, $d x = a sec theta tan theta thin d theta$ \
  (Relies on $sec^2 theta - 1 = tan^2 theta$)

]
