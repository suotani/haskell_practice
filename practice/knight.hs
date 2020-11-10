import Control.Monad
import Data.List
--チェスの盤上(8x8)でのナイトの位置
type KnightPos = (Int, Int)

moveKnight :: KnightPos -> [KnightPos]
moveKnight (c,r) = do
  (c', r') <- [
    (c+2, r-1),
    (c+2, r+1),
    (c-2, r-1),
    (c-2, r+1),
    (c+1, r-2),
    (c+1, r+2),
    (c-1, c-2),
    (c-1, c+2)
    ]
  -- 成功か失敗かを検証する
  -- 条件に合わないものは弾かれる
  guard(c' `elem` [1..8] && r' `elem` [1..8])
  return (c', r')

--3手でどこまで動く可能性があるか
in3 :: KnightPos -> KnightPos -> [KnightPos]
in3 start end = do
  first <- moveKnight start
  second <- moveKnight first
  moveKnight second


-- startから出発して、３手でendまでたどり着けるかどうか
canReachIn3 :: KnightPos -> KnightPos -> Bool
canReachIn3 start end = end `elem` in3 start end

-- *Main Control.Monad> (6,2) `canReachIn3` (6,1)
-- True

-- TODO 経路を表示する

--モナディック関数を使ったバージョン
inMany :: Int -> KnightPos -> [KnightPos]
inMany x start =
  return start >>= foldr (<=<) return (replicate x moveKnight)

canReachIn :: Int -> KnightPos -> KnightPos -> Bool
canReachIn x start end = end `elem` inMany 3 start