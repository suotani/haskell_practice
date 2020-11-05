--逆ポーランド計算機

solveRPN :: String -> Double
solveRPN = head . foldl stock [] . words
--stock :: [Double] -> String -> [Double]
  where stock (x:y:xs) "+" = (y + x):xs
        stock (x:y:xs) "-" = (y - x):xs
        stock (x:y:xs) "*" = (y * x):xs
        stock (x:y:xs) "/" = (y / x):xs
        stock xs "sum" = [sum xs]
        stock xs numString = read numString:xs
