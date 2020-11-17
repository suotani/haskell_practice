{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP.Simple

main :: IO ()
main = do
  res <- httpLBS "https://httpbin.org/ip"
  print (getResponseBody res)
