import Data.Char
main = do
  inputs <- getLine
  let (n:a:b:[]) = map (\x -> read x :: Int) (words inputs)
      result = sum $ filter (\x -> a <= toSumDigit x && toSumDigit x <= b) [1..n]
  putStr $ show result

toSumDigit :: Int -> Int
toSumDigit n = foldl (\acc x -> acc + (ord x - 48) ) 0 (show n)