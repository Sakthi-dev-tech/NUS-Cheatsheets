// Faithful content conversion of main.tex; compile with: typst compile main.typ typ.pdf
#set document(title: "CS2040S Cheatsheet")
#set page(paper: "a4", flipped: true, margin: 10mm, numbering: "1", number-align: center)
#set text(font: "New Computer Modern", size: 6pt, top-edge: "ascender", bottom-edge: "descender")
#set par(leading: 1.2pt, spacing: 0.9pt, first-line-indent: 0pt, justify: true)
#set columns(gutter: 10mm)
#set list(indent: 0pt, body-indent: 1em, spacing: 0pt, tight: true)
#set enum(indent: 0pt, body-indent: 1.3em, spacing: 0pt, tight: true)
#set heading(numbering: none)
#show heading: it => block(above: 3pt, below: 1pt, sticky: true)[#text(size: 7.199999999999999pt, weight: "bold", fill: rgb("0000FF"), it.body)]
#show heading.where(level: 2): it => block(above: 3pt, below: 1pt, sticky: true)[#text(size: 6pt, weight: "bold", it.body)]
#show heading.where(level: 3): it => block(above: 0pt, below: 0pt, sticky: true)[#text(size: 5.4pt, style: "italic", it.body)]
#show raw: set text(font: "Nimbus Mono PS", size: 4.8pt)
#show raw.where(block: true): set block(above: 2pt, below: 2pt)
#show math.equation.where(block: true): set block(above: 2pt, below: 2pt)
#set table(inset: (x: 1.5pt, y: 1pt), stroke: 0.3pt)
#show figure: set block(above: 2pt, below: 2pt)
#show math.equation: set text(fill: cmyk(100%, 72%, 0%, 38%))
#set text(tracking: 0.08pt)
#set par(leading: 1.4pt, spacing: 0.8pt)

#block(width: 100%, above: 0pt, below: 7pt)[#set par(justify: false)
#align(center)[#text(size: 17pt, weight: "bold", fill: rgb("000000"))[CS2040S Cheatsheet]]]

#columns(4)[
#heading(level: 1, numbering: none)[Order of Growth]
<order-of-growth>
#heading(level: 2, numbering: none)[Properties]
<properties>
Let $T \( n \) = O \( f \( n \) \)$ and $S \( n \) = O \( g \( n \) \)$

- #strong[Addition:] $T \( n \) + S \( n \) = O \( f \( n \) + g \( n \) \)$

- #strong[Multiplication:] $T \( n \) dot.op S \( n \) = O \( f \( n \) dot.op g \( n \) \)$

- #strong[Composition:] $T \( n \) compose S \( n \) = O \( f \( n \) compose g \( n \) \)$

  - #emph[Only if both functions are increasing]

- #strong[Max:] $max \( f \( n \) \, g \( n \) \) lt.eq f \( n \) + g \( n \)$

#heading(level: 2, numbering: none)[Space Complexity]
<space-complexity>
- Take the #strong[max space] taken at any point of time

- For example:

  ```java
  int logN = Math.log(n);
      
      for (int i = 0; i < n; i++) {
          int[] newArray = new int[logN] 
      }
  ```

  - Takes up $O \( log \( n \) \)$ space instead of $O \( n dot.op log \( n \) \)$

#heading(level: 1, numbering: none)[Sorting Algorithms]
<sorting-algorithms>
#heading(level: 2, numbering: none)[Insertion Sort]
<insertion-sort>
```
void insertionArray(int arr[], int n) {
    For each element from the first to last element
    Keep trying to shift that element if it's smaller
    than the element to the left
}
```

- #strong[Invariant:] At the start of the $i^(t h)$ iteration, the sub-array $a r r \[ 0 \, \( i - 1 \) \]$ is in sorted order

- #strong[Time Complexity:] $O \( n^2 \)$

- #strong[Space Complexity:] $O \( 1 \)$

