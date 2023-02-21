{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE LambdaCase #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

-- skriv om disse datatypene til GADT syntax
data Result e a = Err e | Ok a

data Info a where
    Good :: {id :: Int, info :: a} -> Info a
    Bad :: {id :: Int, info :: a, errorMsg :: String} -> Info a

--
data IntOrString a where
    MyInt :: Int -> IntOrString Int
    MyString :: String -> IntOrString String

-- implementer funksjonene
incNumber :: IntOrString Int -> IntOrString Int
incNumber = undefined

reverseString :: IntOrString String -> IntOrString String
reverseString = undefined

setValue :: IntOrString a -> a -> IntOrString a
setValue (MyInt _) i = MyInt i
setValue (MyString _) i = MyString i

-- Exp

data GExp b a where
    Var :: String -> GExp True Int
    Lit :: Int -> GExp True Int
    BoolLit :: Bool -> GExp True Bool
    BoolVar :: String -> GExp True Bool
    Add :: GExp b Int -> GExp b Int -> GExp b Int
    If :: GExp b Bool -> GExp b Int -> GExp b Int -> GExp b Int

-- skriv en eval-funksjon for GExp
-- eval :: (String -> Int) -> (String -> Bool) -> GExp a -> a
-- eval getIntVarValue getBoolVarValue = undefined

-- skrive en optimize funksjon for GEXp
-- optimaliseringer:
-- If True t f -> t
-- If False t f -> f
-- Add (Lit a) (Lit b) -> Lit (a+b)
-- husk å optimize alle sub-exps
optimize :: GExp False a -> GExp True a
optimize (If (BoolLit True) t f) = optimize t
optimize (If (BoolLit False) t f) = optimize f
optimize (Add a b) = case (optimize a, optimize b) of
    (Lit a, Lit b) -> Lit $ a + b
    (a, b) -> Add a b
optimize a = undefined a

-- hvordan garantere at det at alle nodene er optimized? sånn ish
