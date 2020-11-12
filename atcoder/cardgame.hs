import Data.List
main = do
  inputn <- getLine
  inputas <- getLine
  let cards = reverse . sort . map (\x -> (read x :: Int)) . words $ inputas
      sums = devideCards cards (0, 0)
      result = (fst sums) - (snd sums)
  putStr $ show result


devideCards :: [Int] -> (Int, Int) -> (Int, Int)
devideCards [] (x, y) = (x, y)
devideCards [a] (x, y) = (a + x, y)
devideCards (a:b:xs) (x, y) = devideCards xs (a + x, b + y)
