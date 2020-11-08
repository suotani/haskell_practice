type Birds = Int
type Pole = (Birds, Birds)

landLeft :: Birds -> Pole -> Maybe Pole
landLeft n (left, right)
    | abs ((left + n) - right) < 4 = Just (left + n, right)
    | otherwise = Nothing

landRight :: Birds -> Pole -> Maybe Pole
landRight n (left, right)
    | abs ((right + n) - left) < 4 = Just (left, right + n)
    | otherwise = Nothing

-- Just (0, 0) >>= landLeft 2 >>= landRight 3
-- Just (2,3)
-- Just (0, 0) >>= landLeft 2 >>= landRight 3 >>= landRight 4
-- Nothing

-- do記法を使うと以下のようにも描ける
routine :: Maybe Pole
routine = do
  start <- return (0, 0)
  first <- landLeft 2 start
  second <- landRight 3 first
  landRight 1 second