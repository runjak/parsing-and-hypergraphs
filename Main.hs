module Main where

main = putStrLn "TEST"

sampleSentence :: String
sampleSentence = "Donald beoabachtet Daisy mit dem Fernglas"

type Span = (Int, Int)

data Category = NP | V | N | P | Art | Unknown
  deriving (Show, Eq, Ord)

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

combinedTagger :: String -> [(Category, Span)]
combinedTagger sentence = zip (tag sentence) (spanify sentence)
