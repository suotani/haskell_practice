-- stack install random
import System.Random
import System.IO 

-- randomを返す関数
-- ジェネレータを受け取って、ランダム値と新しいジェネレータ(の数値表現)を返す
--random :: (RandomGen g, Random a) => g -> (a, g)

--コイントスプログラム
threeCoins :: StdGen -> (Bool, Bool, Bool)
threeCoins gen = 
  let (firstCoin, newGen) = random gen
      (secondCoin, newGen') = random newGen
      (thirdCoin, newGen'') = random newGen'
  in (firstCoin, secondCoin, thirdCoin)

-- threeCoins (mkStdGen 100)
-- もっとたくさんのランダムな数が欲しい時は、randoms関数を使う
-- randoms :: StdGen -> [a]
-- take 3 $ randoms (mkStdGen 1) :: [Bool]
-- take 3 $ randoms (mkStdGen 1) :: [Int]

--randomRを使う事で、ある範囲内のランダムを作る事ができる
-- randomR :: (RandomGen g, random a) => (a, a) -> g -> (a, g)
--randomRsはrandomRの無限リストバージョン
main = do
  -- 外部からの何かしらの入力をジェネレータにする
  gen <- getStdGen
  putStrLn $ take 20 (randomRs ('a', 'z') gen)

