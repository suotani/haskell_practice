import Control.Monad
import Data.List
main = do
  n <- readLn
  inputs <- replicateM n getLine
  let sorted = uniq . sort . map (\x -> read x :: Int) $ inputs
  print . length $ sorted
  


uniq :: (Eq a) => [a] -> [a]
uniq [] = []
uniq xs = foldl (\acc x -> if x `elem` acc then acc else x:acc) [] xs