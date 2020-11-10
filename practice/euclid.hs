import Control.Monad.Writer

-- ユークリッド互除法で最大公約数を求める
-- ただし、Writerモナドによるログ付き
gcd' :: Int -> Int -> Writer [String] Int
gcd' a b
    | b == 0  = do
      -- tell :: MonadWriter w m => w -> m ()
      tell ["Finished with " ++ show a]
      -- return :: Monad m => a -> m a
      return a  -- returnを使ってdo式の結果としている
    | otherwise = do
      tell [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
      gcd' b (a `mod` b)
-- *Main> gcd' 147 11
-- WriterT (Identity (1,["147 mod 11 = 4","11 mod 4 = 3","4 mod 3 = 1","3 mod 1 = 0","Finished with 1"]))

-- *Main> mapM_ putStrLn $ snd $ runWriter (gcd' 147 11)
-- 147 mod 11 = 4
-- 11 mod 4 = 3
-- 4 mod 3 = 1
-- 3 mod 1 = 0
-- Finished with 1


-- original code
sumWithLog :: Int -> [Int] -> Writer [String] Int
sumWithLog a [x] = do
  tell ["last add " ++ show x]
  return (a + x)
sumWithLog a (x:xs) = do
  tell ["add " ++ show x]
  sumWithLog (a + x) xs

-- mapM_ putStrLn $ snd $ runWriter (sumWithLog 0 [1,2,3])
-- add 1
-- add 2
-- last add 3