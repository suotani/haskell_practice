-- フォルダで名前空間を作ることができる
module Geometry.Sphere
( volume
, area
) where

--rubyなどと同じく、名前空間を作ることで一般的な名称を関数につけることができる
volume :: Float -> Float
volume radius = (4.0/3.0) * pi * (radius ^ 3)

area :: Float -> Float
area radius = 4 * pi * (radius ^ 2)