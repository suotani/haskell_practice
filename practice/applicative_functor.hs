-- fmapの第一引数が２変数関数だと
-- :t fmap (*) (Just 3)
-- fmap (*) (Just 3) :: Num a => Maybe (a -> a)
-- のようになる

-- let a =  fmap (++) (Just "hey")
-- fmap (\x -> x "aa") a
-- Just "heyaa"

--let r = fmap replicate [1,2,3]
--fmap (\x -> x 2) r 
-- [[2],[2,2],[2,2,2]]

-- このような例はうまく行ったが、一般的にファンクターの中の関数で、別のファンクターの中の値を写すことは不可能
--そこで、型クラスApplicativeを使う

-- class (Functor f) => Applicative f where
--   pure :: a -> f a
--   (<*>) :: f (a -> b) -> f a -> f b

例えば、MaybeはApplicativeになっている
instance Applicative Maybe where
  pure = Just
  Nothing <*> _ =Nothing
  (Just f) <*> somthing = fmap f somthing

-- *Main> Just (*3) <*> Just 9
-- Just 27
-- *Main> [(*3)] <*> [1,2,3]
-- [3,6,9]
-- *Main> pure (+) <*> Just 3 <*> Just 5
-- Just 8

-- 上の例では、+関数をpureで入れてから、<*>で取り出して適用している
-- pure f <*> xというのは、fmap f xと同じ
-- そこで、fmapと等価な中置関数<$>がある
-- (<$>) :: (Functor f) => (a -> b) -> f a -> f b
-- f <$> x = fmap f x

-- *Main> map (*3) [1,2,3]
-- [3,6,9]
-- *Main> (*3) <$> [1,2,3]
-- [3,6,9]
-- *Main> (+) <$> [1,2,3] <*> [1,2,3]
-- [2,3,4,3,4,5,4,5,6]
-- *Main> filter (>50) $ (*) <$>  [7,8,10] <*> [3,4,8]
-- [56,64,80]

--リストは次のような宣言でapplicativeになっている
-- instance Applicative [] where
--   pure x = [x]
--   fs <*> xs = [f x | f <- fs, x <- xs]

-- リストは組み合わせの数だけ要素数が増えるが、リストに似たZipListなら
-- <*>を使ってもzipWithのような動きをする
-- import Control.Applicative
-- let list = ZipList [(*2), (+3)] <*> ZipList [1,2]
-- getZipList list
-- [2,5]

-- (\x y z -> x + y * z) <$> ZipList [1,2,3] <*> ZipList [2,2,2] <*> ZipList [3,3,3]
--ZipList {getZipList = [7,8,9]}
-- 配列で同じことをする場合、zipWith3が必要、４変数ならzipWith4を使う
-- ZipListなら、関数を選ばなくても良い

--Applicativeには、sequenceAという面白い関数がある
--sequenceAはアプリカティブ値のリストを受け取り、リストのアプリカティブ値を返す
-- *Main Control.Applicative> sequenceA [Just 4, Just 2, Just 5]
-- Just [4,2,5]
-- *Main Control.Applicative> sequenceA [(+3), (*2), (+1)] 4
-- [7,8,5]

--これを使うと、ある数がいくつかの性質を同時に満たすかどうかの関数を簡単に作れる
-- *Main Control.Applicative> sequenceA [(>4), (<10), odd] 7
-- [True,True,True]
-- *Main Control.Applicative> and $sequenceA [(>4), (<10), odd] 7
-- True
-- *Main Control.Applicative> and $sequenceA [(>4), (<10), odd] 11
-- False