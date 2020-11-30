import Data.List


safe :: [Int] -> Bool
safe [] = True
safe (x:xs) = if attack 1 x xs then False else safe xs

queen :: [Int] -> [[Int]]
queen xs = filter safe $ permutations xs

attack :: Int -> Int -> [Int] -> Bool
attack _ _ [] = False
attack n x (y:ys) =
  if x == y + n || x == y - n
    then True
    else attack (n + 1) x ys


-- queen [1..5]


--queen早いバージョン
-- 絶対失敗するパターンを早期に切り捨てる

select :: [a] -> [(a, [a])]
select [x] = [(x, [])]
select (x:xs) = (x, xs) : map (\(y, ys) -> (y, x:ys)) (select xs)

select_queen :: ([Int], [Int]) -> [([Int], [Int])]
select_queen (xs, ys) =
  foldr (\(z, zs) a -> if attack 1 z ys then a else (zs, z:ys):a) [] $ select xs

queen_fast :: [Int] -> [[Int]]
queen_fast xs = iter (length xs) [(xs, [])]
  where iter 0 ys = map snd ys
        iter n ys = iter (n-1) $ concatMap select_queen ys