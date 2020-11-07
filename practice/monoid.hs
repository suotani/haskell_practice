import Data.Monoid
--モノイド則
-- 1 ２変数関数*を持つ
-- 2 (*) :: a -> a -> a(型が変わらない)
-- 3 単位元が存在する
-- 4 結合律 (a * b) * c = a * (b * c)がなりたつ

--モノイド型クラス
-- mは具体型
-- class Monoid m where
--   mempty :: m  --多相定数。単位元を表す
--   mappend :: m -> m -> m -- ２項演算
--   mconcat :: [m] -> m
--   mconcat = foldr mappend mempty --デフォルト実装

--リストはモノイド
-- 単位元[]
-- ２項演算 ++

-- Intもモノイド
-- 単位元0
-- 演算 +

-- 一つの型に対して、モノイドになる方法は複数ある
-- モノイドの複数のインスタンス実装を作るために、newtypeで既存の型から新しい型を作り、複数のインスタンスを作る
-- Intだと、上記以外にも(1, *)のモノイドがある
--そして、すでにData.MonoidにIntのモノイドインスタンスが用意されている
-- newtype Product a = Product { getProduct :: a }

-- 他にも、Boolは&&か||どちらを演算にするかによって、２つのモノイドが存在する
-- ||はAny, &&はAllという型がある
-- newtype Any = Any { getAny :: Bool } deriving (Eq, Ord, Read, Show, Bounded)
-- instance Monoid Any where
--   mempty = Any False
--   Any x `mappend` Any y = Any (X || y)

-- *Main Control.Applicative> getAny $ Any True `mappend` Any False
-- True

-- Orderingもモノイド
-- instance Monoid Ordering where
--   mempty = EQ
--   LT `mappend` _ = LT
--   EQ `mappend` y = y
--   GT `mappend` _ = GT

-- このように定義することで、例えば幾つかの比較条件があって、より優先したいものを左に書けば良い
-- 下の例では、長さを比較して、同じ長さなら単語同士の辞書順で比較する
-- lengthCompare :: String -> String -> Ordering
-- lengthCompare x y = (length x `compare` length y) `mappend` (x `compare` y)
