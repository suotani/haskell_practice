import Data.Char
-- putStrLnはStringを受け取り、受け取った文字を表示するアクションを返す
-- stack -- --make inout とすればビルドされる
-- main = putStrLn "hello world"
-- doは複数のIOアクションをまとめる
-- main = do
--   putStrLn "please input any text"
--   text <- getLine
--   putStrLn $ "input text is [" ++ text ++ "] thanks"

-- main = do
--   putStrLn "input number"
--   numString <- getLine
--   let num = (read numString :: Int) * 5
--   putStrLn $ "input * 5 = " ++ show num 

-- main = do
--   putStrLn "aaa"
--   -- ここは代入だけなので、入力は発生しない
--   let myGetLine = getLine 
--   putStrLn "bbb"
--   -- ここで初めて入力が発生する
--   mytext <- myGetLine
--   putStrLn "ddd"
--   mytext2 <- myGetLine
--   putStrLn $ "ccc" ++ mytext ++ "," ++ mytext2

-- main自体も関数なので、mainのなかでmainを呼ぶことができる

main = do
  putStrLn "input any words"
  line <- getLine
  if null line
    then
      do
        putStrLn "goodby"
        --終了
        return ()
    else
      do
        putStrLn $ upperWords line
        main

upperWords :: String -> String
upperWords = map toUpper

-- <-は箱から純粋な値を取り出す
-- returnは純粋な値を箱に入れる。ちょうど逆の関係。処理を中断するわけでは無い
-- なので 「let a = 」と 「a <- return」は同じ動作をする

-- その他のIOアクション
-- pusStr : putStrLnの改行しないバージョン
-- print : showしてから画面に表示
-- when Control.Monadの関数。ifのelseが無いバージョン
-- sequence IOアクションのリストを順次実行 実行結果はまたリストになる
-- mapM sequence mapの言い換え。リストをIOアクションのリストに変更し、実行
-- forever 無限に繰り返す