#heading(level: 2, numbering: none)[Selection Sort]
<selection-sort>
```
void insertionSort(int arr[], int n){
    For each position i from 0 to n - 1
        Find minimum element in sub-array arr[i..(n-1)].
        Set the element at position i in arr to the minimum
        element found.
}
```

- At the beginning of the $i^(t h)$ iteration, the sub-array $a r r \[ 0 dots.h \( i - 1 \) \]$ is the same as the sub-array $s o r t e d \[ 0 dots.h \( i - 1 \) \]$

- #strong[Time Complexity:] $O \( n^2 \)$

- #strong[Space Complexity:] $O \( 1 \)$

#heading(level: 2, numbering: none)[Merge Sort]
<merge-sort>
```
void mergeSort(int arr[], int left, int right){
    if left + 1 == right:
        return;
    mid = (right - left) / 2;
    mergeSort(arr, left, mid);
    mergeSort(arr, mid, right);
    output = new int[right - left] 
    merge(arr, left, right, output);
    copy from output to arr[left, right)
}
```

- At the beginning of the $i^(t h)$ iteration, the sub-array $a r r \[ 0 dots.h \( i - 1 \) \]$ is the same as the sub-array $s o r t e d \[ 0 dots.h \( i - 1 \) \]$

- #strong[Time Complexity:] $O \( n dot.op log \( n \) \)$

- #strong[Space Complexity:] $O \( n \)$

#heading(level: 2, numbering: none)[Quick Sort]
<quick-sort>
```
void quickSort(int arr[], int left, int right){
    if left + 1 == right:
        return; // empty array do nothing
        
    // partition array based on the first element of array
    pivot_idx = partition(arr, left);

    Quicksort(arr, left, pivot_idx);
    Quicksort(arr, pivot_idx + 1, right);
}
```

- At the beginning of each iteration, the elements to the left of a certain index $i$ are all less than or equal to the pivot ($a r r \[ i \]$) and vice versa

- #strong[Time Complexity:] Depends on choice of pivot

  - Worst case: $O \( n^2 \)$ first/last pivot

  - Worst case: $O \( n dot.op log \( n \) \)$ median element

  - Worst case: $oo$ random element

- #strong[Space Complexity:] $O \( n \)$

#heading(level: 1, numbering: none)[Binary Search Trees]
<binary-search-trees>
#heading(level: 2, numbering: none)[General]
<general>
- a BST is either empty, or a node pointing to 2 BSTs

- Balanced tree: $h = log_2 n$

- For a full binary tree of size $n$, $exists k in bb(Z)^(+)$ s.t. $n = 2^k - 1$

#heading(level: 2, numbering: none)[Runtime for Operations]
<runtime-for-operations>
- #emph[Lookup:] $O \( n \)$ when every node has a single child

  - If not, can be $O \( h \)$, where $h$ is the height

- #emph[Insert:] $O \( h \)$

- #emph[Delete:] $O \( h \)$

  - Case 1: No children - remove the node

  - Case 2: 1 child - remove the node, connect parent to child

  - Case 3: 2 children - delete the successor; replace node with successor

#heading(level: 1, numbering: none)[AVL Trees]
<avl-trees>
#heading(level: 2, numbering: none)[General]
<general-1>
- Invariant: #strong[Height balanced] (maintained with rotations)

  - $arrow.l.r.double \| v . l e f t . h e i g h t - v . r i g h t . h e i g h t \| lt.eq 1$

