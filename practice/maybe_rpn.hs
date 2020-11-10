import Data.List
import Control.Monad

readMaybe :: (Read a) => String -> Maybe a
readMaybe st = case reads st of
                 [(x, "")] -> Just x
                 _ -> Nothing

--逆ポーランド計算機 Maybeバージョン

solveMaybeRPN :: String -> Maybe Double
solveMaybeRPN st = do
  [result] <- foldM stock [] (words st)
  return result
--stock :: [Double] -> String -> Maybe [Double]
  where stock (x:y:xs) "+" = return ((y + x):xs)
        stock (x:y:xs) "-" = return ((y - x):xs)
        stock (x:y:xs) "*" = return ((y * x):xs)
        stock (x:y:xs) "/" = return ((y / x):xs)
        stock xs "sum" = return ([sum xs])
        stock xs numString = liftM (:xs) (readMaybe numString)