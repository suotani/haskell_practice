
-- qualified: モジュール名の記述が必須: Map.sortみたいに
import qualified Data.Map as Map

--dataキーワードを使うと、新しいデータ型を定義できる
-- data Bool = False | True

--値コンストラクタを使うことで、引数ありの型を作ることができる
-- data Shape = Circle Float Float Float | Rectangle Float Float Float Float
--     deriving (Show)

--deriving (Show)をつけることで、Show型クラスのインスタンスにできる

--値コンストラクタの定義の中から別の値コンストラクタを呼び出すこともできる
-- 値コンストラクタが一つしかない場合は、型と値コンストラクタは同名にする場合が多い
data Point = Point Float Float deriving (Show)
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)

--値コンストラクタであるCircleとRectangleの正体はただの関数で、
--Circleなら３つのFloat型フィールを引数として渡すとShape型の値が帰ってくる
-- Circle :: Float -> Float -> Float -> Shape
--前２つの引数は座標で、３つ目が半径
-- area :: Shape -> Float
-- area (Circle _ r) = pi * r ^ 2
-- area (Rectangle x1 y1 x2 y2) = abs $ (x2 - x1) * (y2 - y1)

--値コンストラクはただの関数なので、mapなどと組み合わせることができる
-- map (\x -> area $ Circle 1 1 x) [4,5,6,7]


area' :: Shape -> Float
area' (Circle _ r) = pi * r ^ 2
area' (Rectangle (Point x1 y1) (Point x2 y2)) = abs $ (x2 - x1) * (y2 - y1)

--自作の型をエクスポートするときは次のようにする
-- module Shapes
-- ( Point(..)
-- , Shape(..)
-- ) where
--Point(..)とする事で、全ての値コンストラクタをエクスポートする


-- 複雑な値コンストラクタはレコード構文を使って分かりやすく作ることができる
data Person = Person { firstName :: String
                     , lastName :: String
                     , age :: Int
                     , height :: Float
                     , phoneNumber :: String
                     , flavor :: String } deriving (Show)
--このようにすると、それぞれのフィールドに対するゲッター関数が自動的に作られる
-- firstName :: Person -> String
-- height :: Person -> Float
-- let person = Person {firstName = "name", lastName = "name2"...}全ての値を埋める必要がある
-- person' = person {age = 50} で更新ができる

--型引数を撮るものは型コンストラクタと呼ばれる
-- data Maybe a = Nothing | Just a
-- この場合aが型引数
--型コンストラクタMaybe aからMaybe IntやMaybe Stringなどの型を作ることができる
--Maybeの他に、リストも [Int]や[String]という型コンストラクタになっている

--haskellでもクラスを作ることができるが、オブジェクト指向のそれとは少し異なる
-- クラスは、データを作る道具ではなく、「データ型とデータがにできることを考える」
-- クラスをある型クラスのインスタンスにしたいとき、自動でインスタンス宣言を導出(derive)できるものがある
-- Eq, Ord, Enum, Bounded, Show, Read
-- ただしEq型クラスのインスタンスにするときは、フィールドや引数が全てEqのインスタンスになっている必要がある
-- もちろん他の型クラスも同様
-- 複数の型クラスのインスタンスにする場合は deriving (Eq, Show, Read)とする
-- Read型クラスのインスタンスにし、read関数で読み取らせる場合には
-- read mike :: Person
--のように型指定をする 

--列挙型を作るには、EnumとBoundedがおすすめ
data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
    deriving (Eq, Ord, Show, Read, Bounded, Enum)

-- *Main> minBound :: Day
-- Monday

-- *Main> succ Thursday
-- Friday

-- *Main> [Tuesday .. Friday]
-- [Tuesday,Wednesday,Thursday,Friday]

-- typeキーワードを使うと、型の別名(型シノニム:同義語)を作ることができる
-- type String = [Char]

-- type PhoneNumber = String
-- type Name = String
-- type PhoneBook = [(Name, PhoneNumber)]
-- これを使うと
-- inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Book
--のように分かりやすく定義できる

-- Maybe aを使うと、成功、失敗を区別できるが、失敗時の情報が少なすぎる時がある
-- そこで、Either a b方を使うと、aが失敗時、bが成功時のように分けて使うことができる
-- data Either a b = Left a | Right b deriving (Eq, Ord, Read, Show)
data LockerState = Taken | Free deriving (Show, Eq)
type Code = String
type LockerMap = Map.Map Int (LockerState, Code)

lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber map = case Map.lookup lockerNumber map of
  Nothing -> Left $ "Locker" ++ show lockerNumber ++ " doesnt exist!"
  Just (state, code) -> if state /= Taken
                          then Right code
                          else Left $ "Locker" ++ show lockerNumber ++ " is already taken!"

-- *Main> let lokers = Map.fromList [(100, (Taken, "ZZZ")), (101, (Free, "AAA"))]
-- *Main> lokers
-- fromList [(100,(Taken,"ZZZ")),(101,(Free,"AAA"))]
-- *Main> lockerLookup 100 lokers
-- Left "Locker100 is already taken!"
-- *Main> lockerLookup 101 lokers
-- Right "AAA"

-- 再帰的な型を作ることもできる
-- 以下はリストの独自定義
-- リストはheadとtailのシンタックスシュガーx:[]なので、次のようにかける
-- Consは:の言い換え
data List a = Empty | Cons a (List a) deriving (Show, Read, Eq, Ord)

-- 二分探索木
data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show)
singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
    | x == a = Node x left right
    | x < a = Node a (treeInsert x left) right
    | x > a = Node a left (treeInsert x right)

treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeElem x (Node a left right)
    | x == a = True
    | x < a  = treeElem x left
    | x > a  = treeElem x right

--これまで、ある型クラスのインスタンスにするには、自動導出(devind)を使ったが、
--使わない場合の実装も可能
-- 交通信号型
data TrafficLight = Red | Yellow | Green
-- Eq aのaがTrafficLightに置き換わる
instance Eq TrafficLight where
  Red == Red = True
  Green == Green = True
  Yellow == Yellow = True
  _ == _ = False

-- /=の方の定義には、実は==が使われているので、実際は==だけ定義すればEqは実装できる
--他にも、Show型クラスのインスタンスにしたい場合は自動導出が使えるが、
--少し違った表示"Red Light!"などを出したければ、同じように手動でインスタンスにする

--型クラス宣言
-- class Num a where
--   ...

--ある型クラスの型変数に別の型クラスのインスタンスであるという制限をかけることができる
-- class (Eq a) => Num a where
--この時、NumはEqのサブクラスという

-- Functor型クラス
-- class Functor f where
--    fmap :: (a -> b) -> f a -> f b
-- fは具体的な型(IntやMaybe a)ではなく、型コンストラクタであることに注意
-- [a] ではなく []になる
-- instance Functor [] where
--    fmap = map

--Functorで写せる型には、[], Maybe , Tree, Either a(部分適用した)などがある

-- instance Functor (Map k) where
--    fmap = map