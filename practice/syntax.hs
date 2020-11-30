doubleMe :: Int -> Int
doubleMe x = x + x

doubleUs :: Int -> Int -> Int
doubleUs x y = doubleMe x + doubleMe y

squareUs :: Int -> Int -> Int
squareUs x y = x * x + y * y

doubleSmallNumber :: Int -> Int
doubleSmallNumber x = if x > 100
                        then x
                        else x * 2

-- 独自データ型
data RhType = Pos | Neg
data ABOType = A | B | AB | O
data BloodType = BloodType ABOType RhType
-- patient1BT :: BloodType
-- patient1BT = BloodType A Pos

-- パターンまっち
lucky :: Int -> String
lucky 7 = "Lucky!"
lucky _ = "un lucky"

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial(n - 1)

head' :: [a] -> a
head' [] = error "error"
head' (x:_) = x

-- ガード

bmiTell :: Double -> Double -> String
bmiTell _ 0 = "error"
bmiTell weight height
    | weight / height ^ (2 :: Int) <= 18.5 = "light"
    | weight / height ^ (2 :: Int) <= 25.0 = "heavy"
    | otherwise = "very hat!"

myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
    | a == b = EQ
    | a < b = LT
    | otherwise = GT

-- whereで中間結果に名前をつける
-- whereで作った関数はガードの中からも呼び出せる
bmiTell2 :: Double -> Double -> String
bmiTell2 _ 0 = "error"
bmiTell2 weight height
    | bmi <= light = "light"
    | bmi <= heavy = "heavy"
    | otherwise = "very hat!"
    where bmi = weight / height ^ (2 :: Int)
          (light, heavy) = (18.5, 25.0) --パターンマッチも使える

--let
--letは式なので、値を返す(inで書いたやつ)
--どこでも変数を束縛
-- ただしガード間では共有されない
-- 非常に局所的
cylinder :: Double -> Double -> Double
cylinder r h =
  let sideArea = 2 * pi * r * h
      topArea = pi * r ^ 2
  in  sideArea + 2 * topArea

--whereバージョン
cylinder' :: Double -> Double -> Double
cylinder' r h = sideArea + 2 * topArea
  where sideArea = 2 * pi * r * h
        topArea = pi * r ^ 2

--letを使ったリスト内包表記
calcBmis :: [(Double, Double)] -> [Double]
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h^2, bmi > 25.0]

--case式
--式なので値を返す
--関数の引数に対するcaseはパターンマッチの構文糖衣
head'' :: [a] -> a
head'' xs = case xs of []    -> error "error"
                       (x:_) -> x