#heading(level: 2, numbering: none)[Rotations]
<rotations>
#grid(columns: (1fr, 1fr), gutter: 2%,
  [*Right (RR)* #image("images/right_rotate.png", width: 100%)],
  [*Left (LL)* #image("images/left_rotate.png", width: 100%)],
)

#heading(level: 2, numbering: none)[Terminology]
<terminology>
- #strong[Left/Right Heavy:] Height of left/right child node is taller than height of right/left child node

  - Perform a right/left-rotation

#heading(level: 1, numbering: none)[AVL Rebalancing Cases]
<avl-rebalancing-cases>
#emph[Check balance factor: $b f = upright("height") \( L \) - upright("height") \( R \)$. Rebalance if $\| b f \| > 1$]

#heading(level: 2, numbering: none)[1. Left-Left (LL) Heavy]
<left-left-ll-heavy>
- #strong[Condition:] $y$ is left-heavy, and $y . l e f t$ is left-heavy

- #strong[Fix:] Single #strong[Right Rotation] on $y$

#heading(level: 2, numbering: none)[2. Right-Right (RR) Heavy]
<right-right-rr-heavy>
- #strong[Condition:] $y$ is right-heavy, and $y . r i g h t$ is right-heavy

- #strong[Fix:] Single #strong[Left Rotation] on $y$

#block[
#box(image("images/rr_heavy.png", width: 80%))

]
#heading(level: 2, numbering: none)[3. Left-Right (LR) Heavy]
<left-right-lr-heavy>
- #strong[Condition:] $y$ is left-heavy, but $y . l e f t$ is right-heavy

- #strong[Fix:] #strong[Double Rotation] : Left-rotate $y . l e f t$, then Right-rotate $y$

#heading(level: 2, numbering: none)[4. Right-Left (RL) Heavy]
<right-left-rl-heavy>
- #strong[Condition:] $y$ is right-heavy, but $y . r i g h t$ is left-heavy

- #strong[Fix:] #strong[Double Rotation] : Right-rotate $y . r i g h t$, then Left-rotate $y$

#block[
#box(image("images/rl_heavy.png", width: 80%))

]
#heading(level: 1, numbering: none)[Tree Augmentation Summary]
<tree-augmentation-summary>
- #strong[Size Augment:] Store subtree size to support $R a n k \( k \)$ and $S e l e c t \( i \)$ in $O \( h \)$

- #strong[Rank:] Number of elements smaller than $k$

- #strong[Select:] Find key with a given rank

- #strong[Maintenance:] Update $h e i g h t$ and $s i z e$ as recursion unwinds

#heading(level: 1, numbering: none)[AVL Deletion]
<avl-deletion>
#heading(level: 2, numbering: none)[1. BST Deletion Phase]
<bst-deletion-phase>
- #strong[Leaf:] Just remove the node

- #strong[1 Child:] Remove node and connect parent to the child

- #strong[2 Children:] Find successor $n$ (min of right subtree), swap key with $n$, and delete $n$ (which now has $lt.eq 1$ child)

#heading(level: 2, numbering: none)[2. Rebalancing Phase]
<rebalancing-phase>
#emph[As recursion unwinds, update heights and check $b f = h_L - h_R$. If $\| b f \| > 1$, rebalance at the first unbalanced node $y$]

#strong[Case: Deleted from Right Subtree ($b f = 2$)]

- #strong[LL Heavy:] If $h \( y . L . L \) gt.eq h \( y . L . R \)$, perform #strong[Right Rotation] on $y$

- #strong[LR Heavy:] If $h \( y . L . L \) < h \( y . L . R \)$, perform #strong[Left-Rotate] $y . L$, then #strong[Right-Rotate] $y$

#strong[Case: Deleted from Left Subtree ($b f = - 2$)]

- #strong[RR Heavy:] If $h \( y . R . R \) gt.eq h \( y . R . L \)$, perform #strong[Left Rotation] on $y$

- #strong[RL Heavy:] If $h \( y . R . R \) < h \( y . R . L \)$, perform #strong[Right-Rotate] $y . R$, then #strong[Left-Rotate] $y$

#heading(level: 2, numbering: none)[Key Difference from Insertion]
<key-difference-from-insertion>
- #strong[Propagation:] While insertion requires at most one rebalance, #strong[deletion can trigger rebalancing at multiple levels] up to the root.

