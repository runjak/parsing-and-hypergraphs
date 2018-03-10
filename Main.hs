module Main where

import Control.Monad
import Types
import PosTagger (combinedTagger)
import ActiveRules
import Parser

sampleSentence :: String
sampleSentence = "Donald beoabachtet Daisy mit dem Fernglas"

main = mapM_ print $ parse defaultParserConfig sampleSentence
