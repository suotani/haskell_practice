module Util
( select
, permutation
, combinations
) where

import Data.List

select :: [a] -> [(a, [a])]
select [x] = [(x, [])]
select (x:xs) = (x,xs) : map (\(y,ys) -> (y, x:ys)) (select xs)

--順列
permutation :: Int -> [a] -> [[a]]
permutation 0 _ = [[]]
permutation n xs = 
  concatMap (\(y, ys) -> map (y:) $ permutation (n-1) ys) $ select xs

-- 組み合わせ
combinations :: Int -> [a] -> [[a]]
combinations n xs = comb n (length xs) xs
    where
      comb 0 _ _ = [[]]
      comb r n all@(x:xs)
          | n == r  = [all]
          | otherwise = map (x:) (comb (r-1) (n-1) xs) ++ comb r (n-1) xs