- #strong[Complexity:] $O \( log n \)$ for all cases

#heading(level: 1, numbering: none)[Hash Tables]
<hash-tables>
- Insert, delete, and lookup should run in expected $O \( 1 \)$ time, and size in worst-case $O \( 1 \)$ time.

#heading(level: 2, numbering: none)[Hash Function]
<hash-function>
- #strong[Load Factor ($alpha$):] $n \/ m$, representing the expected length of a chain.

- #strong[Criteria for a Good Hash Function:] Must evaluate deterministically, look random for new inputs, and execute efficiently.

- #strong[Simple Uniform Hashing Assumption (SUHA):] Assumes each new key picks any table index uniformly at random, ensuring keys are distributed evenly. If $n \/ m = O \( 1 \)$, expected runtime of operations is $O \( 1 \)$.

- #strong[Division Method:] $h \( k \) = k med mod med m$ (choose prime $m$, avoid $m = 2^x$)

- #strong[Multiplication Method:] $h \( k \) = \( A k \) med mod med 2^w gt.double \( w - r \)$

#heading(level: 2, numbering: none)[Collision Resolution]
<collision-resolution>
- #strong[Separate Chaining]

  - Each slot in the table acts as a head for a linked list.

  - #strong[Worst-Case Runtime:] $O \( n \)$ for insert, lookup, and delete if all items collide into a single list.

  - #strong[Expected Runtime (SUHA):] $O \( n \/ m \)$ for insert, lookup, and delete.

- #strong[Open Addressing (Linear Probing)]

  - Stores key-value pairs directly within the table array itself.

  - #strong[Mechanism:] If an index is occupied, sequentially try the next slot until an empty one is found.

  - #strong[Worst-Case Runtime:] $O \( n \)$ for insert, lookup, and delete.

  - #strong[Expected Runtime (SUHA):] $O \( 1 \)$ for insert, lookup, and delete.

  - #strong[Deletion Constraints:] Simply removing an item breaks the search "run" for subsequent keys.

  - #strong[Deletion Fix (Shifting):] When removing at index $i$, check subsequent items $e$. If $i$ is within $e$'s target interval, move $e$ to index $i$.

  - #strong[Interval Cases:]

    - Case 1 (No wrap): If $h \( e \) lt.eq upright("index")$, the interval is $\[ h \( e \) \, upright("index") \]$.

    - Case 2 (Wraparound): If $h \( e \) > upright("index")$, the interval is $\[ h \( e \) \, m - 1 \]$ and $\[ 0 \, upright("index") \]$.

- #strong[Double Hashing]

  - $\( h \( k \, i \) = f \( k \) + i dot.op g \( k \) \) med mod med m$

    - $k$: The key that is being inserted or searched for

    - $i$: The probe attempt number (starts at $0$, then $1 \, 2 \, 3 \, dots.h$)

    - $f \( k \)$: The primary hash function to give your starting idx

    - $g \( k \)$: The secondary hash function to give step size

    - $m$: Total size of hash table

#heading(level: 1, numbering: none)[Advanced Trees]
<advanced-trees>
#heading(level: 2, numbering: none)[(a, b)-trees & B-Trees]
<a-b-trees-b-trees>
- #strong[B-Tree:] A $\( B \, 2 B \)$-tree is an $\( a \, b \)$-tree where $a = B$ and $b = 2 B$

- #strong[Rules:] \

  #figure(
    align(center)[#table(
      columns: 5,
      align: (center,center,center,center,center,),
      table.header([], table.cell(align: center, colspan: 2)[\# keys], table.cell(align: center, colspan: 2)[\# children],),
      table.hline(),
      [node type], [min], [max], [min], [max],
      [root], [$1$], [$b - 1$], [$2$], [$b$],
      [internal], [$a - 1$], [$b - 1$], [$a$], [$b$],
      [leaf], [$a - 1$], [$b - 1$], [$0$], [$0$],
    )]
    , kind: table
    )

  - $\( a \, b \)$-child policy: $2 lt.eq a lt.eq \( b + 1 \) \/ 2$

  - Internal node has 1 more child than its number of keys

  - All leaf nodes must be at the #strong[same depth] from the root

