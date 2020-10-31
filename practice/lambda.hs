add :: Int -> Int -> Int
add x y = x + y

add2 :: Int -> Int
add2 x = x + 2

applyAny :: Int -> (a -> a)  -> a -> a
applyAny n _ _
    | n <= 0 = error "error n is larger than 0"
applyAny 1 f x = f x
applyAny n f x = f (applyAny (n-1) f x)

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

--True or Falseを返す関数は特に述語という

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' p (x:xs)
    | p x       = x : filter' p xs
    | otherwise = filter' p xs

--ラムダ式で即席関数を作ることができる
-- zipWith (\a b -> (a * 2 + b)) [1,2,3] [4,5,6]

-- 畳み込みは、基底部である空リストとx:xsのパターン分けを使ってリスト
-- に対する再帰を行う処理のパターンを一般化したもの
-- リストを走査して何かを返したいときは畳み込みを使うチャンス
-- foldl 左畳み込み
-- foldl :: (a -> b -> a) -> a -> [b] -> a 
sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs
--またはカリー化を利用して
-- sum' = foldl (+) 0
-- accはアキュムレータと呼ばれる
-- (a -> b -> a)の値が新しいアキュムレータaccになる

mapr :: (a -> b) -> [a] -> [b]
mapr f xs = foldr (\x acc -> f x : acc) [] xs

mapl :: (a -> b) -> [a] -> [b]
mapl f xs = foldl (\acc x -> acc ++ [f x]) [] xs

-- ++は:に比べて遅いので、このような場合は右畳み込みを使う

--リストの先頭の要素をアキュムレータとして使うfoldl1 foldr1もある
maximum' :: (Ord a) => [a] -> a
maximum' = foldl1 max

-- 途中のアキュムレータを全て保存して、リストとして返す
-- scanl scanrという関数もある
-- scanl (+) 10 [1,2,3,4,5]
-- -> [10,11,13,16,20,25]

--かっこの多い関数適用は、$関数
-- $ : (a -> b) -> a -> b
--でかっこを省略できる
mapSum :: Int
mapSum = sum (filter (> 10) (map (*2) [2..10]))

mapSum' :: Int
mapSum' = sum $ filter (> 10) $ map (*2) [2..10]

-- .関数で関数合成ができる
-- (.) :: (b -> c) -> (a -> b) -> a -> c
mnst :: [[Integer]] -> [Integer]
mnst xs = map (\xss -> negate (sum (tail xss))) xs

mnst' :: [[Integer]] -> [Integer]
mnst' xs = map (negate . sum . tail) xs

(+) 1 . length . takeWhile (<1000) . scanl1 (+) . map sqrt $ [1..]
