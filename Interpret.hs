module Interpret (interpret) where

import AST


{- 
Interpret the sentence, return the evaluated result, either
a value or an error message
-}
interpret :: Exp -> String
interpret exp = case evalExp [] exp of
   Right value -> show value
   Left msg    -> "Error: " ++ msg

type VarRef = String

--the result of an expression
type Value = Either String Float

--the context for evaluating an expression
type Context = [(VarRef, Float)]

--set a variable in the context
setVar :: Context -> VarRef -> Float -> Context
setVar context ref val =
   let
      --unset the var if it is there
      clean = filter ((/= ref) . fst) context
   in
      (ref, val) : clean

--evaluate an expression
evalExp :: Context -> Exp -> Value
evalExp context (Let varName varExp toEval) =
   
   case evalExp context varExp of
      Right intVal -> evalExp (setVar context varName intVal) toEval
      Left msg     -> Left msg
      

evalExp context (Exp1 exp) = evalExp1 context exp


--evaluate a sub-expression
evalExp1 :: Context -> Exp1 -> Value
evalExp1 context (Plus exp term) = 
   (+) <$> (evalExp1 context exp) <*> (evalTerm context term)

evalExp1 context (Minus exp term) = 
   (-) <$> (evalExp1 context exp) <*> (evalTerm context term)

evalExp1 context (Term term) = evalTerm context term


--evaluate a term
evalTerm :: Context -> Term -> Value
evalTerm context (Times term fact) =
  (*) <$> (evalTerm context term) <*> (evalFactor context fact)

evalTerm context (Div term fact) =
  (/) <$> (evalTerm context term) <*> (evalFactor context fact)

evalTerm context (Factor fact) = evalFactor context fact


--evalutate a factor
evalFactor :: Context -> Factor -> Value
evalFactor context (Int num)   = Right (fromIntegral num)
evalFactor context (Var name)  = 
   case lookup name context of
     Just num -> Right num
     _        -> Left (name ++ " is not defined")
evalFactor context (Brack exp) = evalExp context exp