- #strong[Heights:] Max $O \( log_a n \) + 1$, Min $O \( log_b n \)$

- #strong[Operations:] #emph[Search, Insert, Delete] are all $O \( log n \)$

  - #strong[Split:] When a node has too many children (move median key to parent)

  - #strong[Merge/Share:] When a node becomes empty during deletion

#heading(level: 2, numbering: none)[Trie]
<trie>
- #strong[Search, Insert:] $O \( L \)$ for a string of length $L$

- #strong[Space:] $O \( upright("size of text") dot.op upright("overhead") \)$

#heading(level: 2, numbering: none)[kd-Tree]
<kd-tree>
- Stores geometric data (points in an $\( x \, y \)$ plane)

- Alternates splitting (partitioning) via $x$ and $y$ coordinates

- #strong[Construct:] $O \( n log n \)$

- #strong[Search:] $O \( h \)$

- #strong[SearchMin:] $T \( n \) = 2 T \( n \/ 4 \) + O \( 1 \) arrow.r.double.long O \( sqrt(n) \)$

#heading(level: 2, numbering: none)[Merkle Trees]
<merkle-trees>
- Binary tree - nodes augmented with a hash of their children

- Same root value $arrow.r.double.long$ identical tree

#block[
#strong[Merkle Tree] \
#box(image("images/merkle.png", width: 51.2%))

]
#heading(level: 1, numbering: none)[Binary Heaps]
<binary-heaps>
#heading(level: 2, numbering: none)[General]
<general-2>
- Visualised in the form of a complete binary tree

  - Every node has either $0$, $1$, or $2$ children

  - Every level #strong[must be full] except the last level

  - Last Level must be filled from left to right

- Priorities of children are $gt.eq$ priority of parents (min heap)

- Use array to represent the tree

  #block[
  #box(image("images/binary_heap_array.png", width: 80%))

  ]

- Make sure array is 1-indexed

- Tree traversal in array

  - Go to left child: $i d x times 2$

  - Go to right child: $i d x times 2 + 1$

  - Go to parent: $floor.l i d x div 2 floor.r$

- To store values, we use 2 more arrays

  - id\_to\_pos

  - pos\_to\_id

    #block[
    #box(image("images/binary_heap_triple_array.png", width: 80%))

    ]

  - For swaps

    + Swap in main array and store idx

    + Find id from pos\_to\_id array

    + Swap in the pos\_to\_id array

    + Use the id from step 2 to make the swap in id\_to\_pos array

#heading(level: 2, numbering: none)[Insertion]
<insertion>
#block[
#box(image("images/binary_heap_insertion.png", width: 80%))

]
+ Insert at the end of the heap

+ Keep swapping with parent node if parent node's priority is greater than current node

#heading(level: 2, numbering: none)[Deletion]
<deletion>
+ Swap the node you want to delete with the last node

+ Delete the last node (the node you want to delete)

+ Compare the newly swapped node with its new parent

  - If it violates heap property, bubble up

  - Otherwise, bubble down

#heading(level: 2, numbering: none)[Extract Min]
<extract-min>
+ Swap root node with last node

+ Remove the last node and return

+ Bubble the root node down if it violates binary heap invariant with the smaller priority child

#heading(level: 2, numbering: none)[Heapify (Bubble Down / Sift Down)]
<heapify-bubble-down-sift-down>
+ Shift all elements by 1 to make it 1-indexed

+ Compare the current node's priority with its children for idx from $\( s i z e div 2 \)$ to $1$

+ If it violates the binary heap invariant, swap it with the highest-priority child (e.g., the smaller child in a Min-Heap)

