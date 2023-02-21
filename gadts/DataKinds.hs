{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE LambdaCase #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

data Nat = Z | S Nat

type T0 = Z
type T1 = S Z
type T2 = S T1

type Add2 n = S (S n)

type MyB = False

data Proxy a = Proxy

data FinList a (n :: Nat) where
    FNil :: FinList a (S n)
    FCons :: a -> FinList a n -> FinList a (S n)

f :: FinList a T2 -> String
f FNil = "0"
f (FCons a FNil) = "1"
f (FCons a (FCons b fs)) = "2"

data HList xs where
    HNil :: HList '[]
    HCons :: a -> HList xs -> HList (a : xs)

hl = HCons 1 HNil

swap :: HList (a : b : xs) -> HList (b : a : xs)
swap (HCons a (HCons b xs)) = HCons b $ HCons a xs

data Elem a xs where
    FirstElem :: Elem a (a : xs)
    RestElem :: Elem a xs -> Elem a (b : xs)

elem1 :: Elem Int '[Int]
elem1 = FirstElem

elem2 :: Elem Bool '[Int, String, Bool]
elem2 = RestElem $ RestElem FirstElem

getVal :: Elem a xs -> HList xs -> a
getVal FirstElem (HCons a _) = a
getVal (RestElem r) (HCons _ xs) = getVal r xs

-------------------------------------
-- tillater typed type level programming
-- forskjell

data Info a = Unvalidated Int | Invalid Int | Valid Int

dummy1 :: Info String -> Info String
dummy1 xs = xs

data ValidationState = SValid | SInvalid | SUnvalidated

-- kan faktisk bruke (a :: Int -> Info Int)
data GInfo a where
    GUnvalidated :: Int -> GInfo SUnvalidated
    GInvalid :: Int -> GInfo SInvalid
    GValid :: Int -> GInfo SValid

-- gir nå feil
-- dummy2 :: GInfo String -> Info String
-- dummy2 xs = xs

-- andre bonuser :
-- pattern matching
-- slipper smart-konstruktører
-- trenger ikke egen modul osv

-- kan også bruke kinds osv uten GADTs

data Info' (a :: ValidationState) = Unvalidated' Int | Invalid' Int | Valid' Int
