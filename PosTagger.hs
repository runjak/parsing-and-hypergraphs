module PosTagger where

import Types

tag :: String -> [Category]
tag = map tag' . words
    where
        tag' :: String -> Category
        tag' "Donald"      = NP
        tag' "beoabachtet" = V
        tag' "Daisy"       = NP
        tag' "mit"         = P
        tag' "dem"         = Art
        tag' "Fernglas"    = N
        tag' _             = Unknown

spanify :: String -> [Span]
spanify = go 0 . words
    where
        go :: Int -> [String] -> [Span]
        go i (w:ws) =
            let l = length w
                i' = i + l
            in (i, i') : go i' ws
        go _ [] = []

combinedTagger :: String -> [Edge] -- so edgy
combinedTagger sentence = zipWith PassiveEdge (tag sentence) (spanify sentence)
