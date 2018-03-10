module Main where

import Control.Monad
import Types
import PosTagger (combinedTagger)
import ActiveRules
import Parser
import Pretty

sampleSentence :: String
sampleSentence = "Donald beoabachtet Daisy mit dem Fernglas"

main = mapM_ (putStrLn . prettify) $ parse defaultParserConfig sampleSentence
