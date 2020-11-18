--コーヒーカップモデル
cup flOz = \message -> message flOz
-- aCup = cup 6

getOz aCup = aCup (\flOz -> flOz)

drink aCup ozDrank = cup (flOz - ozDrank)
  where flOz = getOz aCup