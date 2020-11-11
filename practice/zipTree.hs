--２分木
data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show)

--進む方向を表すリスト
-- data Direction = L | R deriving (Show)
-- *Crumb 移動もとのノード値 辿らなかった部分木
data Crumb a = LeftCrumb a (Tree a)
             | RightCrumb a (Tree a)
             deriving (Show)

type Breadcrumps a = [Crumb a]

--データ構造の今注目している点、および周辺の情報を含んでいるデータ構造をZipperという
type Zipper a = (Tree a, Breadcrumps a)


goLeft :: Zipper a -> Maybe (Zipper a)
goLeft (Node x l r, bs) = Just (l, (LeftCrumb x r):bs)
goLeft (Empty, _) = Nothing

goRight :: Zipper a -> Maybe (Zipper a)
goRight (Node x l r, bs) = Just (r, (RightCrumb x r):bs)
goRight (Empty, _) = Nothing

goUp :: Zipper a -> Maybe (Zipper a)
goUp (t, (LeftCrumb x r):bs) = Just (Node x t r, bs)
goUp (t, (RightCrumb x l):bs) = Just (Node x l t, bs)
goUp (_, []) = Nothing
-- goLeft . goRight $ (freeTree, [])
-- (Node 'W' (Node 'C' Empty Empty) (Node 'R' Empty Empty),[L,R])

-- 補助関数
x ->> f = f x

-- (freeTree, []) ->> goRight ->> goLeft
-- (部分木, 部分木までのルート:パンクズリスト)という形式になっている

--今注目している部分の値を書き換える関数
modify :: (a -> a) -> Zipper a -> Zipper a 
modify f (Node x l r, bs) = (Node (f x) l r, bs)
modify f (Empty, bs) = (Empty, bs)

-- この関数を使うと、「左、右と進んだノードの値をPで置き換える」という操作を次のようにかける
--newFocus = (freeTree, []) ->> goLeft ->> goRight ->> modify (\_ -> 'P')

-- この構造であれば、末端のEmptyを別の木で置き換えることで、木の継ぎ足しができる
attach :: Tree a -> Zipper a -> Zipper a
attach t (_, bs) = (t, bs)

--topまで移動
topMost :: Zipper a -> Maybe (Zipper a)
topMost (t, []) = Just (t, [])
topMost z = goUp z >>= topMost


freeTree :: Tree Char
freeTree =
  Node 'P'
    (Node 'O'
      (Node 'L'
        (Node 'N' Empty Empty)
        (Node 'T' Empty Empty)
      )
      (Node 'Y'
        (Node 'S' Empty Empty)
        (Node 'A' Empty Empty)
      )
    )
    (Node 'L'
      (Node 'W'
        (Node 'C' Empty Empty)
        (Node 'R' Empty Empty)
      )
      (Node 'A'
        (Node 'A' Empty Empty)
        (Node 'C' Empty Empty)
      )
    )