import Data.List
--２分探索をリストに対して行う

binSearch :: (Ord a) => [a] -> a -> Bool
binSearch [] _  = False
binSearch [x] a = x == a
binSearch xs a
  | center == a = True
  | center < a = binSearch (filter ( > center) sorted) a
  | otherwise  = binSearch (filter ( <= center) sorted) a
  where sorted = sort xs
        center = sorted !! ((length xs) `div` 2 - 1)

-- *Main> binSearch [3,5,7,4,8,5,2, 10] 10
-- True
-- *Main> binSearch [3,5,7,4,8,5,2, 10] 5
-- True
-- *Main> binSearch [3,5,7,4,8,5,2, 10] 1
-- False