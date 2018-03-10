module ActiveRules where

import Types

activeRules :: [ProductionRule]
activeRules = [(S,[NP,VP])
            , (S,[S,PP])
            , (VP,[V,NP])
            , (NP,[NP,PP])
            , (NP,[Art,N])
            , (PP,[P,NP])]
