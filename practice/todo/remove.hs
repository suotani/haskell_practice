import System.IO
import System.Directory
import Data.List
-- bracketOnErrorを使うため
import Control.Exception

main = do
  contents <- readFile "todo.txt"
  let todoTasks = lines contents
      numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
  putStrLn "These are your TO-DO items:"
  mapM putStrLn numberedTasks
  putStrLn "Which one do you want to delete?"
  numberString <- getLine
  let number = read numberString
      newTodoItems = unlines $ delete (todoTasks !! number) todoTasks
  --bracketOnErrorは何かエラーが発生した時に、リソースを開放する
  -- bracketOnError ハンドラー -> エラー発生時の処理 -> 通常時の処理 -> IO
  bracketOnError (openTempFile "." "temp")
    (\(tempName, tempHandle) -> do
      hClose tempHandle
      removeFile tempName
    )
    
    (\(tempName, tempHandle) -> do
      hPutStr tempHandle newTodoItems
      hClose tempHandle
      removeFile "todo.txt"
      renameFile tempName "todo.txt"
    )
