--リストやMaybeはFunctor型クラスのインスタンスになっており、
-- fmap関数が実装されている([]ならmapがその実装)
--IOも実はFunctor型クラスのインスタンスになっていて、大体次のように定義されている

-- instance Functor IO where
--   fmap f action = do
--     result <- action
--     return (f result)

-- (->) rもファンクターの一つ
-- a -> b のように関数の型を表すのに使う
-- ->のfmapは次のように宣言されている
-- instance Functor ((->) r) where
--  fmap f g = (\x -> f (g x))

-- fmapは、(a -> b) -> f a -> f b だったから、fを->で置き換えると
-- fmap :: (a -> b) -> (r -> a) -> (r -> b)
-- つまり、関数合成を表す
-- instance Functor ((->) r) where
--  fmap = (.)
-- としても同じ
mult3 :: Int -> Int
mult3 = fmap (*3) (+100)
-- *Main> mult3 1
-- 303
-- *Main> mult3 3
-- 309
-- r -> aというのは「型r」を、「型rの入力を適用すれば、a型が返ってくる」というコンテキストの中に入れる
--一般的にfanctorは値を文脈を持つ値として表す方法
-- Int -> Int というのは「結果が欲しかったら、Int型に適用せよ」
-- String -> Int というのは「結果が欲しかったら、String型に適用せよ」という文脈になる

-- fmap :: (Functor f) => (a -> b) -> f a -> f b
--をカリー化を使って表現すると
-- (a -> b) -> (f a -> f b)
--という表現になる。この真ん中の矢印を「関数の持ち上げ(lifting)」という

-- functorには、見たすべきfunctor則というのが２つある
-- 1. fmap id = id
-- 2. fmap (f . g) = fmap f . fmap g
-- ある型functorのインスタンスにするときには、この法則を満たしているかどうか調べる必要がある