+ Repeat this process on the node's new position until the invariant is restored or it becomes a leaf node

#heading(level: 1, numbering: none)[Graphs]
<graphs>
#heading(level: 2, numbering: none)[Adjacency Matrix]
<adjacency-matrix>
#block[
#box(image("images/adjacency_matrix.png", width: 38.4%))

]
- arr\[i\]\[j\] gives the weight (1 if unweighted) of the edge from $i$ to $j$ (or 0 if no edge)

#heading(level: 2, numbering: none)[Adjacency List]
<adjacency-list>
#block[
#box(image("images/adjacency_list.png", width: 38.4%))

]
#heading(level: 2, numbering: none)[Edge List]
<edge-list>
#block[
#box(image("images/edge_list.png", width: 38.4%))

]
- If edges are weighted, store as triplets $\( u \, v \, w e i g h t \)$

#block[
#figure(
  align(center)[#table(
    columns: 4,
    align: (center,center,center,center,),
    table.header([], [#strong[AM] ], [#strong[AL] ], [#strong[EL] ],),
    table.hline(),
    [#strong[is\_adj] ], [$O \( 1 \)$], [$O \( deg i \)$], [$O \( m \)$],
    [#strong[get\_neigh] ], [$O \( n \)$], [$O \( 1 \)$], [$O \( m \)$],
    [#strong[in\_deg] ], [$O \( n \)$], [$O \( n + m \)$], [$O \( m \)$],
    [#strong[out\_deg] ], [$O \( n \)$], [$O \( 1 \)$], [$O \( m \)$],
    [#strong[space] ], [$O \( n^2 \)$], [$O \( n + m \)$], [$O \( m \)$],
  )]
  , kind: table
  )

]
#heading(level: 2, numbering: none)[Searching]
<searching>
#heading(level: 3, numbering: none)[Breadth-First Search (BFS)]
<breadth-first-search-bfs>
- Uses a queue to explore the graph level by level

- Time Complexity: $O \( n + m \)$

- Space Complexity: $O \( n \)$

#heading(level: 3, numbering: none)[Depth-First Search (DFS)]
<depth-first-search-dfs>
- Uses a stack to explore the graph as far as possible along each branch before backtracking

- Time Complexity: $O \( n + m \)$

- Space Complexity: $O \( n \)$

#heading(level: 2, numbering: none)[Topological Sort]
<topological-sort>
- Linear ordering of vertices such that for every directed edge $u v$, vertex $u$ comes before $v$ in the ordering

- Can be performed using DFS

- Use linked list to store the topological order (add vertex to front of list after visiting all its neighbors)

- Time Complexity: $O \( n + m \)$

- Space Complexity: $O \( n \)$

#heading(level: 2, numbering: none)[SSSP - Relaxation of Nodes]
<sssp---relaxation-of-nodes>
- Set the source node's distance to $0$, and all other nodes' distances to $oo$.

- For each directed edge $u arrow.r v$, if $d i s t \[ u \] + w e i g h t \( u \, v \) < d i s t \[ v \]$, update $d i s t \[ v \]$ to $d i s t \[ u \] + w e i g h t \( u \, v \)$.

- #strong[Execution Strategy:]

  - #strong[Bellman-Ford:] Repeat this relaxation for all edges until no updates can be made (maximum $n - 1$ iterations).

  - #strong[Dijkstra & DAG:] Process nodes systematically (greedy or topological order) so edges only need to be relaxed once per visited node.

- #strong[Runtimes] (where $n = \| V \|$ and $m = \| E \|$):

  - #strong[Bellman-Ford:] $O \( n m \)$

  - #strong[DAG Shortest Path:] $O \( n + m \)$

  - #strong[Dijkstra's Algorithm:] $O \( m log m \)$ using lazy deletion, or $O \( \( n + m \) log n \)$ using a standard binary min-heap.

#block[
#box(image("images/djikstra_lazy.png", width: 67.2%))

]
#heading(level: 2, numbering: none)[Union-Find Disjoint Sets (UFDS)]
<union-find-disjoint-sets-ufds>
Maintains a collection of disjoint sets, allowing for highly efficient union and connectivity checks.

#strong[Core Arrays:]

- `parent_array[x]`: Initially, every element is its own root (`parent_array[x] = x`).

- `rank[x]`: Initially, every element's rank is 0.

#block[
#box(image("images/union_by_rank.png", width: 67.2%))

]
#heading(level: 3, numbering: none)[Time Complexity]
<time-complexity>
- #strong[Worst-Case Runtime:] $O \( log n \)$ per operation.

- #strong[Amortized Runtime:] $O \( alpha \( n \) \)$ per operation, where $alpha \( n \)$ is the Inverse Ackermann function.

- #strong[Practical Implication:] $alpha \( n \) lt.eq 4$ for any realistically imaginable input size ($A \( 4 \, 4 \) = 2^(2^65536) - 3$), meaning operations are effectively $O \( 1 \)$. A sequence of $m$ operations takes practically $O \( m \)$ time.

#heading(level: 2, numbering: none)[Minimum Spanning Trees (MST)]
<minimum-spanning-trees-mst>
- #strong[Assumption:] Edge weights are bounded non-negative integers $w in \[ 0 \, c \)$ for a constant $c$.

#heading(level: 3, numbering: none)[Faster Kruskal's Algorithm]
<faster-kruskals-algorithm>
- #strong[Idea:] Replace the $O \( m log m \)$ comparison-based sort with #strong[Counting Sort] .

- #strong[Time Complexity:] $O \( c + m alpha \( n \) \)$, where $alpha$ is the inverse Ackermann function.

#heading(level: 3, numbering: none)[Faster Prim's Algorithm]
<faster-prims-algorithm>
- #strong[Idea:] Replace the $O \( log n \)$ Priority Queue with an array of $c$ queues. To find the minimum edge, scan the array from index $0$ to $c - 1$ to find the first non-empty queue.

- #strong[Time Complexity:] $O \( c \( n + m \) \)$

#strong[Pseudocode:]

```
            in_tree = array of size n, initialized to false
            fake_pq = array of c empty queues

            in_tree[s] = true
            for (n, weight) in get_neighbours(s): 
                fake_pq[weight].push(n)

            while fake_pq has a non-empty queue:
                curr_node = pop from the first non-empty queue in fake_pq
                if in_tree[curr_node]: 
                    continue
                    
                in_tree[curr_node] = true
                for (n, weight) in get_neighbours(curr_node): 
                    fake_pq[weight].push(n)
```

#heading(level: 1, numbering: none)[Appendix]
<appendix>
#block[
#figure(
  align(center)[#table(
    columns: 6,
    align: (center,center,center,center,center,center,),
    [$bold("sort")$], [$bold("best")$], [$bold("average")$], [$bold("worst")$], [$bold("stable?")$], [$bold("memory")$],
    [$upright("bubble")$], [$Omega \( n \)$], [$O \( n^2 \)$], [$O \( n^2 \)$], [$checkmark$], [$O \( 1 \)$],
    [$upright("selection")$], [$Omega \( n^2 \)$], [$O \( n^2 \)$], [$O \( n^2 \)$], [$times$], [$O \( 1 \)$],
    [$upright("insertion")$], [$Omega \( n \)$], [$O \( n^2 \)$], [$O \( n^2 \)$], [$checkmark$], [$O \( 1 \)$],
    [$upright("merge")$], [$Omega \( n log n \)$], [$O \( n log n \)$], [$O \( n log n \)$], [$checkmark$], [$O \( n \)$],
    [$upright("quick")$], [$Omega \( n log n \)$], [$O \( n log n \)$], [$O \( n^2 \)$], [$times$], [$O \( 1 \)$],
    [$upright("heap")$], [$Omega \( n log n \)$], [$O \( n log n \)$], [$O \( n log n \)$], [$times$], [$O \( 1 \)$],
  )]
  , kind: table
  )

