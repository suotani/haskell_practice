main = do
  n <- getLine
  as <- getLine
  let nums = map (\x -> read x :: Int) (words as)
      twos = map (\x -> 2^x) [1..]
      (trues, falses) = break (\x -> not x) $ map (\x -> allDividable x nums) twos
  putStr $ show (length trues)


allDividable :: Int -> [Int] -> Bool
allDividable n = all (\x -> x `mod` n == 0)