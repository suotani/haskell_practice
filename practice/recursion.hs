--関数を再帰的に定義するには、解こうとする問題を同じ種類のより小さな問題に分解し、
--それら部分問題を解くことを考える
--再帰を使わずに定義する部分問題を基底部と言う
--haskellはどうやって計算するのかではなく、何を求めるべきかを宣言する
--そのため、haskellでは再帰が重要
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib x = fib (x-1) + fib (x-2)

maximum' :: [Int] -> Int
maximum' [] = error "error"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)

-- replicate' :: Int -> a -> [a]
-- replicate' 0 _ = []
-- replicate' n a = a:replicate' (n-1) a

replicate' :: Int -> a -> [a]
replicate' n x
    | n <= 0    = []
    | otherwise = x : replicate' (n-1) x

take' :: Int -> [a] -> [a]
take' n _ 
   | n < 0     = []
   | n == 0    = []
take' _ []     = []
take' n (x:xs) = x : take' (n-1) xs

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x, y) : zip' xs ys

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
  let smallerOrEqual = [a | a <-xs, a <= x]
      larger = [a | a <- xs, a > x]
  in quicksort smallerOrEqual ++ [x] ++ quicksort larger