\

#figure(
  align(center)[#table(
    columns: 2,
    align: (center,center,),
    table.header(table.cell(align: center, colspan: 2)[sorting invariants],),
    table.hline(),
    [#strong[sort] ], [#strong[invariant] (after $k$ iterations)],
    [bubble], [largest $k$ elements are sorted],
    [selection], [smallest $k$ elements are sorted],
    [insertion], [first $k$ slots are sorted],
    [merge], [given subarray is sorted],
    [quick], [partition is in the right position],
  )]
  , kind: table
  )

#figure(
  align(center)[#table(
    columns: 2,
    align: (center,center,),
    table.header(table.cell(align: center, colspan: 2)[searching],),
    table.hline(),
    [#strong[search] ], [#strong[average] ],
    [linear], [$O \( n \)$],
    [binary], [$O \( log n \)$],
    [quickSelect], [$O \( n \)$],
    [interval], [$O \( log n \)$],
    [all-overlaps], [$O \( k log n \)$],
    [1D range], [$O \( k + log n \)$],
    [2D range], [$O \( k + log^2 n \)$],
  )]
  , kind: table
  )

data structures assuming $O \( 1 \)$ comparison cost \


#figure(
  align(center)[#table(
    columns: 3,
    align: (center,center,center,),
    table.header([#strong[data structure] ], [#strong[search] ], [#strong[insert] ],),
    table.hline(),
    [sorted array], [$O \( log n \)$], [$O \( n \)$],
    [unsorted array], [$O \( n \)$], [$O \( 1 \)$],
    [linked list], [$O \( n \)$], [$O \( 1 \)$],
    [tree], [$O \( log n \)$ or $O \( h \)$], [$O \( log n \)$ or $O \( h \)$],
    [trie], [$O \( L \)$], [$O \( L \)$],
    [heap], [$O \( log n \)$ or $O \( h \)$], [$O \( log n \)$ or $O \( h \)$],
    [dictionary], [$O \( log n \)$], [$O \( log n \)$],
    [symbol table], [$O \( 1 \)$], [$O \( 1 \)$],
    [chaining], [$O \( n \)$], [$O \( 1 \)$],
    [open addressing], table.cell(align: center)[$frac(1, 1 - alpha) = O \( 1 \)$], [$O \( 1 \)$],
    [priority queue], [(contains) $O \( 1 \)$], [$O \( log n \)$],
    [skip list], [$O \( log n \)$], [$O \( log n \)$],
  )]
  , kind: table
  )

Orders of Growth \
 $1 < log n < sqrt(n) < n < n log n < n^2 < n^3 < 2^n < 2^(2 n)$ \
 $log_a n < n^a < a^n < n ! < n^n$

]
]
#pagebreak()
#columns(4)[
Orders of Growth $ T \( n \) & = 2 T (n / 2) + O \( n \) & arrow.r.double.long O \( n log n \)\
T \( n \) & = T (n / 2) + O \( n \) & arrow.r.double.long O \( n \)\
T \( n \) & = 2 T (n / 2) + O \( 1 \) & arrow.r.double.long O \( n \)\
T \( n \) & = T (n / 2) + O \( 1 \) & arrow.r.double.long O \( log n \)\
T \( n \) & = 2 T \( n - 1 \) + O \( 1 \) & arrow.r.double.long O \( 2^n \)\
T \( n \) & = 2 T (n / 2) + O \( n log n \) & arrow.r.double.long O \( n \( log n \)^2 \)\
T \( n \) & = 2 T (n / 4) + O \( 1 \) & arrow.r.double.long O \( sqrt(n) \)\
T \( n \) & = T \( n - c \) + O \( n \) & arrow.r.double.long O \( n^2 \) $


]
