// Converted from main.tex. Compile: typst compile main.typ main.pdf
// A4 landscape, two flowing columns; all content is editable Typst.
#let navy = rgb("183A59")
#let lightgray = rgb("D3D3D3")

#set document(title: "CS2100 Midterm Cheat Sheet")
#set page(
  paper: "a4",
  flipped: true,
  margin: (x: 7.5mm, top: 8mm, bottom: 7mm),
  header-ascent: 3mm,
  footer: context align(right, text(font: "Noto Music", size: 9pt, counter(page).display())),
  footer-descent: 3mm,
  // Draw the column separator inside the text area on every page.
  background: place(top + center, dy: 8mm, line(angle: 90deg, length: 195mm, stroke: 0.2pt)),
)
#set par(justify: false, leading: 0.4pt, spacing: 1.5pt, first-line-indent: 0pt)
#set columns(gutter: 7mm)
#set list(indent: 0pt, body-indent: 0.9em, spacing: 1pt)
#set enum(indent: 0pt, body-indent: 1.2em, spacing: 1pt)

// Heading setting
#set heading(numbering: none)
#show heading.where(level: 1): it => block(
  above: 4pt,
  below: 3pt,
  sticky: true,
)[
  #stack(spacing: 2pt, text(font: "Nimbus Sans", weight: "extrabold", fill: navy, size: 8.7pt, it.body), line(
    length: 100%,
    stroke: (paint: navy, thickness: 0.35pt),
  ))
]

// Text settings
#set text(font: "New Computer Modern", size: 8.2pt, top-edge: "ascender", bottom-edge: "descender")
#show raw: set text(font: "Nimbus Mono PS", size: 8.2pt)
#show math.equation.where(block: true): set block(above: 3pt, below: 3pt)
#set table(stroke: none, inset: (x: 2pt, y: 1.5pt))
#show table: set text(size: 7.8pt)
#show figure.where(kind: table): set block(above: 3pt, below: 3pt)

// Misc variables
#let law-title(body) = table.cell(
  colspan: 2,
  fill: white,
)[
  #text(fill: rgb("AD3045"), weight: "bold", body)
]

