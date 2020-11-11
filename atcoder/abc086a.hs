data Number = Even | Odd deriving (Show)
main = do
  ab <- getLine
  let n = foldl (\acc x -> acc * (read x :: Int)) 1 (words ab)
      result = if (n `mod` 2) == 0
                 then Even
                 else Odd
  putStr $ show result