module ActiveRules where

import qualified Data.List as List
import Control.Monad
import Types

activeRules :: [ProductionRule]
activeRules = [(S,[NP,VP])
            , (S,[S,PP])
            , (VP,[V,NP])
            , (NP,[NP,PP])
            , (NP,[Art,N])
            , (PP,[P,NP])]

getCategory :: Edge -> Category
getCategory (PassiveEdge c _)      = c
getCategory (ActiveEdge (c,_) _ _) = c

getSpan :: Edge -> Span
getSpan (PassiveEdge _ s)   = s
getSpan (ActiveEdge  _ s _) = s

combineSpans :: [Edge] -> Maybe Span
combineSpans [] = Nothing
combineSpans edges = let headSpan = getSpan $ head edges
                         lastSpan = getSpan $ last edges
                     in Just (fst headSpan, snd lastSpan)

{-applyRule :: ProductionRule -> [Edge] -> [[Edge]]
applyRule (ruleHead,ruleBody) edges = do
    (prefix, suffix) <- zip (List.inits edges) (List.tails edges)
    let suffixCategories = map getCategory suffix
    guard $ List.isPrefixOf ruleBody suffixCategories

applyRule _ [] = []-}
