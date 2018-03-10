# Parsing and Hypergraphs
## Overview

After reading the paper, I decided to simplify the algorithm for the assignment. The program doesn't have a chart, so it's technically not a chart parser, but I'm pretty sure it does what it's supposed to. There are also no scores for the edges, because to keep the parser simple and because results of an exhaustive parser can be scored afterwards to get the same results as scoring beforehand.

In the example result, you get all possible complete applications of the given production rules, not only the most likely.

The following will be an explanation for the modules.

## Types

The following is a definition all of the types.

* Span and Category are defined just like in the paper. The parser uses a few categories which fit the example sentence.

* ProductionRules are the rules of the context-free grammar.

* PassiveEdges are just like in the paper, plus the word how it appears in the sentence.

* ActiveEdges are just like in the paper, plus the edges which are affected by the grammar rule.

* I needed a Tagger to tag the words in the sentence with the categories

## PosTagger

It's a simple POS Tagger which tags the sample sentence with the correct POS tags. It is easily replaceable by an actual POS Tagger, if you want to parse actual input.

## ActiveRules

 First we define the grammar rules we use in our example.

 The applyRule function replaces edges with fewer edges, according to the grammar rules. For example, if there is a PassiveEdge NP and a PassiveEdge VP, and the rule S->NP VP we can replace both of the PassiveEdges with a new ActiveEdge. Together, they form a traversal.

 ## Parser

 Takes a lattice (sentence) and the ParserConfig and uses the function applyRule recursively, until there is a solution.

 ## Example

 My example sentence is "Donald beobachtet Daisy mit dem Fernglas". The two interpretations depend on whether Donald or Daisy use the binoculars.
```
S->[S,PP]:[0,36]:(
  S->[NP,VP]:[0,22]:(
    NP:[0,6]:"Donald"
    VP->[V,NP]:[6,22]:(
      V:[6,17]:"beoabachtet"
      NP:[17,22]:"Daisy"
    )
  )
  PP->[P,NP]:[22,36]:(
    P:[22,25]:"mit"
    NP->[Art,N]:[25,36]:(
      Art:[25,28]:"dem"
      N:[28,36]:"Fernglas"
    )
  )
)
S->[NP,VP]:[0,36]:(
  NP:[0,6]:"Donald"
  VP->[V,NP]:[6,36]:(
    V:[6,17]:"beoabachtet"
    NP->[NP,PP]:[17,36]:(
      NP:[17,22]:"Daisy"
      PP->[P,NP]:[22,36]:(
        P:[22,25]:"mit"
        NP->[Art,N]:[25,36]:(
          Art:[25,28]:"dem"
          N:[28,36]:"Fernglas"
        )
      )
    )
  )
)
```

Here we can see the two interpretations. The first has the traversal where Donald is using the binoculars and the second is where Daisy uses them.
