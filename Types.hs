module Types where

    type Span = (Int, Int)

    data Category = NP | V | N | P | Art | Unknown
        deriving (Show, Eq, Ord)
