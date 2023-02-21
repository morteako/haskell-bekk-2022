{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE LambdaCase #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

-- skriv om disse datatypene til GADT syntax
data Result e a = Err e | Ok a

data Info a = Good {id :: Int, info :: a} | Bad {id :: Int, info :: a, errorMsg :: String}

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
setValue = undefined

-- Exp

data GExp a where
    Var :: String -> GExp Int
    Lit :: Int -> GExp Int
    BoolLit :: Bool -> GExp Bool
    BoolVar :: String -> GExp Bool
    Add :: GExp Int -> GExp Int -> GExp Int
    If :: GExp Bool -> GExp Int -> GExp Int -> GExp Int

-- skriv en eval-funksjon for GExp
eval :: (String -> Int) -> (String -> Bool) -> GExp a -> a
eval getIntVarValue getBoolVarValue = undefined

-- skrive en optimize funksjon for GEXp
-- optimaliseringer:
-- If True t f -> t
-- If False t f -> f
-- Add (Lit a) (Lit b) -> Lit (a+b)
-- husk å optimize alle sub-exps
optimize :: GExp a -> GExp a
optimize = undefined

-- hvordan garantere at det at alle nodene er optimized? sånn ish
