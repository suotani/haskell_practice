-- モナドはアプリカティブの強化版
-- class Monad m where
--   return :: a -> m a
  
--   -- バインドと呼ばれる関数
--   (>>=) :: m a -> (a -> m b) -> m b

--   (>>) :: m a -> m b -> m b
--   x >> y = x >>= _ -> y
  
--   fail :: String -> m a
--   fail msg = error msg

--MaybeのMonadインスタンスの実装
-- instance Monad Maybe where
--   return x = Just x
--   Nothing >>= f = Nothing
--   Just x >>= f = f x
--   fail _ = Nothing

--birdPle.hsがMaybeのモナドインスタンスを使ったサンプルコード
-- 失敗するかもしれない関数を連続して適用する場合はすっきり描ける

-- もし、モナド値が複数ある場合
-- foo :: Maybe String
-- foo = Just 3 >>= (\x ->
--       Just "!" >>= (\y ->
--       Just (show x ++ y)))
-- このように、入れ子にして、一つ一つ取り出すラムダ式が必要になる
-- Haskellでは、モナド専用にこのような式を綺麗に書く方法が用意されている
-- foo :: Maybe String
-- foo = do
--   x <- Just 3
--   y <= Just "!"
--   Just (show x ++ y)
-- IOのところで出てきたdo記法を使えばこんな感じにかける


--do記法を使うときも、パターンマッチを使う事ができる
justH :: Maybe Char
justH = do
  (x:xs) <- Just "hello"
  return x

-- リストもモナド
-- instance Monad [] where
--   return x = [x]
-- concatは多重リストを１段回平たくする rubyでいうflatten的な
--   xs >>= f = concat (map f xs)
--   fail _ = []

listOfTuples :: [(Int, Char)]
listOfTuples = do
  n <- [1,2]
  ch <- ['a', 'b']
  return (n, ch)

--この書き方はリスト内包表記を使って書くこともできる
--[(n ,ch) | n <- [1,2], ch <- ['a', 'b']]
--というのも、リスト内容表記はただのdo記法のシンタックスシュガーになっている