------------------------------------------------------------------------------
-- |
--
-- A benchmark for sumAndLength as discussed in the foldl library documentation.

{-# LANGUAGE BangPatterns        #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE UnboxedTuples       #-}

module Main where

import qualified Control.Foldl         as L
import           Control.Scanl
import qualified Criterion.Main        as C (bench, bgroup, defaultMain, nf)
import           Data.Functor.Identity
import           Data.List


sumAndLength :: Num a => [a] -> (a, Int)
sumAndLength xs = (sum xs, length xs)

sumAndLength' :: Num a => [a] -> (a, Int)
sumAndLength' xs = foldl' step (0, 0) xs
  where
    step (x, y) n = (x + n, y + 1)


sumAndLength_Pair :: Num a => [a] -> (a, Int)
sumAndLength_Pair xs = done (foldl' step (Pair 0 0) xs)
  where
    step (Pair x y) n = Pair (x + n) (y + 1)

    done (Pair x y) = (x, y)

sumAndLengthStrict :: forall a . Num a => [a] -> (a, Int)
sumAndLengthStrict xs = go (0, 0) xs
  where
    go :: (a, Int) -> [a] -> (a, Int)
    go !(!v, !n) [] = (v, n)
    go (s, n) (a : as) =
      let
        !(!mySum, !myLength) = go (s, n) as
      in
        (a + s, n + 1)

sumAndLengthStrict' :: forall a . Num a => [a] -> (a, Int)
sumAndLengthStrict' xs = done (foldl' step (0, 0) xs)
  where
    step !(!s, !l) n = (s + n, l + 1)

    done !(!s, !l) = (s, l)

data Pair a b = Pair !a !b

sumAndLengthPairRecurs :: forall a . Num a => [a] -> (a, Int)
sumAndLengthPairRecurs xs = done (go xs (Pair 0 0))
  where
    go :: [a] -> Pair a Int -> Pair a Int
    go [] p              = p
    go (a:as) (Pair s l) = go as (Pair (s + a) (l + 1))

    done (Pair a b) = (a,b)



sumAndLength_foldl = L.fold ((,) <$> L.sum <*> L.length)


testList :: [Int]
testList = [1..10^8]


main :: IO ()
main = C.defaultMain
     [ C.bgroup "folds"
       [
          C.bench "sumAndLength"             $ C.nf sumAndLength            testList
        , C.bench "sumAndLengthStrict"       $ C.nf sumAndLengthStrict      testList
        , C.bench "sumAndLengthStrict'"      $ C.nf sumAndLengthStrict'     testList
        , C.bench "sumAndLength'"            $ C.nf sumAndLength'           testList
        , C.bench "sumAndLength_Pair"        $ C.nf sumAndLength_Pair       testList
        , C.bench "sumAndLengthPairRecurs"   $ C.nf sumAndLengthPairRecurs  testList
        , C.bench "sumAndLength_foldl"       $ C.nf sumAndLength_foldl      testList
       ]
     ]
