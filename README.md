A benchmark for implementations of the function:
``` haskell
sumAndLength :: Num a => [a] -> ([a], a)
```
```haskell
>>> sumAndLength [1,2,3]
    (6, 3)
>>> runningTotals [2,-2,10,5]
    (15, 4)
```
In particular this is to evaluate the peformance of the foldl library.

Run the benchmarks with:
```
cabal new-run FoldlBench -- --regress allocated:iters
```

What the output looks like on my machine with input `[1..10^8]`:
```
Fold Benchmark

benchmarking folds/sumAndLength
time                 674.6 ms   (524.6 ms .. 765.9 ms)
                     0.995 R²   (0.983 R² .. 1.000 R²)
mean                 686.6 ms   (671.2 ms .. 704.8 ms)
std dev              20.81 ms   (6.867 ms .. 27.43 ms)
allocated:           0.001 R²   (0.001 R² .. 1.000 R²)
  iters              -37.600    (-3880.000 .. 4944.000)
  y                  3832.000   (1412.000 .. 14648.000)
variance introduced by outliers: 19% (moderately inflated)

benchmarking folds/sumAndLengthStrict
time                 4.386 s    (397.1 ms .. 7.229 s)
                     0.916 R²   (0.714 R² .. 1.000 R²)
mean                 3.828 s    (2.941 s .. 4.578 s)
std dev              918.2 ms   (318.1 ms .. 1.172 s)
allocated:           1.000 R²   (1.000 R² .. 1.000 R²)
  iters              9.723e9    (9.723e9 .. 9.723e9)
  y                  4252.000   (-2440.000 .. 17168.000)
variance introduced by outliers: 48% (moderately inflated)

benchmarking folds/sumAndLengthStrict'
time                 317.5 ms   (310.6 ms .. 323.5 ms)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 318.7 ms   (316.2 ms .. 320.4 ms)
std dev              2.428 ms   (1.449 ms .. 3.292 ms)
allocated:           0.462 R²   (0.309 R² .. 1.000 R²)
  iters              -702.400   (-2077.000 .. 56.000)
  y                  4873.600   (1840.000 .. 7528.000)
variance introduced by outliers: 16% (moderately inflated)

benchmarking folds/sumAndLength'
time                 12.59 s    (9.281 s .. 16.43 s)
                     0.989 R²   (0.963 R² .. 1.000 R²)
mean                 12.76 s    (12.13 s .. 13.70 s)
std dev              975.2 ms   (396.9 ms .. 1.344 s)
allocated:           1.000 R²   (1.000 R² .. 1.000 R²)
  iters              8.123e9    (8.123e9 .. 8.123e9)
  y                  2696.000   (2696.000 .. 2696.000)
variance introduced by outliers: 21% (moderately inflated)

benchmarking folds/sumAndLength_Pair
time                 304.8 ms   (298.7 ms .. 310.5 ms)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 313.4 ms   (309.2 ms .. 323.6 ms)
std dev              7.973 ms   (708.1 μs .. 10.46 ms)
allocated:           0.535 R²   (0.385 R² .. 1.000 R²)
  iters              830.400    (56.000 .. 1992.000)
  y                  291.200    (-5129.600 .. 1840.000)
variance introduced by outliers: 16% (moderately inflated)

benchmarking folds/sumAndLengthPairRecurs
time                 301.8 ms   (284.3 ms .. 320.3 ms)
                     0.999 R²   (0.995 R² .. 1.000 R²)
mean                 303.8 ms   (300.9 ms .. 310.1 ms)
std dev              5.253 ms   (1.515 ms .. 7.024 ms)
allocated:           0.096 R²   (0.001 R² .. 1.000 R²)
  iters              -349.600   (-2225.500 .. 635.429)
  y                  3868.000   (1840.000 .. 9952.000)
variance introduced by outliers: 16% (moderately inflated)

benchmarking folds/sumAndLength_foldl
time                 666.3 ms   (653.1 ms .. 678.2 ms)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 664.9 ms   (662.7 ms .. 666.7 ms)
std dev              2.435 ms   (1.981 ms .. 2.742 ms)
allocated:           1.000 R²   (1.000 R² .. 1.000 R²)
  iters              5.600e9    (5.600e9 .. 5.600e9)
  y                  3868.000   (-2216.000 .. 14008.000)
variance introduced by outliers: 19% (moderately inflated)
```
