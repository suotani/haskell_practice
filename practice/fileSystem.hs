import Data.List (break)

type Name = String
type Data = String
type ItemList = [FSItem]

data FSItem = File Name Data | Folder Name ItemList
  deriving (Show)

-- File "sample.rb" "p 'aa'"
-- Folder "ruby" [(File "sample.rb" "p 'aa'"), (File "sample.rb" "p 'aa'")]

-- パンクズ
data FSCrumb = FSCrumb Name ItemList ItemList deriving (Show)
-- (FSCrumb "ruby" [File, File], [File, File, Folder])


-- ジッパー
type FSZipper = (FSItem, [FSCrumb])
-- (File, [FSCrumb, FSCrumb])

-- 補助関数
x ->> f = f x


fsUp :: FSZipper -> FSZipper
fsUp (item, (FSCrumb name ls rs):bs) =
  (Folder name (ls ++ [item] ++ rs), bs)

fsTo :: Name -> FSZipper -> FSZipper
fsTo name (Folder folderName items, bs) =
  let (ls, item:rs) = break (nameIs name) items
  in (item, (FSCrumb folderName ls rs):bs)

-- break :: (a -> Bool) -> [a] -> ([a], [a])
-- break (>4) [2,3,1,6,2,3,4,5,6]
-- ([2,3,1],[6,2,3,4,5,6])

-- nameIs "main.rb" 
nameIs :: Name -> FSItem -> Bool
nameIs name (Folder folderName _) = name == folderName
nameIs name (File fileName _) = name == fileName


fsRename :: Name -> FSZipper -> FSZipper
fsRename newName (Folder name items, bs) = (Folder newName items, bs)
fsRename newName (File name dat, bs) = (File newName dat, bs)

fsNewFile :: FSItem -> FSZipper -> FSZipper
fsNewFile item (Folder folderName items, bs) = 
  (Folder folderName (item:items), bs)

ls :: FSZipper -> [String]
ls (Folder _ items, _) = foldl (\acc x -> getName x:acc) [] items


getName :: FSItem -> String
getName (Folder folderName _) = "[D]" ++ folderName
getName (File name _) = "[F]" ++ name


myDisk :: FSItem
myDisk =
  Folder "/"
    [ File "index.html" "<html></html>"
    , File "style.css" "body{ margin: 0px; }"
    , Folder "playgroud"
        [File "README.md" "# README"
        , Folder "ruby"
            [ File "sample.rb" "p 'aa'"
            , File "main.rb" "puts 'aa'"
            ]
        , Folder "Haskell"
            [ File "sample.hs" "reverse 'aa'"
            ]
        ]
    ]