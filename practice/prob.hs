import Data.Ratio
import Control.Monad
import Data.List (all)

-- 確率付きリスト

--何かのインスタンスにするために、newtypeでくるむ
newtype Prob a = Prob {getProb :: [(a, Rational)]}
  deriving Show
-- let p = Prob [(1, 1%3), (2, 2%3)]
-- getProb p
-- [(1,1 % 3),(2,2 % 3)]

instance Functor Prob where
  fmap f (Prob xs) = Prob $ map (\(x, p) -> (f x, p)) xs

-- fmap negate (Prob [(1, 1%3), (5, 2%3)])
-- Prob {getProb = [(-1,1 % 3),(-5,2 % 3)]}

-- Prob [
--   (Prob [(1, 1%2), (2, 1%2)], 4%5),
--   (Prob [(4, 1%3), (8, 2%3)], 1%5)
-- ]
flatten :: Prob (Prob a) -> Prob a
flatten  (Prob xs) = Prob $ concat $ map multAll xs
                       where multAll (Prob innerxs , p) =
                               map (\(x, r) -> (x , p * r)) innerxs

instance Applicative Prob where
  pure x = Prob [(x, 1%1)]
  Prob fs <*> Prob xs = Prob [(f x, fr * xr) | (f, fr) <- fs, (x, xr) <- xs]

-- 平坦化とreturnを作ればモナドにできる
instance Monad Prob where
  return x = Prob [(x, 1%1)]
  m >>= f = flatten (fmap f m)

-- 正常なコイン
data Coin = Heads | Tails deriving (Show, Eq)
coin :: Prob Coin
coin = Prob [(Heads, 1%2), (Tails, 1%2)]

-- 裏が90%の確率で出る異常なコイン
loadedCoin :: Prob Coin
loadedCoin = Prob [(Heads, 1%10), (Tails, 9%10)]

-- 2枚の正常コインと、１枚の異常コインを投げる
flipThree :: Prob Bool
flipThree = do
  a <- coin
  b <- coin
  c <- loadedCoin
  return (all (==Tails) [a,b,c])