import Control.Monad.Writer

product' :: Int -> [Int] -> Writer [String] Int
product' _ [] = do
  tell ["no item"]
  return 0
product' n [x] = do
  tell ["product last item: " ++ show x]
  return (n * x)
product' n (x:xs) = do
  tell ["producting item: " ++ show x]
  product' (x * n) xs


-- mapM_ putStrLn . snd . runWriter $ product' 1 [2,3,4,5,6]
-- producting item: 2
-- producting item: 3
-- producting item: 4
-- producting item: 5
-- product last item: 6
