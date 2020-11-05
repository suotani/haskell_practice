import Control.Monad
import Data.Char
import System.IO

-- inout2 < haiku.txt として実行
-- main = forever $ do
--   l <- getLine
--   putStrLn $ map toUpper l

--getLineの代わりに、getContentsを使うと、遅延評価してくれて、一気に全てのテキストをメモリ上に展開しない
-- main = forever $ do
--   contents <- getContents
--   putStrLn $ map toUpper contents

-- 入力を受け取り、何か関数で変換し、結果を出力するというパターンはよく出てくるので
-- 専用の関数がある: interactは String -> String型の関数を受け取り、
-- 入力を関数で変換して出力するという一連のIOアクションを返す


-- main  = interact shortLinesOnly

-- shortLinesOnly :: String -> String
-- shortLinesOnly = unlines . filter (\line -> length line < 10) . lines

--lines : 改行毎に分割してStringのリストへ、
--unlines : Stringのリストを改行で結合

-- main = do
--   -- openFile :: FilePath -> IOMode -> IO Handle
--   handle <- openFile "haiku.txt" ReadMode
--   contents <- hGetContents handle
--   putStr contents
--   hClose handle

--これら一連の操作をまとめたwithFileという関数がある
-- withFile :: FilePath -> IOMode -> (Handle -> IO a) -> IO a
--withFileは勝手にファイルをcloseしてくれる
-- main = do
--   withFile "haiku.txt" ReadMode $ \handle -> do
--     contents <- hGetContents handle
--     putStr contents

--さらに、読み専用(readFile)、書き込み専用(writeFile)、追記専用(appendFile)などのモード固定の関数もある
-- main = do
--   contents <- readFile "haiku.txt"
--   putStr contents
--   -- writeFile :: FilePath -> String -> IO()
--   writeFile "haiku2.txt" (map toUpper contents)



