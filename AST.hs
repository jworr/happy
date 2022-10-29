module AST
(
   Exp(..),
   Exp1(..),
   Term(..),
   Factor(..)
)
where

{-
Either a "let" setting a var (String) to the result of an Exp and
use it in the second Exp

Or it can be an Exp1, a calculation
-}
data Exp  
      = Let String Exp Exp
      | Exp1 Exp1
      deriving Show

{-
Addition or subtraction, or a term, the result of either
multiplication or division
-}
data Exp1 
      = Plus Exp1 Term 
      | Minus Exp1 Term 
      | Term Term
      deriving Show

{-
Multiplication or division, or a factor (int lit or variable)
-}
data Term 
      = Times Term Factor 
      | Div Term Factor 
      | Factor Factor
      deriving Show

{-
Integer literal, variable, or a bracketed expression
-}
data Factor 
      = Int Int 
      | Var String 
      | Brack Exp
      deriving Show
