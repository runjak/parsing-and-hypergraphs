module ActiveRules where

import qualified Data.Maybe as Maybe
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

applyRule :: ProductionRule -> [Edge] -> [[Edge]]
applyRule _ [] = []
applyRule rule@(ruleHead, ruleBody) edges = do
    (prefix, suffix) <- zip (List.inits edges) (List.tails edges)
    let suffixCategories = map getCategory suffix
    guard $ List.isPrefixOf ruleBody suffixCategories
    let (replacedEdges, suffixSuffix) = List.splitAt (length ruleBody) suffix
        newSpan' = combineSpans replacedEdges
    guard $ Maybe.isJust newSpan'
    let newEdge = ActiveEdge rule (Maybe.fromJust newSpan') replacedEdges
    return $ prefix ++ [newEdge] ++ suffixSuffix

testApplyRule = applyRule testRule testEdges
    where
        testRule = activeRules !! 1

        testEdges :: [Edge]
        testEdges = [ PassiveEdge N (0, 4)
                    , PassiveEdge S (5, 6)
                    , PassiveEdge PP (7, 10)
                    , PassiveEdge N (11, 13)
                    , PassiveEdge S (14, 16)
                    , PassiveEdge PP (17, 20)
                    , PassiveEdge N (21, 13)
                    ]
