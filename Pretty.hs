module Pretty where


import Types

pad = unlines . map ("  " ++) . lines

prettify :: Edge -> String
prettify (PassiveEdge c s w) = show c ++ ":" ++ "[" ++
                               show (fst s)  ++ "," ++
                               show (snd s)  ++ "]" ++ ":" ++
                               show w

prettify (ActiveEdge (ruleHead, ruleBody) s t) =
    let prettyTraversal = pad $ unlines $ map prettify t
    in show ruleHead ++ "->" ++ show ruleBody ++ ":" ++ "[" ++
       show (fst s)  ++ "," ++
       show (snd s)  ++ "]" ++ ":" ++ "(\n" ++ prettyTraversal ++ ")"
