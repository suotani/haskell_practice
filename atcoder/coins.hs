import Control.Monad
import Data.List

main = do
  inputa <- getLine
  inputb <- getLine
  inputc <- getLine
  inputn <- getLine
  let a = (read inputa :: Int)
      b = (read inputb :: Int)
      c = (read inputc :: Int)
      n = (read inputn :: Int)
      maxa = min a (n `div` 500)
      maxa = min b (n `div` 100)
      maxa = min c (n `div` 50)
      as = uniq $ filterM (\x -> [True, False]) . replicate maxa $ 500
      bs = uniq $ filterM (\x -> [True, False]) . replicate maxb $ 100
      cs = uniq $ filterM (\x -> [True, False]) . replicate maxc $ 50
      patterns = [concat [ax, bx, cx]| ax <- as, bx <- bs, cx <- cs]
      sums = map (\x -> sum x) patterns
      matcheSize = length $ filter (\x -> x == (read n :: Int)) sums
  putStr $ show matcheSize

uniq :: (Eq a) => [a] -> [a]
uniq [] = []
uniq xs = foldl (\acc x -> if x `elem` acc then acc else x:acc) [] xs
