bubbleSort :: (Ord a) =>  [a]  -> [a]
bubbleSort [] = []
bubbleSort xs = y:bubbleSort ys
  where (y:ys) = reverse . floatMinimum $ reverse xs

floatMinimum :: (Ord a) => [a] -> [a]
floatMinimum [] = []
floatMinimum [x] = [x]
floatMinimum (x:y:xs) = 
  if x > y
    then
      x:floatMinimum(y:xs)
    else
      y:floatMinimum(x:xs)

