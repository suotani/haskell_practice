import System.Environment
import Data.List

main = do
  --コマンドライン引数を受け取る
  args <- getArgs
  --プログラムの名前を受け取る
  progName <- getProgName
  putStrLn "The arguments are:"
  mapM_ putStrLn args
  putStrLn "The Program name is:"
  putStrLn progName