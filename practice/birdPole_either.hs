-- Eitherバージョン

type Birds = Int
type Pole = (Birds, Birds)

landLeft :: Birds -> Pole -> Either String Pole
landLeft n (left, right)
    | abs ((left + n) - right) < 4 = Right (left + n, right)
    | otherwise = Left $ show right ++ "," ++ show (left+n)

landRight :: Birds -> Pole -> Either String Pole
landRight n (left, right)
    | abs ((right + n) - left) < 4 = Right (left, right + n)
    | otherwise = Left $ show (right + n) ++ "," ++ show left

-- Just (0, 0) >>= landLeft 2 >>= landRight 3
-- Just (2,3)
-- Just (0, 0) >>= landLeft 2 >>= landRight 3 >>= landRight 4
-- Nothing

-- do記法を使うと以下のようにも描ける
routine :: Either String Pole
routine = do
  start <- return (0, 0)
  first <- landLeft 2 start
  second <- landRight 5 first
  landRight 1 second