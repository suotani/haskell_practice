--リストはx:xsのようにheadとtailに分けることができる
-- つまり、１分木のような構造を持っている

type ListZipper a = ([a], [a])

--リストを前後に移動する関数
goForward :: ListZipper a -> ListZipper a
goForward (x:xs, bs) = (xs, x:bs)

goBack :: ListZipper a -> ListZipper a
goBack (xs, b:bs) = (b:xs, bs)

-- 補助関数
x ->> f = f x

-- *Main> ([1,2,3,5,6], []) ->> goForward
-- ([2,3,5,6],[1])
-- *Main> ([1,2,3,5,6], []) ->> goForward ->> goForward
-- ([3,5,6],[2,1])
-- *Main> ([1,2,3,5,6], []) ->> goForward ->> goForward ->> goBack
-- ([2,3,5,6],[1])

-- goTop書く