import Util
--覆面算
--   SEND
-- + MORE
-- --------
--  MONEY
-- 足し算なので、Mが１は確定、その他の数値を埋めて完成させる

check_hukumen :: [Int] -> [String] -> [String]
check_hukumen (s:e:n:d:o:r:y:[]) a =
  if send + more == money then expr:a else a
  where send = s * 1000 + e * 100 + n * 10 + d
        more = 1000 + o * 100 + r * 10 + e
        money = 10000 + o * 1000 + n * 100 + e * 10 + y
        expr = show send ++ "+" ++ show more ++ "=" ++ show money

-- 組み合わせを総当たりする
hukumen_solver :: [String]
hukumen_solver =
  foldr check_hukumen [] (permutation 7 [0,1,2,3,4,5,6,7,8,9]) 
