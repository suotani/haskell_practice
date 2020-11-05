import System.Environment
import System.Directory
import System.IO 
import Control.Exception
-- 遅延バージョンのbyteStringを使う
-- ByteStringはリストを8バイト文字のstringへ置き換える
-- chunkという単位(64バイト)で処理するため、リストよりも少しオーバーヘッドが少ない
-- まずは通常の文字列で実装してみて、パフォーマンスに問題があるなら、byteStringを使うと良い
import qualified Data.ByteString.Lazy as B


main = do
  (fileName1:fileName2:_) <- getArgs
  copy fileName1 fileName2

copy source dest = do
  contents <- B.readFile source
  bracketOnError
    (openTempFile "." "temp")
    (\(tempName, tempHandle) -> do
      hClose tempHandle
      removeFile tempName
    )
    (\(tempName, tempHandle) -> do
      B.hPutStr tempHandle contents
      hClose tempHandle
      renameFile tempName dest
    )