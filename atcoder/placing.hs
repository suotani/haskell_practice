main = do
  a <- getLine
  putStr $ show . length $ filter (\x -> x == '1' ) a