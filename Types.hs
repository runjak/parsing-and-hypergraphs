module Types where

type Span = (Int, Int)

data Category = NP | V | N | P | Art | Unknown | PP | S
    deriving (Show, Eq, Ord)

type ProductionRule = (Category,[Category])

data Edge = PassiveEdge Category Span
          | ActiveEdge ProductionRule Span
          deriving(Show, Eq, Ord)
