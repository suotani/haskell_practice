qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
  where
    smaller = [a | a <- xs, a <= x]
    larger = [b | b <- xs, b > x]

-- qsort [2,5,7,3,8,1]
-- [1,2,3,5,7,8]


merge :: Ord a => [a] -> [a] -> [a]
merge [] ys =  ys
merge xs [] =  xs
merge (x:xs) (y:ys)
  | x > y = y : merge (x:xs) ys
  | otherwise = x : merge xs (y:ys)

-- merge [2,5,6] [1,3,4]
-- [1,2,3,4,5,6]