#columns(2)[
  = The overall connection
  C source $arrow.r$~preprocessor $arrow.r$~compiler $arrow.r$~assembly $arrow.r$~assembler $arrow.r$~object files $arrow.r$~linker $arrow.r$~executable machine instructions. Types determine how bit patterns are interpreted. The ISA defines what instructions mean. Processor control and datapath circuits execute them, changing registers, memory, and the program counter (PC).

  = C: compilation, types, and functions
  - #strong[Declaration:] gives a name and type. #strong[Definition:] also creates storage or a function body. Multiple compatible declarations may refer to one definition.

  - #strong[Header (.h):] publishes declarations, prototypes, types, and macros. `#include` is processed before compilation. Use include guards. Compile separate `.c` files to `.o` files with `gcc -c`; the linker combines them.

  - `gcc -Wall` enables warnings; `-o name` sets the executable name. `main` returns an integer; returning 0 conventionally signals success.

  - C uses declared types but permits conversions. A conversion may discard information (for example, floating value to integer). Uninitialized automatic variables have indeterminate values.

  - In the course's common model, `short/int/long` occupy 2/4/8 bytes and `float/double` 4/8 bytes. Actual C type widths depend on the implementation.

  - Function arguments are passed by #strong[value]: parameters receive copies. Passing a pointer copies the address, allowing a function to modify the pointed-to object.

  - A function prototype declares parameter and return types. A local `static` retains its value between calls; file-scope `static` restricts linkage to that source file.

  - `&&` has higher precedence than `||`. Parentheses make intended evaluation clear. A `do-while` loop executes its body before testing the condition.

  - For `scanf`, use `%d` for `int`, `%f` for `float`, and `%lf` for `double`; pass addresses. `%p` prints a pointer.

  = Pointers, arrays, strings, structs
  - `&x` obtains the address of `x`. `T *p` declares a pointer to `T`; `*p` accesses the pointed-to object. `p+1` advances by `sizeof(T)` bytes.

  - Never dereference an uninitialized, invalid, null, or dangling pointer. #strong[Aliasing] means two pointers can refer to one object. A dangling pointer refers to an object whose lifetime has ended.

  - Array elements have the same type and occupy contiguous storage. In a function parameter, `int a[8]` is adjusted to `int *a`; the 8 does not enforce the caller's array size.

  - `int a[5]={1,2,3}` sets remaining elements to zero. An uninitialized local array does not have guaranteed zero values.

  - A C string is a character array terminated by `'\0'`. Reserve a byte for the terminator. `fgets` can retain a newline. `scanf("%s",...)` stops at whitespace and should use a width limit.

  - A struct groups fields of potentially different types. Struct assignment copies its value. `p->field` means `(*p).field`. Passing a struct by value copies it; passing an array argument permits modification of its elements.

  = Stored-program architecture and memory
  CPU = registers + ALU + control. Memory holds both instructions and data; I/O communicates with the outside. A bus connects CPU and memory. Registers are small, fast storage inside the CPU. #strong[Load:] memory $arrow.r$~register. #strong[Store:] register $arrow.r$~memory. If too many values are live, the compiler #strong[spills] some to memory and reloads them later.

  In the lecture's 32-bit MIPS model, a word is 32 bits = 4 bytes. Memory is #strong[byte-addressed]\; aligned word addresses satisfy $a mod 4 = 0$. The next aligned word begins at $a + 4$, not $a + 1$. A $k$-bit byte address identifies $2^k$ byte locations.

  = Bits and positional number systems
  One bit has two states; $n$ bits have $2^n$ patterns. Encoding $M$ distinct values requires at least $ceil.l log_2 M ceil.r$ bits. Positional value is $ \( d_k dots.h.c d_0 . d_(- 1) dots.h.c \)_r = sum_i d_i r^i . $ For an integer, repeatedly divide by the target radix and read remainders backward. For a fraction, repeatedly multiply by the radix and read integer parts forward. Group binary digits in threes for octal and fours for hexadecimal. The same bits can represent different things: `01000110` is integer 70 or ASCII character `F`.

  = Signed integer representations
  First decide whether the same $n$-bit pattern is #emph[unsigned], sign magnitude, one's complement, two's complement, or excess-$K$. The arithmetic and interpretation depend on that choice. MSB means most significant (leftmost) bit. An out-of-range mathematical answer is overflow even if an $n$-bit result pattern can still be written.

  #strong[Unsigned binary.] Range: $0$ to $2^n - 1$. Add normally; an outgoing carry from bit $n - 1$ means unsigned overflow. Retaining only $n$ bits computes the sum modulo $2^n$. Subtraction with $A < B$ wraps modulo $2^n$ if kept in $n$ bits. There is no representation of a negative value.

  = Sign magnitude: range, negation, addition
  #strong[Interpretation and range:] MSB is sign (0 positive, 1 negative); the remaining $n - 1$ bits give magnitude. Range is $- \( 2^(n - 1) - 1 \)$ to $2^(n - 1) - 1$. Both $+ 0$ and $- 0$ exist.

  #strong[Negate:] flip only the sign bit. This also switches the two zero encodings. #strong[Add:] if signs match, add magnitudes and keep the common sign. If signs differ, subtract the smaller magnitude from the larger and use the sign of the larger-magnitude operand. Equal opposite magnitudes give zero. #strong[Subtract:] negate the second operand, then add using these rules.

  #strong[Overflow:] for same-sign addition, the magnitude sum exceeds $2^(n - 1) - 1$. Opposite-sign addition cannot overflow, because its magnitude is no larger than the larger input magnitude. A carry from a raw addition of complete sign-magnitude bit strings is #emph[not] the arithmetic rule.

  = One's complement: range, negation, addition
  #strong[Interpretation and range:] nonnegative values use ordinary binary; a negative value is the bitwise complement of its positive magnitude. Range is $- \( 2^(n - 1) - 1 \)$ to $2^(n - 1) - 1$. There are two zeros: all 0s is $+ 0$, all 1s is $- 0$.

  #strong[Negate:] invert every bit, $x mapsto overline(x)$. For a positive integer $x$, its negative pattern has unsigned value $2^n - 1 - x$. For example, in 8 bits, $+ 12 = 00001100$ and $- 12 = 11110011$.

  #strong[Add two numbers:] (1) add the $n$-bit patterns as ordinary binary; (2) if a carry leaves the MSB, add that carry back into the low bit (#emph[end-around carry]); (3) interpret the $n$-bit result and check overflow. Example in 4 bits: $5 + \( - 3 \) : med 0101 + 1100 = 1 thin 0001 arrow.r 0010 = 2$. #strong[Subtract:] complement the second operand, then use one's-complement addition with end-around carry.

  #strong[Overflow:] after end-around carry, adding two positive values must not produce a negative result, and adding two negative values must not produce a positive result. Equivalently, the true sum must remain in $\[ - \( 2^(n - 1) - 1 \) , med 2^(n - 1) - 1 \]$. Opposite-sign addition cannot overflow. Handle the two zero patterns as zero when reasoning about signs.

  = Two's complement: range, negation, addition
  #strong[Interpretation and range:] nonnegative values use ordinary binary; a pattern with MSB 1 represents its unsigned value minus $2^n$. Range is $- 2^(n - 1)$ to $2^(n - 1) - 1$. There is one zero and one extra negative number.

  #strong[Negate:] invert all bits and add 1: $- x = overline(x) + 1 mod 2^n$. For a positive integer $x$, the negative pattern has unsigned value $2^n - x$. In 8 bits, $+ 12 = 00001100$ and $- 12 = 11110100$. The minimum value $- 2^(n - 1)$ cannot be negated within $n$ signed bits: $+ 2^(n - 1)$ is out of range.

  #strong[Add two numbers:] add the $n$-bit patterns, retain the low $n$ bits, and discard the carry out of the MSB. Then check #emph[signed] overflow. In 4 bits, $5 + \( - 3 \) : med 0101 + 1101 = 1 thin 0010 arrow.r 0010 = 2$. #strong[Subtract:] $A - B = A + overline(B) + 1$, using the same $n$-bit adder and overflow test.

  #strong[Overflow:] same-sign addition produces an opposite-sign result, or equivalently the carry into the sign bit differs from the carry out. Two opposite-sign operands cannot overflow on addition. A final carry out alone is #emph[not] signed overflow: $1111 + 0001 = 1 thin 0000$ is $- 1 + 1 = 0$, without overflow. For $A - B$, overflow occurs if $A$ and $B$ have different signs and the result sign differs from $A$'s sign.

  = Excess or biased representation
  #strong[Encode:] store $x + K$ as an unsigned $n$-bit pattern. #strong[Decode:] $x = upright("stored") - K$. Range is $- K$ to $2^n - 1 - K$. There is no dedicated sign bit. Ordinary binary addition of two stored patterns does #emph[not] directly give the biased encoding of their sum: decode, operate, then re-encode (or correct the bias). IEEE 754 uses a #strong[bias-127] exponent field for 32 bits.

  = Fixed-point range and spacing
  With $f$ fractional bits, a signed fixed-point value is its stored integer multiplied by $2^(- f)$. Spacing is $2^(- f)$. For an $n$-bit two's-complement pattern: $ upright("range") = [- 2^(n - 1 - f) , med \( 2^(n - 1) - 1 \) 2^(- f)] . $ Example: $n = 8 , f = 2$ gives range $\[ - 32 , 31.75 \]$ in steps of $0.25$. For an #emph[unsigned] fixed-point pattern the range is $\[ 0 , \( 2^n - 1 \) 2^(- f) \]$. If a sign-magnitude or one's-complement integer is scaled by $2^(- f)$, its range is $\[ - \( 2^(n - 1) - 1 \) 2^(- f) , \( 2^(n - 1) - 1 \) 2^(- f) \]$. All these fixed-point formats have spacing $2^(- f)$ between successive nonzero values. More fractional bits improve resolution but reduce range at fixed total width. #strong[Note:] the spacing is $2^(- f)$, not $2^f$.

  = IEEE 754 single precision (binary32)
  A 32-bit floating-point pattern has three fields: $ underbrace(s, 1 upright(" sign bit")) med #scale(x: 120%, y: 120%)[\|] med underbrace(E, 8 upright(" exponent bits")) med #scale(x: 120%, y: 120%)[\|] med underbrace(F, 23 upright(" fraction bits")) . $ $s = 0$ is positive and $s = 1$ is negative. Interpret $E$ and $F$ as unsigned integers. The exponent has bias 127; the fraction is $f = F \/ 2^23$. Classify the pattern by its #emph[stored] exponent before applying the normal-number formula.

  #strong[Normal finite numbers ($1 lt.eq E lt.eq 254$):] $ x = \( - 1 \)^s \( 1 + F \/ 2^23 \) thin 2^(E - 127) = \( - 1 \)^s \( 1 . f \)_2 thin 2^(E - 127) . $ The leading 1 is implicit, so 23 stored fraction bits give 24 significant binary digits. The actual exponent ranges from $- 126$ to $+ 127$. To encode a nonzero normal number, write it as $plus.minus 1 . b_1 b_2 dots.h zws_2 times 2^e$, store $E = e + 127$, and store the bits after the leading 1 in $F$, rounding if needed. Example: $6.5_10 = 110.1_2 = 1.101_2 thin 2^2$; $s = 0$, $E = 129 = 10000001_2$, $F = 101$ followed by 20 zeros. Its 32-bit hex pattern is `0x40D00000`.

  // Vault: 300 Main Notes/IEEE 754 Floating-Point.md -> IEEE 754 Floating-Point IEEE 754 1.png.
  #block(breakable: false)[
    #align(center, image("images/ieee754-fields.png", width: 80%))
    #text(size: 7.6pt)[Field layout example: stored exponent `10000110` = 134, so the normal-value exponent is 134 − 127 = 7. The fraction excludes the implicit leading 1.]
  ]

  = binary32 special patterns
  - #strong[Signed zero:] $E = 0 , med F = 0$. $s = 0$ gives $+ 0$ (`0x00000000`); $s = 1$ gives $- 0$ (`0x80000000`). Both compare equal numerically, although their bit patterns and behavior in some operations differ.

  - #strong[Subnormal:] $E = 0 , med F eq.not 0$. There is #emph[no] implicit leading 1. The effective exponent is $- 126$: $ x = \( - 1 \)^s \( F \/ 2^23 \) thin 2^(- 126) = \( - 1 \)^s F thin 2^(- 149) . $ Subnormals fill the gap between zero and the smallest normal number. Their spacing is constant at $2^(- 149)$.

  - #strong[Infinity:] $E = 255 , med F = 0$. Sign chooses $+ oo$ (`0x7F800000`) or $- oo$ (`0xFF800000`). Overflow can produce infinity, depending on the rounding mode.

  - #strong[NaN (not a number):] $E = 255 , med F eq.not 0$. It denotes an undefined numerical result, such as $0 \/ 0$ or $oo - oo$. Fraction bits can carry a payload; its sign does not determine an ordinary positive/negative number. `0x7FC00000` is a common quiet-NaN pattern.

  #strong[Boundary values (positive):] smallest subnormal $2^(- 149)$; largest subnormal $\( 2^23 - 1 \) 2^(- 149)$; smallest normal $2^(- 126)$; largest finite $\( 2 - 2^(- 23) \) 2^127 approx 3.4028235 times 10^38$. A nonzero result too small for normal representation can become subnormal or round to zero. The gap between adjacent normal values with actual exponent $e$ is $2^(e - 23)$, so absolute precision changes with scale. Around 1, the upward gap is $2^(- 23)$; binary32 provides roughly 7 decimal significant digits.

  = IEEE 754 rounding and quick decoding
  #strong[Rounding modes:] nearest with ties to even (default), toward zero, toward $+ oo$, and toward $- oo$. For a value cut after the last stored fraction bit, the #strong[guard bit] is the first discarded bit, the #strong[round bit] is the next, and the #strong[sticky bit] is the OR of all later discarded bits. They help decide whether the stored fraction must increase. Rounding after each operation means $\( a + b \) + c$ can differ from $a + \( b + c \)$.

  #strong[Exam procedure:] split the 32 bits into $s \| E \| F$; check $E = 0$ and $E = 255$ first. For $1 lt.eq E lt.eq 254$, restore the hidden leading 1 and use exponent $E - 127$. For $E = 0 , F eq.not 0$, use leading 0 and exponent $- 126$. For $E = 255$, distinguish infinity from NaN using $F = 0$ versus $F eq.not 0$. A 64-bit double instead uses 1 sign, 11 exponent bits (bias 1023), and 52 fraction bits.

  = Range quick reference: all representations
  For an $n$-bit #emph[integer], the first value below is the most negative representable value and the second is the largest positive. Both $+ 1$ and $- 1$ are the nonzero values closest to zero whenever the format includes both signs.

  #figure(
    align(center)[#table(
      columns: (35mm, 1fr),
      align: (left, left),
      table.header([#strong[Integer format]], [#strong[Representable numeric range]]),
      table.hline(),
      [Unsigned], [$0$ to $2^n - 1$],
      [Sign magnitude], [$- \( 2^(n - 1) - 1 \)$ to $2^(n - 1) - 1$; two zeros],
      [One's complement], [$- \( 2^(n - 1) - 1 \)$ to $2^(n - 1) - 1$; two zeros],
      [Two's complement], [$- 2^(n - 1)$ to $2^(n - 1) - 1$; one zero],
      [Excess-$K$], [$- K$ to $2^n - 1 - K$; e.g. 4-bit excess-8 is $- 8$ to $7$],
    )],
    kind: table,
  )

  For #emph[fixed point] with $f$ fractional bits, multiply each integer endpoint above by $2^(- f)$. Thus unsigned spans $0$ to $\( 2^n - 1 \) 2^(- f)$; sign magnitude and one's complement span $plus.minus \( 2^(n - 1) - 1 \) 2^(- f)$; two's complement spans $- 2^(n - 1 - f)$ to $\( 2^(n - 1) - 1 \) 2^(- f)$. The smallest nonzero magnitude is $2^(- f)$ when the format can represent it. For excess-$K$ fixed point, scale $\[ - K , 2^n - 1 - K \]$ by $2^(- f)$.

  For #emph[IEEE 754 binary32], the finite extremes are $plus.minus M_32$, where $M_32 = \( 2 - 2^(- 23) \) 2^127 approx 3.4028235 times 10^38$. The least positive #emph[normal] is $2^(- 126)$; the least positive nonzero #emph[subnormal] is $2^(- 149)$. The negative value closest to zero is $- 2^(- 149)$, while the most negative finite value is $- M_32$. Infinity and NaN are special patterns, not finite range endpoints.

  For #emph[IEEE 754 binary64], the corresponding values are $M_64 = \( 2 - 2^(- 52) \) 2^1023 approx 1.7976931348623157 times 10^308$, minimum positive normal $2^(- 1022)$, and minimum positive subnormal $2^(- 1074)$. Its finite extremes are $plus.minus M_64$; the negative value closest to zero is $- 2^(- 1074)$. Floating-point values are discrete and unevenly spaced, so these limits do not mean every real number between them is representable.

  = ISA and MIPS design
  The instruction set architecture (ISA) is the visible contract between software and hardware: operations, registers, data, addressing, and encoding. CISC favors richer instructions; RISC uses simpler, regular instructions composed by software.

  Operand organization may be stack, accumulator, general-purpose register, or memory-memory. MIPS uses a #strong[register-register / load-store] design: ALU operations use registers, while `lw/sw` access memory. Addressing modes in these notes: register, immediate constant, and displacement (base + offset). ISA design chooses storage, addressing, operation set, instruction fields/length, and binary encoding.

  = MIPS registers and common operations
  MIPS has 32 general-purpose registers of 32 bits each. A register index needs 5 bits. `$zero` always reads 0; the PC is separate. Most ALU instructions have destination first: `add rd,rs,rt`, `sub`, `and`, `or`, `xor`, `nor`, `slt`. `slt` writes 1 if the first source is less than the second, else 0.

  `sll/srl` shift logically; a 5-bit shift field represents 0--31 positions. `nor rd,rs,$zero` implements bitwise NOT. `move` is a pseudoinstruction.

  `addi rt,rs,imm` uses a signed 16-bit immediate: $- 32768$ to $32767$, sign-extended to 32 bits. `andi/ori/xori` zero-extend their 16-bit masks. `lui` puts an immediate in the upper 16 bits and sets the lower 16 to zero. Thus an arithmetic immediate and a logical mask with the same bits can be extended differently.

  = MIPS memory and control flow
  `lw rt,offset(rs)` computes effective byte address $R \[ "rs" \] + "signext" \( "offset" \)$, then loads one word into `rt`. `sw rt,offset(rs)` stores `rt` at that address. The offset counts #strong[bytes], and word accesses require 4-byte alignment in this model.

  `beq rs,rt,label` branches if equal; `bne` if not equal. `slt` followed by a branch expresses an inequality. `j label` jumps unconditionally. A label names an address; it is not an instruction.

  = MIPS instruction formats: every instruction is 32 bits
  #strong[R format:] $ "opcode"_6 med \| med "rs"_5 med \| med "rt"_5 med \| med "rd"_5 med \| med "shamt"_5 med \| med "funct"_6 . $ Typical arithmetic uses two register sources and `rd` destination; `funct` chooses the operation. Shifts use `shamt` and usually `rt` as data source.

  #strong[I format:] $ "opcode"_6 med \| med "rs"_5 med \| med "rt"_5 med \| med "immediate"_16 . $ `rt` is a destination for `addi/lw`, but source data for `sw` and a comparison operand for branches. The immediate's meaning depends on the opcode.

  #strong[J format:] $ "opcode"_6 med \| med "target"_26 . $ Instructions are four aligned bytes, so sequential next PC is $"PC" + 4$. A branch immediate counts #strong[words]: $ upright("branch target") = "PC" + 4 + #scale(x: 120%, y: 120%)[\(] "signext" \( "imm"_16 \) lt.double 2 #scale(x: 120%, y: 120%)[\)] . $ A jump uses pseudo-direct addressing: $ upright("jump target") = { \( "PC" + 4 \)_(31 : 28) , med "target"_(25 : 0) , med 00 } . $ Its upper four bits come from $"PC" + 4$, limiting the jump to the corresponding 256 MiB region.

  = Datapath components and five stages
  The datapath contains the PC, instruction memory, register file (32 registers of 32 bits; two read ports and one write port), ALU, dedicated adders, data memory, and multiplexers. The control path selects routes, operations, and enabled writes.

  + #strong[Fetch:] read instruction memory at PC; compute $"PC" + 4$.

  + #strong[Decode/register read:] interpret opcode/fields, read `rs` and `rt`, extend immediate, generate controls.

  + #strong[Execute:] ALU performs arithmetic/logic, calculates load/store address, or compares branch operands. A separate adder calculates the branch target.

  + #strong[Memory:] `lw` reads data memory; `sw` writes it; other supported instructions do neither.

  + #strong[Writeback:] write an ALU result or memory value when `RegWrite=1`.

  These are conceptual stages, not necessarily five clock cycles.

  // Vault: 300 Main Notes/Control Path.md -> Attachments/Control Path Diagram.png.
  // One integrated figure preserves both the complete datapath and its control wiring.
  #block(breakable: false)[
    = Complete single-cycle datapath and control path
    #align(center, image("images/single-cycle-datapath-control.png", width: 100%))
    #text(size: 7.6pt)[Black routes carry data; red/brown routes carry controls. Opcode feeds main control; `funct` and `ALUop` feed ALU control. `RegWrite` enables register-file writeback. `PCSrc = Branch AND isZero` selects the next PC.]
  ]

  = ALU and two-level control
  The ALU performs arithmetic and logical work; each bit's carry-out feeds the next bit's carry-in. Its control bits are `Ainvert`, `Binvert`, and a 2-bit `Operation` selector. For subtraction, invert B and set the least-significant carry-in to 1: $A - B = A + overline(B) + 1$. The 4-bit `ALUcontrol` value selects the ALU's operation. The ALU also produces `isZero`, which is 1 if its result is zero; this is a #emph[status output], not an instruction-decoder output.

  #strong[Two-level decoding:] instruction opcode $arrow.r$ main control signals and 2-bit `ALUop`; then $mono("ALUop") + mono("funct")$ (for R type) $arrow.r$ 4-bit `ALUcontrol` $arrow.r$ actual ALU action. `ALUop` classifies how to determine the operation; `ALUcontrol` directly drives the ALU. The `funct` field is ignored for `lw`, `sw`, and `beq`.

  // Vault: CS2100 Lecture 12.md -> CS2100 Lecture 12 ALUcontrol Basic Overview.png.
  #block(breakable: false)[
    #align(center, image("images/alu-two-level-control.png", width: 85%))
    #text(size: 7.6pt)[Two-level decoding: opcode → `ALUop`; `ALUop` + R-type `funct` → `ALUcontrol`.]
  ]

  = What each control signal means
  #strong[Mux selectors (choose a data path):]

  - #strong[RegDst:] 0 chooses instruction bits \[20:16\], `rt`, as the register-file destination; 1 chooses bits \[15:11\], `rd`. Its value is irrelevant when `RegWrite=0`.

  - #strong[ALUSrc:] 0 supplies the ALU's second input from register Read Data 2; 1 supplies the sign-extended 16-bit immediate in this simplified datapath. `beq` needs 0 to compare two registers.

  - #strong[MemToReg:] 0 writes the ALU result to a register; 1 writes data read from memory. It matters only if `RegWrite=1`. The mux selects #emph[what] to write; `RegWrite` decides #emph[whether] a write occurs.

  - #strong[PCSrc:] 0 chooses the sequential next PC, $"PC" + 4$; 1 chooses the branch target $"PC" + 4 + \( "signext" \( "imm" \) lt.double 2 \)$.

  #strong[Write and memory enables:]

  - #strong[RegWrite:] 1 enables a write to the register file at the active clock edge; 0 suppresses it. `lw` and supported R-type ALU instructions write a register; `sw/beq` do not. Writes to MIPS `$zero` are ignored. PC updating is separate.

  - #strong[MemRead:] 1 reads data memory at the ALU-computed address (used by `lw`). #strong[MemWrite:] 1 writes register Read Data 2 to data memory at that address (used by `sw`). Both are 0 for R type and `beq`; both 1 is unused in this datapath.

  #strong[Operation and branch signals:]

  - #strong[Branch:] main control sets this to 1 for `beq` in the lecture's branch circuit. It identifies a conditional branch; it does not by itself say whether the branch is taken.

  - #strong[ALUop (2 bits):] 00 means #highlight[add] for `lw/sw` address calculation; 01 means #highlight[subtract] for `beq` comparison; 10 means use R-type `funct`; 11 is #highlight[unused] here.

  - #strong[ALUcontrol (4 bits):] final ALU selector generated from `ALUop` and, when needed, the 6-bit `funct`. The course table uses 0010 = add, 0110 = subtract, 0000 = AND, 0001 = OR, 0111 = set-on-less-than.

  - #strong[isZero:] ALU output, 1 iff ALU result is zero. For `beq`, subtracting $R \[ "rs" \] - R \[ "rt" \]$ makes it 1 when the operands are equal.

  = ALUop and ALUcontrol lookup
  #figure(
    align(center)[#table(
      columns: (auto, auto, auto, 1fr),
      align: (left, left, left, left),
      table.header([#strong[Instruction]], [#strong[ALUop]], [#strong[funct]], [#strong[ALUcontrol / action]]),
      table.hline(),
      [`lw`, `sw`], [00], [ignored], [0010 / add base + offset],
      [`beq`], [01], [ignored], [0110 / subtract, test zero],
      [`add`], [10], [100000], [0010 / add],
      [`sub`], [10], [100010], [0110 / subtract],
      [`and`], [10], [100100], [0000 / bitwise AND],
      [`or`], [10], [100101], [0001 / bitwise OR],
      [`slt`], [10], [101010], [0111 / set less than],
    )],
    kind: table,
  )

  #strong[Branch decision:] the opcode decoder supplies `Branch`; the ALU supplies `isZero`; a separate adder supplies the branch address. For the `beq`-only design, #box(stroke: black, inset: 3pt)[$"PCSrc" = "Branch" and "isZero"$]. For `bne`, the comparison condition must instead detect #emph[not equal].

  = Main-control settings by instruction
  #figure(
    align(center)[#table(
      columns: 9,
      align: (left, center, center, center, center, center, center, center, center),
      table.header(
        [#strong[Type]],
        [#strong[Dst]],
        [#strong[Src]],
        [#strong[M2R]],
        [#strong[RW]],
        [#strong[MR]],
        [#strong[MW]],
        [#strong[Br]],
        [#strong[ALUop]],
      ),
      table.hline(),
      [R type], [1], [0], [0], [1], [0], [0], [0], [10],
      [`lw`], [0], [1], [1], [1], [1], [0], [0], [00],
      [`sw`], [X], [1], [X], [0], [0], [1], [0], [00],
      [`beq`], [X], [0], [X], [0], [0], [0], [1], [01],
    )],
    kind: table,
  )

  #emph[Dst = RegDst; Src = ALUSrc; M2R = MemToReg; RW = RegWrite; MR = MemRead; MW = MemWrite; Br = Branch. X = don't care because the corresponding output is not used for that instruction.]

  = Trace each instruction through the datapath
  #strong[R-type ALU operation (for example, `add rd,rs,rt`):] Fetch the instruction, read $R \[ "rs" \]$ and $R \[ "rt" \]$, then set `ALUSrc=0`. `ALUop=10` tells the ALU-control unit to inspect `funct`; the final `ALUcontrol` selects the operation. Select `rd` with `RegDst=1` and the ALU result with `MemToReg=0`; `RegWrite=1` writes the result. Data memory is inactive. Sequential execution selects $"PC" + 4$.

  #strong[`lw rt,offset(rs)`:] Read base $R \[ "rs" \]$, sign-extend the 16-bit byte offset, and set `ALUSrc=1`. With `ALUop=00`, the ALU adds base and offset to form the effective address. `MemRead=1` obtains the word. Select `rt` (`RegDst=0`) and memory data (`MemToReg=1`); `RegWrite=1` saves it in the register file.

  #strong[`sw rt,offset(rs)`:] The ALU forms the same base-plus-offset address as for `lw`. The register file also reads $R \[ "rt" \]$, which supplies data memory's Write Data input. Set `MemWrite=1`, `MemRead=0`, and `RegWrite=0`. `RegDst` and `MemToReg` are don't-cares because there is no register writeback.

  #strong[`beq rs,rt,label`:] Read two registers and set `ALUSrc=0`. `ALUop=01` selects subtraction; `isZero=1` means the values were equal. In parallel, a dedicated adder forms $"PC" + 4 + \( "signext" \( "imm" \) lt.double 2 \)$. The opcode sets `Branch=1`; thus `PCSrc=isZero` for this instruction. No data-memory access or general-purpose register write occurs.

  = A quick way to derive control values
  First ask #emph[where the second ALU operand comes from] (`ALUSrc`). Next ask #emph[which ALU operation is needed] (`ALUop` then `ALUcontrol`). Ask whether data memory is read or written (`MemRead`, `MemWrite`). If a register is written, choose its number (`RegDst`) and writeback value (`MemToReg`), then enable `RegWrite`. Finally decide whether the next PC is sequential or a taken branch (`Branch`, `isZero`, `PCSrc`). A mux select is a don't-care whenever its output is not used.

  = Clocking and implementation choices
  During a clock period, current state feeds combinational logic; enabled state elements capture results at the active edge. The PC supplies the current instruction address while next-PC logic computes its replacement.

  #strong[Single cycle:] each instruction completes in one clock period; the period must fit the longest path, typically `lw` (instruction memory $arrow.r$~register read $arrow.r$~ALU $arrow.r$~data memory $arrow.r$~register writeback).

  #strong[Multicycle:] execution steps occupy separate cycles. Intermediate results need storage; a controller tracks the step. The period can be shorter, but instructions need variable numbers of cycles.

  #strong[Pipelining:] different instructions occupy different stages at once, separated by pipeline registers. Once filled, ideal throughput approaches one completed instruction per cycle; dependencies and hazards can cause stalls or flushes. A faster clock alone does not guarantee a faster program.

  = Concept links and exam pitfalls
  - C array indexing $arrow.r$ element size $arrow.r$ byte offset $arrow.r$ base+offset effective address $arrow.r$ `lw/sw`. For a 4-byte `int` array, element $i$ begins $4 i$ bytes after the base.

  - Signed integer $arrow.r$ two's-complement bit pattern $arrow.r$ sign extension of an arithmetic immediate $arrow.r$ ALU addition/subtraction and overflow check.

  - Floating-point value $arrow.r$ sign, biased exponent, fraction $arrow.r$ finite range and relative precision $arrow.r$ rounding after an operation.

  - C expression $arrow.r$ compiler temporaries $arrow.r$ processor registers. Register pressure can spill values to memory, introducing extra loads and stores.

  - C `if` or loop $arrow.r$ `slt` or a branch comparison $arrow.r$ encoded offset $arrow.r$ target-address adder and next-PC multiplexer.

  - Branch offsets count #emph[words] and are shifted left two places; `lw/sw` offsets count #emph[bytes]. Both ultimately form byte addresses.

  - In I format, `rt` is not always a destination. `sw` uses it as source data, and `beq` compares it.

  - Carry-out is not the same as signed two's-complement overflow. `RegWrite` does not control PC updating. `isZero` comes from the ALU, whereas `Branch` comes from decoding.

  - The simplified datapath and control table cover `lw`, `sw`, `beq`, and R-type `add/sub/and/or/slt`. `bne`, jumps, shifts, immediate arithmetic, and other instructions require corresponding datapath or control extensions.

  = Boolean algebra laws and theorems
  #table(
    columns: (auto, 1fr, 1fr),
    stroke: 0.4pt + black,
    inset: (x: 3pt, y: 1.5pt),
    fill: (x, y) => if calc.odd(y) { lightgray } else { white },
    table.header([*Law*], [*Identity 1*], [*Identity 2*]),
    [Identity], [$A + 0 = 0 + A = A$], [$A dot 1 = 1 dot A = A$],
    [Complement], [$A + A' = A' + A = 1$], [$A dot A' = A' dot A = 0$],
    [Commutative], [$A + B = B + A$], [$A dot B = B dot A$],
    [Associative], [$A + (B + C) = (A + B) + C$], [$A dot (B dot C) = (A dot B) dot C$],
    [Distributive], [$A dot (B + C) = A dot B + A dot C$], [$A + B dot C = (A + B) dot (A + C)$],
    [Idempotency], [$X + X = X$], [$X dot X = X$],
    [One / zero], [$X + 1 = 1 + X = 1$], [$X dot 0 = 0 dot X = 0$],
    [Involution], table.cell(colspan: 2)[$(X')' = X$],
    [Absorption 1], [$X + X dot Y = X$], [$X dot (X + Y) = X$],
    [Absorption 2], [$X + X' dot Y = X + Y$], [$X dot (X' + Y) = X dot Y$],
    [De Morgan], [$(X + Y)' = X' dot Y'$], [$(X dot Y)' = X' + Y'$],
    [Consensus], table.cell(colspan: 2)[
      $X dot Y + X' dot Z + Y dot Z = X dot Y + X' dot Z$\
      $(X + Y) dot (X' + Z) dot (Y + Z) = (X + Y) dot (X' + Z)$
    ],
    [Misc], table.cell(colspan: 2)[$X + Y = (X xor Y) + X dot Y$],
  )

  = Minterms and Maxterms
  #table(
    columns: (auto, auto, auto, auto, auto, auto),
    align: center,
    stroke: 0.5pt + rgb("6655BB"),
    inset: (x: 4pt, y: 2pt),

    // First header row
    table.cell(rowspan: 2)[$x$],
    table.cell(rowspan: 2)[$y$],
    table.cell(colspan: 2)[*Minterms*],
    table.cell(colspan: 2)[*Maxterms*],

    // Second header row
    [Term], [Notation],
    [Term], [Notation],

    // Data rows
    [0], [0],
    [$x' dot y'$], [$m_0$],
    [$x + y$], [$M_0$],

    [0], [1],
    [$x' dot y$], [$m_1$],
    [$x + y'$], [$M_1$],

    [1], [0],
    [$x dot y'$], [$m_2$],
    [$x' + y$], [$M_2$],

    [1], [1],
    [$x dot y$], [$m_3$],
    [$x' + y'$], [$M_3$],
  )

  // Source: Obsidian Vault/100 Source Notes/Lectures/CS2100 Lecture 13.md
  = Canonical SOP / POS: truth table to expression
  Fix the variable order first: for $A B C$, $A$ is the MSB and $C$ the LSB; row index $i=4A+2B+C$. A minterm $m_i$ is 1 only on row $i$; a maxterm $M_i$ is 0 only on row $i$. Each contains every variable exactly once; $m_i'=M_i$.

  #block(breakable: false)[#table(
    columns: (auto, 1fr, 1fr), stroke: 0.3pt + lightgray,
    table.header([*Form*], [*Select rows*], [*Literal rule for row bits*]),
    [Canonical SOP], [$F= sum m("1-row indices")$], [0 → complemented; 1 → plain; AND literals],
    [Canonical POS], [$F= product M("0-row indices")$], [0 → plain; 1 → complemented; OR literals],
  )]
  Here $sum m$ means OR of minterms; $product M$ means AND of maxterms. For a fully specified function, the two index lists partition all $2^n$ rows ($n$ input variables). Complementing $F$ swaps its 1-row and 0-row lists.

  #strong[Example ($A B C$ order):] $F=sum m(0,1,3,6)=product M(2,4,5,7)$.
  Row $3=011_2$: $m_3=A' B C$, $M_3=A+B'+C'$.
  Thus $F'=sum m(2,4,5,7)=product M(0,1,3,6)$.
  To expand a noncanonical term, insert missing $X$ using $X+X'=1$ in SOP or $X X'=0$ in POS, then distribute.

  // Source: Obsidian Vault/100 Source Notes/Lectures/CS2100 Lecture 14.md
  // Vault: 300 Main Notes/Karnaugh Maps(K-Maps).md -> Example 4-var K-Map Filling.png.
  #block(breakable: false)[
    = K-maps: adjacency and wrap-around
    #grid(
      columns: (2fr, 3fr), column-gutter: 3mm,
      [#align(center, image("images/kmap-adjacency.png", width: 100%))],
      [Rows/columns follow *Gray order* 00, 01, 11, 10. Adjacent cells differ in exactly one variable; opposite edges touch, including all four corners. Diagonals are not adjacent.

       For SOP, cover every 1 with rectangular groups of 1, 2, 4, 8, … cells; overlap is allowed. Keep only variables constant across a group. Use don't-cares only when helpful.

       *Example:* corner minterms $m(0,2,8,10)$ form a group of four: $F=x' z'$ in the pictured $w x y z$ order.],
    )
    A *prime implicant* cannot be enlarged; an *essential* one covers a 1 no other prime covers. Include essentials, then cover remaining 1s with few additional groups.
  ]

  = SOP and POS implementation in circuits
  #block(breakable: false)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 4mm,
    row-gutter: 3pt,
    [#strong[SOP: sum of products]\
     $F = A dot B + C' dot D + E$],
    [#strong[POS: product of sums]\
     $G = (A + B) dot (C' + D) dot E$],
    [#strong[2-level AND-OR]], [#strong[2-level OR-AND]],
    align(center, image("images/sop-and-or-crop.png", height: 19mm)),
    align(center, image("images/pos-or-and-crop.png", height: 19mm)),
    [#strong[2-level NAND-NAND]], [#strong[2-level NOR-NOR]],
    align(center, image("images/sop-nand-crop.png", height: 19mm)),
    align(center, image("images/pos-nor-crop.png", height: 19mm)),
    [$F = ((A dot B)' dot (C' dot D)' dot E')'$],
    [$G = ((A + B)' + (C' + D)' + E')'$],
  )

  ]

  #strong[Remember:] input inverters count as #emph[gates], but not as #emph[logic levels]. A lone literal ($E$) is inverted before the final NAND/NOR. NAND and NOR are universal; tie inputs together for NOT: $X' = (X dot X)' = (X + X)'$.

  // Source: Obsidian Vault/100 Source Notes/Lectures/CS2100 Lecture 14.md
  = PLA versus ROM: implement multiple outputs
  #table(
    columns: (auto, 1fr, 1fr), stroke: 0.3pt + lightgray,
    table.header([*Feature*], [*PLA*], [*ROM*]),
    [First stage], [Programmable AND plane: chosen product terms], [Fixed decoder: all input minterms],
    [Output stage], [Programmable OR plane; terms may feed several outputs], [Stored/programmed output bits for each address],
    [Limit], [Must have enough product terms and output connections], [Every mapping fits if address depth/output width suffice],
  )
  #strong[Reading a PLA:] connected input literals are ANDed to form each product; connected products are ORed at each output. A complemented input selects the inverted literal. An omitted variable is absent from that product.

  #strong[Connection example:] inputs $A,B,C$; products $P=A' B$, $Q=B C$; outputs $F=P+Q$, $G=P$.
  #table(
    columns: (auto, 1fr, auto, auto), stroke: 0.3pt + lightgray,
    table.header([*AND term*], [*Connected literals*], [*OR → F*], [*OR → G*]),
    [$P$], [$A',B$ ($C$ omitted)], [●], [●],
    [$Q$], [$B,C$ ($A$ omitted)], [●], [—],
  )
  ● = connected; — = no connection. ROM for the same 3-input, 2-output mapping: $2^3 times 2=16$ stored output bits (decoder hardware excluded).

  // Sources: Obsidian Vault/100 Source Notes/Lectures/CS2100 Lectures 15 and 17.md
  = Adders: one bit to a word
  All signals below are bits: $A,B$ = operands; $S$ = sum bit; $C_("in"),C_("out")$ = carry into/out of this position. In these Boolean equations, $+$ is OR, juxtaposition is AND, and $xor$ is XOR.
  #table(
    columns: (auto, 1fr, 1fr), stroke: 0.3pt + lightgray,
    table.header([*Block*], [*Sum*], [*Carry-out*]),
    [Half-adder (HA)], [$S=A xor B$], [$C_("out")=A B$],
    [Full-adder (FA)], [$S=A xor B xor C_("in")$], [$C_("out")=A B+A C_("in")+B C_("in")$],
  )
  #strong[Two HAs + OR:] $P=A xor B$; first carry $A B$; second carry $P C_("in")$. Hence FA carry $=A B+P C_("in")$. Example: $A=B=C_("in")=1$ gives $(C_("out"),S)=11_2$ (integer 3).

  #strong[Carry chaining:] an $n$-bit ripple adder uses $n$ FAs. At bit $i=0,dots,n-1$ (LSB first), inputs are $A_i,B_i,C_i$; outputs are $S_i,C_(i+1)$. Feed each carry to the next stage; $C_0=0$ for ordinary addition. Unsigned result is $(C_n S_(n-1) dots S_0)_2$. Carries must propagate through the chain; final carry alone is not signed overflow.

  // Vault: CS2100 Lecture 17.md -> 4-bit Parallel Adder Implementation.png.
  #block(breakable: false)[
    #align(center, image("images/ripple-carry-adder.png", width: 85%))
    #text(size: 7.6pt)[Four full adders: carries ripple from the rightmost LSB to the leftmost MSB. Source labels bits 1–4 and carries 1–5; the equations above use bits 0–3 and carries 0–4.]
  ]

  // Source: Obsidian Vault/100 Source Notes/Lectures/CS2100 Lecture 18.md
  // Priority-encoder all-zero validity follows the embedded table (V=0), not the prose typo.
  = MSI circuits: select, decode, encode
  Here $n$ is a count of select/address bits; table assumes full $2^n$-line blocks and active-high data unless marked otherwise.
  #table(
    columns: (auto, 1fr, 1fr), stroke: 0.3pt + lightgray,
    table.header([*Block*], [*Inputs → outputs*], [*Behaviour when enabled*]),
    [Decoder], [$n$ address bits → $2^n$ lines], [Assert the line named by the binary address],
    [Demux], [1 data + $n$ select bits → $2^n$ lines], [Route data to selected output; others 0],
    [Mux], [$2^n$ data + $n$ select bits → 1 line], [Output selected data input],
    [Encoder], [$2^n$ lines → $n$ code bits], [Encode the single asserted input; assumes one-hot],
    [Priority encoder], [Input lines → code + valid bit $V$], [Encode highest-priority asserted input; $V=0$ if none],
  )
  A bar/bubble marks active-low: enable is asserted at 0; an active-low decoder selects a 0 output (others 1). Check enable/output polarity independently. A decoder with its enable driven by data acts as a demux; account for polarity.

  #strong[Decoder → function:] active-high output $D_i=m_i$. For $F=sum m(0,1,3,6)$, OR $D_0,D_1,D_3,D_6$. With active-low outputs $L_i=m_i'$, NAND those same lines: $F=(L_0 L_1 L_3 L_6)'$.

  #strong[Mux → function:] 2:1 mux $Y=S'I_0+S I_1$, where $S$ selects data $I_0$ or $I_1$. For 4:1, $S_1S_0=00,01,10,11$ selects $I_0,I_1,I_2,I_3$ respectively. Select width is independent of each data input's bit width.

  // Vault: CS2100 Lecture 18.md -> 41 Multiplexer Circuit.png.
  #block(breakable: false)[
    #align(center, image("images/mux-decoder-gates.png", width: 85%))
    #text(size: 7.6pt)[4:1 mux: decode $S_1 S_0$ into four enables, AND each with its data input, then OR the results. Right: equivalent gate expansion.]
  ]

  #strong[Use a smaller mux:] choose select variables; for each select combination, inspect the two truth-table outputs for remaining variable $x=0,1$:
  #table(
    columns: (auto, auto, auto, auto, auto), align: center, stroke: 0.3pt + lightgray,
    [*Output pair*], [00], [01], [10], [11],
    [*Connect data input to*], [0], [$x$], [$x'$], [1],
  )
  Example: $F(A,B,C)=sum m(0,1,3,6)$; choose $S_1=A$, $S_0=B$, leave $x=C$. Pairs for $A B=00,01,10,11$ are 11,01,00,10, so $(I_0,I_1,I_2,I_3)=(1,C,0,C')$.

  #strong[Priority example:] $D_3>D_2>D_1>D_0$; inputs $(D_3,D_2,D_1,D_0)=0101$ give code $10$ and $V=1$ ($D_2$ wins). All zero gives $V=0$, code don't-care; $D_0$ alone gives code $00$, $V=1$.

  // Source: Obsidian Vault/100 Source Notes/Lectures/CS2100 Lecture 19.md
  // JK and D-latch prose typos resolved using the lecture's characteristic table/circuit.
  = Latches and flip-flops
  Store 1 bit: $Q$ = present state, $Q^+$ = next state; set = 1, reset = 0, hold = $Q$, toggle = $Q'$. Outputs $Q$ and $Q'$ are complementary in valid states.

  #grid(
    columns: (1fr, 1fr), column-gutter: 4mm,
    [#strong[Latch: level-sensitive]\
     Gated latch responds throughout $"EN" = 1$; holds when $"EN" = 0$. A D latch is #emph[transparent] while enabled.],
    [#strong[Flip-flop: edge-triggered]\
     Updates only at the selected clock edge: $arrow.t$ rising ($0 arrow.r 1$), $arrow.b$ falling ($1 arrow.r 0$). Holds between edges.],
  )

  // Vault: Memory Element Latches.md and Memory Element.md; circuit and pulse/edge attachments.
  #block(breakable: false)[
    #grid(
      columns: (1fr, 1fr), column-gutter: 3mm,
      [#align(center, image("images/d-latch-circuit.png", width: 100%))
       #text(size: 7.6pt)[Gated D latch: EN=1 lets Q follow D; EN=0 holds Q.]],
      [#align(center, image("images/clock-pulses-edges.png", width: 100%))
       #text(size: 7.6pt)[Level sensitivity spans the pulse; edge triggering samples at a transition.]],
    )
  ]

  #strong[Shared S-R / J-K behaviour] (active-high inputs; evaluated only when enabled / triggered):
  #table(
    columns: (auto, 1fr, 1fr),
    stroke: 0.3pt + lightgray,
    table.header([*S R / J K*], [*$Q^+$*], [*Action*]),
    [00], [$Q$], [Hold],
    [01], [0], [Reset],
    [10], [1], [Set],
    [11], [S-R: invalid; J-K: $Q'$], [Avoid for S-R; toggle for J-K],
  )

  #grid(
    columns: (1fr, 1fr), column-gutter: 4mm,
    [#strong[Latch variants]
     - *S-R (NOR):* active-high; always responds to S/R. At 11, both outputs are 0.
     - *S-R (NAND):* active-low $overline(S), overline(R)$; 11 holds, 01 sets, 10 resets; 00 invalid (both outputs 1).
     - *Gated S-R:* adds EN; external S/R are active-high. EN=0 holds; EN=1 uses the table.
     - *Gated D:* $S=D$, $R=D'$; EN=1 gives $Q^+=D$, otherwise holds. No invalid input pair.
    ],
    [#strong[Flip-flop variants]
     - *S-R:* same S/R table, applied at the clock edge.
     - *J-K:* replaces S-R's invalid 11 with toggle.
       $Q^+ = J dot Q' + K' dot Q$
     - *D:* samples D at the edge; $Q^+=D$.
     - *T:* tie $J=K=T$; 0 holds, 1 toggles.
       $Q^+ = T xor Q$
    ],
  )

  // Lecture 19: matching compact state table and complete state diagram.
  #block(breakable: false)[
    #grid(
      columns: (1fr, 1fr), column-gutter: 4mm,
      [#strong[Excitation table]
       #align(center, image("images/flip-flop-excitation-table.png", width: 100%))
       $Q arrow.r Q^+$ determines inputs; $X$ = don't care.
      ],
      [#strong[State table and diagram example]
       #align(center, image("images/state-table-example.png", width: 90%))
       #align(center, image("images/state-diagram-example.png", height: 28mm))
       State = $A B$; arrow label = input/output ($x/y$).
      ],
    )
  ]

  #strong[Asynchronous PRE / CLR:] override clocked operation immediately: preset sets $Q=1$; clear resets $Q=0$. A bar or input bubble means active-low (assert at 0); otherwise active-high (assert at 1). Both inactive = normal operation; avoid asserting both together.

  // Source: Obsidian Vault/100 Source Notes/Lectures/CS2100 Lecture 19.md,
  // Sequential Circuit Design.png and the augmented-table / K-map design slides.
  = Sequential-circuit design: state → inputs → gates
  + Derive a state table from the specification/diagram; reduce equivalent states if needed. Assign binary codes. For $N$ required states, use at least $m=ceil(log_2 N)$ flip-flops ($N,m$ are counts).
  + Choose flip-flop type. For every present-state/input row, write next state and output. With $m$ flip-flops and $n$ binary inputs, the full table has $2^(m+n)$ rows.
  + For #emph[each state bit], use its $Q arrow.r Q^+$ transition and the excitation table to fill required flip-flop inputs: this is the #emph[augmented state table].
  + Simplify each flip-flop input function and output function separately (K-map/algebra). Draw their gates feeding the flip-flops; connect the common clock and any specified reset/preset.

  #strong[Worked design: 2-bit enabled counter.] Present state $A B$, next state $A^+ B^+$, input $x$; all are bits. At each rising edge: $x=0$ holds; $x=1$ cycles $00 arrow.r 01 arrow.r 10 arrow.r 11 arrow.r 00$. Use two JK flip-flops.
  For $A B=01$, $x=1$: $A:0 arrow.r 1$ requires $J_A=1,K_A=X$; $B:1 arrow.r 0$ requires $J_B=X,K_B=1$ ($X$ = don't-care).
  Over the full table, $B$ toggles iff $x=1$; $A$ toggles iff $B x=1$. Simplified inputs: #box(stroke: navy, inset: 2pt)[$J_B=K_B=x; quad J_A=K_A=B x$]. Wire these functions to the two JK blocks and the same rising-edge clock.

  #strong[Unused states:] use don't-cares only when their behaviour is unspecified. If recovery from an unused state is required, specify its transition and verify the resulting circuit instead.

  // Source: Lecture 19 memory notes and Bigger Memory Array Diagram.png.
  = Memory: capacity and organisation
  1 byte = 8 bits; a word is the transfer unit (MIPS: 32 bits = 4 bytes). Binary sizes used in the lecture: K = $2^10$, M = $2^20$, G = $2^30$; KiB/MiB/GiB denote these byte multiples explicitly.

  #table(
    columns: (auto, 1fr), stroke: 0.3pt + lightgray,
    [*Organisation*], [$N times W$ = $N$ words, $W$ bits per word],
    [*Capacity*], [$N W$ bits = $"NW" / 8$ bytes],
    [*Address lines*], [$a = log_2 N$ for $N=2^a$ addressable words],
    [*Data lines*], [$W$ (word width)],
    [*From $n times w$ chips*], [Chips per bank $=W/w$; banks $=N/n$],
    [*Total chips*], [$(N/n) dot (W/w)$ (assuming exact multiples)],
  )

  #strong[Width vs. depth:] chips in parallel share address/control lines and supply different data bits, increasing #emph[word width]. Banks increase #emph[number of words]: lower address bits select a word inside every chip; upper bits feed a decoder to enable one bank. $B=2^b$ banks need $b$ bank-select bits and a $b$-to-$B$ decoder.

  #block(breakable: false)[
    #grid(
      columns: (1fr, 1fr), column-gutter: 4mm,
      [#strong[Lecture example: $2 "M" times 32$ from $512 "K" times 8$]
       - $32/8 = 4$ chips per bank.
       - $2^21/2^19 = 4$ banks.
       - $4 times 4 = 16$ chips total.
       - $A_0$--$A_18$: 19-bit chip address.
       - $A_19, A_20$: 2-to-4 bank decoder.
       - 21 address lines, 32 data lines; capacity = 8 MiB.
      ],
      [#align(center, image("images/memory-chip-array-crop.png", width: 100%))],
    )
  ]

  #strong[Addressing pitfall:] address bits count #emph[addressable units], not total data bits. The example is #emph[word-addressed]: $2^21$ words need 21 address bits. The same 8 MiB as byte-addressed memory needs 23 bits; the lowest 2 bits select a byte within a 32-bit word.

  #grid(
    columns: (1fr, 1fr), column-gutter: 4mm,
    [#strong[SRAM]\
     Bistable storage; retains data while powered without refresh. Faster, less dense; typically cache.],
    [#strong[DRAM]\
     Capacitor charge; requires periodic refresh. Denser, cheaper per bit; typically main memory.],
  )
  Both are #strong[volatile] (lose data without power). ROM is non-volatile and intended mainly for reading.

  #strong[Transfers:] MAR holds the address; MDR holds data being read/written. Read: supply address, assert read, receive data. Write: supply address + data, assert write. Lecture control convention: memory enable = 0 means no operation; with enable = 1, Read/Write = 1 reads and 0 writes.

  = Pipelining: stages and registers
  Overlap instructions using different stages; one cycle per stage. After filling, ideally complete #strong[one instruction per cycle]. Throughput improves; an individual instruction still takes 5 cycles. Slowest stage limits the clock; dependencies can require stalls.

  #table(
    columns: (auto, 1fr, 1fr), stroke: 0.3pt + lightgray,
    table.header([*Stage*], [*Work*], [*Saved at cycle end*]),
    [*IF*], [Fetch instruction; compute PC+4], [*IF/ID:* instruction, PC+4],
    [*ID*], [Decode; read regs; sign-extend], [*ID/EX:* operands, imm., PC+4, reg. numbers, controls],
    [*EX*], [ALU operation; branch target and Zero; select destination], [*EX/MEM:* ALU result, store data, target, Zero, destination, M/WB controls],
    [*MEM*], [Read/write data; resolve branch], [*MEM/WB:* memory/ALU data, destination, WB controls],
    [*WB*], [Write selected result if enabled], [Register file updated; no next pipeline register],
  )

  #strong[Keep each instruction together:] carry its data, destination register number, and control bits through the pipeline. WB must use the destination in #strong[MEM/WB], not the register number of the newer instruction currently in ID.

  #strong[Control:] generated in ID; carry later-stage controls forward until used:
  - *EX:* RegDst, ALUSrc, ALUop.
  - *MEM:* Branch, MemRead, MemWrite.
  - *WB:* MemToReg, RegWrite.

  #align(center, image("images/pipeline-control-flow.png", width: 50%))

  // Vault: 300 Main Notes/MIPS Pipeline Control.md -> Pipeline Datapath and Contro.png.
  #block(breakable: false)[
    = Complete pipelined datapath and control
    #align(center, image("images/pipeline-datapath-control.png", width: 100%))
    #text(size: 7.6pt)[Vertical bars are pipeline registers. Carry each instruction's destination and later-stage control bits with its data; the WB feedback returns the selected result to the register file. Branch selection is shown in MEM.]
  ]

  = Pipeline timing and speedup
  #table(
    columns: (auto, 1fr), stroke: 0.3pt + lightgray,
    [*Pipeline clock*], [$C_p = max(T_k) + T_d$],
    [*Cycles / total time*], [$I + N - 1$ cycles; $T_p = (I + N - 1) C_p$],
    [*With $S$ stall cycles*], [$T_p = (I + N - 1 + S) C_p$],
    [*Single-cycle baseline*], [$C_s$ = longest instruction path; $T_s = I C_s$],
    [*Speedup*], [$T_s/T_p$; use the same workload for both],
  )

  #strong[Symbols:] counts are unitless; all delays, clock periods, and execution times use the same time unit (e.g. ns).
  Assume no stalls unless stated. Speedup $T_s/T_p$ is a unitless ratio.

  #table(
    columns: (auto, 1fr, auto, 1fr), stroke: 0.3pt + lightgray,
    [$I$], [Number of instructions executed], [$N$], [Number of pipeline stages (MIPS: 5)],
    [$k$], [Stage index, 1 to $N$], [$T_k$], [Logic delay of stage $k$],
    [$T_d$], [Extra delay per cycle from pipeline registers], [$max(T_k)$], [Slowest stage's logic delay],
    [$C_p$], [Pipeline clock period (time per cycle)], [$C_s$], [Single-cycle processor's clock period],
    [$T_p$], [Total pipelined execution time], [$T_s$], [Total single-cycle execution time],
    [$S$], [Total added stall cycles over the workload], [$T$], [Common stage delay in the ideal case],
  )

  #strong[Lecture example:] stage delays = 2, 1, 2, 2, 1 ns; $T_d=0.5$ ns; $I=100$. Single-cycle clock = 8 ns (longest path, `lw`): $T_s=800$ ns. Pipeline clock = 2.5 ns; $T_p=(100+4) times 2.5=260$ ns. Speedup $=800/260 approx 3.08$.

  #strong[Ideal limit:] if all stages take $T$, overhead/stalls are zero, and the sequential baseline takes $N T$ per instruction:
  $ "Speedup" = (I N T)/((I + N - 1) T) = (I N)/(I + N - 1) arrow.r N quad (I "much larger than" N). $
  #strong[Pitfalls:] include the $N-1$ fill/drain cycles; do not use average stage delay for the pipeline clock. Unequal stage delays, register overhead, and stalls reduce speedup.


  = Pipeline hazards
  A hazard prevents the next instruction from advancing on schedule. #strong[Stall:] wait/insert a bubble while older instructions proceed. #strong[Flush:] discard wrong-path instructions before they change architectural state.

  #table(
    columns: (auto, 1fr, 1fr), stroke: 0.3pt + lightgray,
    table.header([*Hazard*], [*Problem / concrete example*], [*Solution*]),
    [*Structural*], [#highlight(fill: rgb("DCEEFF"))[IF] and `lw/sw` in #highlight(fill: rgb("DCEEFF"))[MEM] need the #highlight(fill: rgb("DCEEFF"))[same single-port memory] in one cycle.], [Shared memory: *1 IF stall per conflicting cycle*. Separate I/D memories or an extra port: *0 structural stalls*.],
    [*Data (RAW)*], [`add `#highlight(fill: yellow)[`$t0`]`, $t1,$t2`\
      `sub $t3,`#highlight(fill: yellow)[`$t0`]`,$t4`\
      `sub` reads the old #highlight(fill: yellow)[`$t0`] in ID before `add` writes it in WB.], [Forward EX/MEM → EX: 0 stalls. Without forwarding: wait for WB (2 stalls here), or schedule independent work.],
    [*Control*], [#highlight(fill: yellow)[`beq $s0,$s1,L`]\
      #highlight(fill: rgb("FFE0E3"))[`add $t0,$t1,$t2`]\
      Taken branch: `add` is #highlight(fill: rgb("FFE0E3"))[wrong-path] (no delay slot); it must not write `$t0`.], [Stall; resolve in ID; predict + flush if wrong; or fill a delay slot with work safe on both paths. Details below.],
  )
  #strong[Register-file timing:] write in the first half-cycle, read in the second: ID can read a register written in WB #emph[in the same cycle]. This does not remove dependencies on results still in EX/MEM.

  = Data hazards: availability vs. need
  #strong[Forwarding:] bypass stale register data via EX/MEM or MEM/WB. ALU results are ready after EX; loads after MEM. A result cannot be forwarded before it exists.

  #table(
    columns: (1fr, auto, auto, 1fr), stroke: 0.3pt + lightgray,
    table.header([*Adjacent producer → consumer*], [*No fwd*], [*Fwd*], [*Solution / remaining wait*]),
    [ALU → operand in EX], [2], [0], [Forward EX/MEM → EX],
    [`lw` → operand in EX], [2], [1], [`lw `#highlight(fill: yellow)[`$t0`]`,0($s0)` then `add $t1,`#highlight(fill: yellow)[`$t0`]`,$t2`: 1 bubble, then MEM/WB → EX],
    [ALU → branch in ID], [2], [1], [Wait 1 cycle, then forward to ID],
    [`lw` → branch in ID], [2], [2], [Wait 2 cycles for load data, then forward to ID],
  )
  #strong[Data stalls only:] adjacent instructions; 5 stages; WB writes before ID reads. No fwd = wait for WB; fwd = listed bypass paths exist. Independent instructions can fill the listed gaps. For `sw`, base is needed in EX, stored data in MEM; check bypass paths.

  // Vault: 100 Source Notes/Lectures/CS2100 Lecture 21.md -> Forwarding for Data Hazards.png.
  #block(breakable: false)[
    = Forwarding paths across overlapping instructions
    #align(center, image("images/pipeline-forwarding.png", width: 100%))
    #text(size: 7.6pt)[`sub` produces `$2`; the following `and` and `or` receive it through bypass paths. An immediate load-use dependency still needs a stall before forwarding (see availability table).]
  ]

  = Control hazards: branch handling
  #strong[Early resolution:] move target calculation and comparison to #strong[ID] with a separate comparator. Basic branch wait: #strong[3 → 1 cycles]. This calculates the outcome earlier; it does not predict it.

  #table(
    columns: (1fr, auto, auto), stroke: 0.3pt + lightgray,
    table.header([*Branch policy: lost cycles per branch*], [*Resolve MEM*], [*Resolve ID*]),
    [Wait until branch resolves (no prediction)], [3], [1],
    [Predict not taken: correct (not taken)], [0], [0],
    [Predict not taken: wrong (taken), flush], [3], [1],
    [Delayed branch: all slots filled with useful work], [0 wasted], [0 wasted],
    [Delayed branch: all slots are `nop`], [3 wasted], [1 wasted],
  )
  Table assumes ready operands. #strong[ID branch + forwarding + wait:] 1 control + data stalls = *1* (ready), *2* (adjacent ALU), *3* (adjacent load). Correct prediction removes control loss, not data stalls. Count overlapping penalties once.

  #grid(
    columns: (3fr, 2fr), column-gutter: 4mm,
    [#strong[Delayed branch:] slots execute #emph[regardless of taken/not taken], before the jump. Lecture model: 1 slot (ID) or 3 (MEM). Fill with independent work safe on both paths; otherwise use `nop` (1 wasted cycle each). Useful slots are executed instructions, not extra stall cycles.],
    [#align(center, image("images/delayed-branch-code.png", width: 100%))],
  )

  #strong[Exam method:] draw IF–ID–EX–MEM–WB; mark availability/need and bypass paths. Cycles = $I + 4$ + extra lost cycles. Include useful delay-slot work in $I$. Count each `nop` either in $I$ or as wasted time, never both.

  // Source: Obsidian Vault/100 Source Notes/Lectures/CS2100 Lecture 22.md
  // and its cache index/tag, circuitry, and write-policy attachments.
  = Cache: locality and access time (Lecture 22)
  #strong[Temporal locality:] recently used data is likely reused soon. #strong[Spatial locality:] nearby addresses are likely used soon; fetch a whole #emph[block/line], not just one word. Larger blocks exploit spatial locality but take longer to refill and leave fewer lines for a fixed cache capacity.

  #table(
    columns: (auto, 1fr, auto, 1fr), stroke: 0.3pt + lightgray,
    [$h$], [Hit rate = hits / accesses], [$m$], [Miss rate = $1-h$],
    [$H$], [Hit time (cache lookup + access)], [$P$], [Extra delay on a miss],
    [$M$], [Total miss time: $H+P$], [*AMAT*], [$h H + m M = H + m P$],
  )
  #strong[Convention:] the lecture's “miss penalty” includes hit time, so use $h H + (1-h) M$. If a question gives #emph[additional] miss time, use $H+(1-h)P$. Keep units consistent.
  #strong[Example:] $h=0.95$, $H=1$ ns, $P=40$ ns ⇒ $M=41$ ns and AMAT $=1+0.05 times 40=3$ ns.

  = Direct-mapped cache: essential formulas
  #strong[Symbols:] $a$ = byte address; $A$ = address width in bits; $C$ = cache #emph[data capacity in bytes] (excludes metadata); $B$ = bytes/block; $L$ = cache lines; $q$ = memory block number. Assume $B,L$ are powers of 2.
  #table(
    columns: (auto, 1fr, auto, 1fr), stroke: 0.3pt + lightgray,
    [*Lines*], [$L=C/B$], [*Block number*], [$q=floor(a/B)$],
    [*Index*], [$i=q mod L$], [*Tag value*], [$floor(q/L)=floor(a/C)$],
    [*Byte offset*], [$o=a mod B$], [*Block start*], [$a_0=B floor(a/B)=a-o$],
    [*Offset bits*], [$b=log_2 B$], [*Index bits*], [$s=log_2 L$],
    [*Tag bits*], [$t=A-s-b$], [*Reconstruct*], [$a=("tag" dot L+i)B+o$],
  )

  #table(
    columns: (1fr, 1fr, 1fr), align: center, stroke: 0.4pt + navy,
    fill: (x, y) => (rgb("FFE0E3"), rgb("DCEEFF"), rgb("FFF2B2")).at(x),
    [*Tag: $t$ high bits*], [*Index: $s$ bits*], [*Offset: $b$ low bits*],
  )
  #strong[Word/byte split:] for $W$ bytes/word, byte-in-word bits = $log_2 W$; word-in-block bits = $log_2(B/W)$. For word-addressed inputs, convert to byte address ($a=W times "word address"$) or use block size in words consistently.

  #strong[Lecture example:] 32-bit byte addresses, 16 KiB data cache, 16-byte blocks (4 words): $L=2^14/2^4=1024$, $b=4$, $s=10$, $t=18$.
  #align(center, strong[Tag 31:14 | Index 13:4 | Word 3:2 | Byte 1:0])
  `0x1234` and `0x5234` both have index 291 and offset 4, but tags 0 and 1: alternating accesses replace each other (conflict misses).

  #strong[Physical storage:] data bits = $8C$; metadata = $L(t+1+d)$ bits; total = $L(8B+t+1+d)$ bits. One valid bit/line; $d=1$ for a dirty bit (write-back), otherwise 0. Index/offset are not stored as tag metadata.

  = Cache reads, misses, and writes
  #strong[Read hit:] select index; hit iff #box(stroke: navy, inset: 2pt)[$"valid"[i] and ("stored tag"[i] = "address tag")$]; return selected offset. Initially all valid bits are 0. #strong[Read miss:] write back a dirty victim if needed, fetch the aligned block, update tag + valid, then return requested data.

  #table(
    columns: (auto, 1fr), stroke: 0.3pt + lightgray,
    [*Compulsory (cold)*], [First reference to a memory block],
    [*Conflict*], [Different blocks compete for the same line/set although cache has enough total capacity],
    [*Capacity*], [Working set exceeds total cache capacity; blocks must be evicted even without mapping restrictions],
  )
  #strong[Tracing accesses:] compute block/index/tag → test valid + tag → record hit/miss → update that line on allocation. A miss fetches #emph[all $B$ bytes]; later accesses to other words in that block may hit. Same index does not imply same block; an invalid line is always a miss.

  #block(breakable: false)[
  #grid(
    columns: (3fr, 2fr), column-gutter: 4mm,
    [#strong[Write policies]
     - *Write-through:* cache + memory; buffer hides latency until full.
     - *Write-back:* cache only, dirty=1; evict dirty blocks to memory, discard clean ones.
     - *Write allocate:* fetch missed block, then update requested bytes + tag/valid.
     - *Write-around:* memory only; no cache fill.
     Hit policy: *when* memory changes. Miss policy: *whether* cache fills. Dirty eviction = block write + refill.
    ],
    [#strong[16 KiB / 16-byte lines]
     #align(center, image("images/direct-mapped-cache-circuit-crop.png", width: 90%))
    ],
  )
  ]

  // Vault: Cache Write Policy.md -> Write-Through Cache.png (circuit only).
  #block(breakable: false)[
    #align(center, image("images/cache-write-buffer.png", width: 70%))
    #text(size: 7.6pt)[Write-through with a write buffer: the processor updates cache and queues the memory write; the buffer drains to DRAM. A full buffer can stall later writes.]
  ]

  = Cache associativity
  #strong[Set] = group of cache lines; #strong[way] = one possible line within the selected set.
  #table(
    columns: (auto, auto, auto, 1fr), stroke: 0.3pt + lightgray,
    table.header([*Mapping*], [*Ways/set*], [*Sets*], [*Where can a block go?*]),
    [Direct-mapped], [1], [$L$], [One fixed line; compare 1 tag],
    [$k$-way set associative], [$k$], [$L/k$], [Any way in one fixed set; compare $k$ tags],
    [Fully associative (FA)], [$L$], [1], [Any line; compare all $L$ tags],
  )
  #block(breakable: false)[
    #align(center, image("images/set-associative-structure-crop.png", width: 65%))
    #strong[2-way example:] a horizontal set contains 2 lines. Both valid/tag pairs are checked in parallel; the matching way supplies data.
  ]

  #v(1mm)

  #strong[Symbol key] (byte-addressed memory; power-of-2 block/set counts; $k$ divides $L$):
  #table(
    columns: (auto, 1fr, auto, 1fr), stroke: 0.3pt + lightgray,
    [$a$], [Byte address], [$A$], [Address width (bits)],
    [$C$], [Cache data capacity (bytes)], [$B$], [Block size (bytes)],
    [$L$], [Total cache lines], [$k$], [Ways per set],
    [$U$], [Number of sets], [$q$], [Memory block number],
    [$i$], [Set index value], [$o$], [Byte offset within block],
    [$b$], [Offset width (bits)], [$s$], [Set-index width (bits)],
    [$t$], [Tag width (bits)], [tag], [Tag value from the address],
  )
  #table(
    columns: (auto, 1fr, auto, 1fr), stroke: 0.3pt + lightgray,
    [*Lines / sets*], [$L=C/B$; $U=L/k$], [*Block / offset*], [$q=floor(a/B)$; $o=a mod B$],
    [*Set index*], [$i=q mod U$], [*Tag value*], [$"tag"=floor(q/U)$],
    [*Offset bits*], [$b=log_2 B$], [*Set-index bits*], [$s=log_2 U$],
    [*Tag bits*], [$t=A-s-b$], [*Reconstruct*], [$a=("tag" dot U+i)B+o$],
  )
  #table(
    columns: (auto, 1fr), stroke: 0.3pt + lightgray,
    [*Index/tag calculation*], [Use number of *sets*, not total lines],
    [*Fully associative*], [$U=1$, $s=0$, tag=$q$, $t=A-b$],
    [*Way number*], [Chosen inside the set; *not an address field*],
  )

  #strong[Same capacity, different associativity:] $A=32$, $C=16$ KiB, $B=16$ bytes, $L=1024$.
  #table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr), align: center, stroke: 0.3pt + lightgray,
    table.header([*Cache*], [*Sets $U$*], [*Index $s$*], [*Tag $t$*], [*Offset $b$*]),
    [Direct], [1024], [10], [18], [4],
    [2-way], [512], [9], [19], [4],
    [4-way], [256], [8], [20], [4],
    [FA], [1], [0], [28], [4],
  )
  #table(
    columns: (auto, 1fr), stroke: 0.3pt + lightgray,
    [*More ways, fixed $C,B$*], [Fewer sets/index bits; more tag bits/comparisons; fewer placement conflicts but higher hardware/selection cost],
    [*FA misses*], [No conflict misses; compulsory/capacity misses remain. Usually used for small caches.],
    [*Lecture rule of thumb*], [Direct capacity $C$ ≈ 2-way capacity $C/2$ in miss rate; empirical, not guaranteed for every trace],
  )

  #strong[Total storage (bits):] $L(8B+t+1+d)+R$.
  #table(
    columns: (auto, 1fr, auto, 1fr), stroke: 0.3pt + lightgray,
    [$8B$], [Data bits per line], [$t+1$], [Tag + one valid bit per line],
    [$d$], [Dirty bits/line: 1 for WB, else 0], [$R$], [Total replacement metadata bits],
    [*2-way LRU*], [$R=U$: 1 LRU bit per set], [*Other policies*], [$R$ depends on implementation],
  )
  #block(breakable: false)[
    #strong[FA lookup circuit:] 4 KiB / 16-byte blocks = 256 lines; 32-bit address = 28-bit tag + 4-bit offset. Compare all 256 valid/tag pairs in parallel.
    #align(center, image("images/fully-associative-circuit-crop.png", width: 80%))
  ]

  = Replacement: which line is evicted?
  #table(
    columns: (auto, 1fr), stroke: 0.3pt + lightgray,
    table.header([*Situation*], [*Action*]),
    [Hit: valid + matching tag], [Use matching way; update policy state],
    [Miss; invalid way available], [Fill invalid way first; no valid victim needed],
    [Miss; selected set full], [Choose victim *inside that set* (FA: any line)],
    [Valid dirty WB victim], [Write block to memory before replacing it],
    [Direct-mapped miss], [One possible line; no replacement-policy choice],
  )
  #table(
    columns: (auto, 1fr, 1fr), stroke: 0.3pt + lightgray,
    table.header([*Policy*], [*Victim*], [*What changes on a hit?*]),
    [*LRU*], [Least recently used], [Move hit line to most-recent position],
    [*FIFO*], [Earliest inserted], [Nothing: insertion order stays the same],
    [*Random (RR)*], [Random eligible line], [No access-history ranking],
    [*LFU*], [Least frequently accessed], [Increment count; follow given tie/aging rule],
  )
  LRU exploits temporal locality but tracking becomes expensive with many ways. Fills also update policy state.

  #strong[Worked trace:] empty 2-way set; A, B, C map to the #emph[same set]. Orders below run #emph[victim first → newest last] (recency for LRU; insertion for FIFO).
  #table(
    columns: (auto, auto, 1fr, 1fr, 1fr), stroke: 0.3pt + lightgray,
    table.header([*Access*], [*H/M*], [*LRU order*], [*FIFO order*], [*Eviction*]),
    [A], [Miss], [A], [A], [None],
    [B], [Miss], [A → B], [A → B], [None],
    [#highlight(fill: yellow)[A]], [Hit], [B → A], [A → B], [None],
    [C], [Miss], [A → C], [B → C], [LRU: *B*; FIFO: *A*],
  )
  #strong[Result:] both have 1 hit + 3 misses (hit rate $1/4$), but different victims. Recency ≠ insertion age ≠ frequency. AMAT and write policies from Lecture 22 still apply.
]
