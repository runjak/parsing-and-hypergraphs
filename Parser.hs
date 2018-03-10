module Parser where

import Control.Monad
import qualified Data.List as List
import Types
import PosTagger (combinedTagger)
import ActiveRules (activeRules, applyRules)

defaultParserConfig :: ParserConfig
defaultParserConfig = ParserConfig combinedTagger activeRules

parse :: Parser
parse (ParserConfig tagger productionRules) sentence = parse' $ tagger sentence
  where
    parse' :: [Edge] -> [Edge]
    parse' edges = do
      nextEdges <- applyRules productionRules edges
      guard $ not $ null nextEdges
      case nextEdges of
        [singleEdge] -> return singleEdge
        moreEdges -> parse' moreEdges
