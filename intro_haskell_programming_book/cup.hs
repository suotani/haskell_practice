--コーヒーカップモデル
cup flOz = \message -> message flOz
-- aCup = cup 6

getOz aCup = aCup (\flOz -> flOz)

drink aCup ozDrank = cup $ max 0 (flOz - ozDrank)
  where flOz = getOz aCup

-- *Main> coffee = cup 5
-- *Main> coffee' = drink coffee 2
-- *Main> getOz coffee'
-- 3
-- *Main> coffee'' = drink coffee 9
-- *Main> getOz coffee''
-- 0