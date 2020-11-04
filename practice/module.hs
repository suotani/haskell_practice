--import モジュール名　でインポートできる
import Data.List
import Data.Char
import qualified Data.Map as Map
import Geometry

-- 修飾付きインポートをすると、関数名に就職を付けなければならない
-- import qualified Data.Map
-- Data.List.filter
--あるいは
-- import qualified Data.Map as M
-- M.filter
-- のように短縮名書くことができる


-- Maybe型でエラーが発生する処理に対処する
--連想配列 [("nam1", 12), ("name2", 22), ("name3", 56)]に対して、キーから値を取り出す処理
findKey :: (Eq k) => k -> [(k, v)] -> v
findKey key = snd . head . filter (\(k, v) -> key == k)
--ただし、この実装では、からの配列に対してheadを実行しようとした時に、クラッシュする
-- そこで、次のように結果をMaybe型にする

findKey' :: (Eq k) => k -> [(k, v)] -> Maybe v
findKey' key [] = Nothing
findKey' key ((k, v):xs)
    | key == k = Just v
    | otherwise = findKey' key xs

--さらに、畳み込みを使うとこんな感じになる
findKey'' :: (Eq k) => k -> [(k, v)] -> Maybe v
findKey'' key = foldr (\(k, v) acc -> if key == k then Just v else acc) Nothing

-- Mapは連想配列に似ているが、keyがOrd型クラスに属することが条件
-- 連想配列はEqであればよかった
phoneBook :: Map.Map String String
phoneBook = Map.fromList $
    [("a", "0120-333-906")
    ,("b", "0120-333-906-1")
    ,("c", "0120-333-906-2")
    ,("d", "0120-333-906-3")
    ]
-- Map.lookup "b" phoneBook でキーから検索できる
-- キーは順序集合なので、より効率よく検索ができる

-- insert関数で新しくデータの登録ができ、挿入した新しいMapを返す
-- let newBook = Map.insert "e" "0120-333-906-4" phoneBook

toDigit' :: Char -> Int
toDigit' a = ord a - 48

isDigit' :: Char -> Bool
isDigit' a = toDigit' a >= 0 && toDigit' a <= 9

-- "0120-111-111" -> [0,1,2,0,1,1,1,1,1,1]
string2digit :: String -> [Int]
string2digit = map toDigit' . filter isDigit'