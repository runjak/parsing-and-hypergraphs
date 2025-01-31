module Types where

type Span = (Int, Int)

data Category = NP | V | N | P | Art | Unknown | PP | S | VP
    deriving (Show, Eq, Ord)

type ProductionRule = (Category,[Category])

data Edge = PassiveEdge Category Span String
          | ActiveEdge ProductionRule Span [Edge]
          deriving(Show, Eq, Ord)

type Tagger = String -> [Edge]

data ParserConfig = ParserConfig Tagger [ProductionRule]

type Parser = ParserConfig -> String -> [Edge]
