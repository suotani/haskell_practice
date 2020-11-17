-- insert 3 [1,2,4,5] => [1,2,3,4,5]

insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:xs) 
    | x <= y = x:y:xs
    | otherwise = y : insert x ys


isort :: Ord a -> [a] -> [a]
isort [] = []
isort (x:xs) = insert x (isort xs)