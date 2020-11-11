main = do
  a <- getLine
  bc <- getLine
  let n = foldl (\acc x -> acc + (read x :: Int)) 0 (a:words bc)
  s <- getLine
  putStr $ (show n) ++ " " ++ s
