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

--mtlというパッケージに、様々なモナドが入っている
-- stack install mtl

-- * Writer ログのような情報を付加する
euclid.hs



-- * Stateモナド  状態つき計算を行う
-- sが状態の型 aが結果の型
-- newtype State s a = State { runState :: s -> (a, s) }
-- instance Monad (State s) where
--   return x = State $ (\s -> (x, s))
     -- 現在の状態s, 状態付き計算h
     -- 計算結果a, 新しい状態newState
     -- 新しい状態付き計算g
     -- 
--   (State h) >>= f = State $ \s -> let (a, newState) = h s
--                                       (State g) = f a
--                                   in g newState

-- Eitherモナド 
-- Either e aはMaybeの強化版で、エラー情報を持っていてくれる
-- Right値であれば成功した計算結果を、Left値であれば失敗を表す
-- EitherモナドのLeft値はError型クラスのインスタンスになっている必要がある
-- instance (Error e) => Monad (Either e) where
--   return x = Right x
--   Right x >>= f = f x
--   Left err >>= f = Left err
     -- strMsg :: (Error a) => String -> a
--   fail msg = Left (strMsg msg)


-- モナド値を操作したり、モナド値を返したりする関数は特にモナディック関数と呼ばれる

-- liftM : Functorのfmapのモナドバージョン
-- liftM :: (Monad m) => (a -> b) -> m a -> m b
-- <$> == `liftM`
 
-- ap : Applicativeの<*>のモナドバージョン
-- ap :: (Monad m) => m (a -> b) -> m a -> m b 
-- mf は結果が関数であるモナド値
-- ap mf m = do
--   f <- mf
--   x <- m
--   return (f x)
-- <*> == `ap`

-- (+) `liftM` Just 6 `ap` Just 9
-- Just 15
--以上から、モナドであれば自動的にfunctorとapplicativeのメソッドが使えるため、
--モナドはアプリカティブ、ファンクターよりも強いと言える

-- join 入れ子になったモナドを平にする
-- join :: (Monad m) => m (m a) -> m a
-- *Main Control.Monad> join (Just (Just 4))
-- Just 4
-- *Main Control.Monad> join (Just Nothing)
-- Nothing
-- *Main Control.Monad> join [[1,2,3], [2,3,4]]
-- [1,2,3,2,3,4]

-- join (fmap f m)とm >>= fは同じ

--filterM 述語がモナドだったなら
-- filterM :: (Monad m) => (a -> m Bool) -> [a] -> m [a]
-- 以下のコードで、引数のリストの冪集合が作れる
-- filterM (\x -> [True, False]) [1,2,3]
-- [[1,2,3],[1,2],[1,3],[1],[2,3],[2],[3],[]]
-- filterM (\x -> Just True) [1,2,3]
-- Just [1,2,3]

--foldM  foldlのモナド版
-- foldl :: (a -> b -> a) -> a -> [b] -> a
-- foldM :: (Monad m) => (a -> b -> m a) -> a -> [b] -> m a

-- maybe_rpn.hs

-- モナディック関数を合成する
-- <=<を使うと、合成することができる
-- g = (\x -> return (x+1)) <=< (\x -> return (x*100))
-- (Monad m, Num c) => c -> m c