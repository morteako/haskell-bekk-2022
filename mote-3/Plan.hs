{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE RankNTypes #-}

import qualified Data.Map as Map
import qualified Data.Set as Set
import Prelude hiding (Foldable, Monoid, Semigroup)

type TODO = forall a. a

-- Slides

-- Verdier har en type
-- "Hei" har typen String
-- True har typen Bool

-- Men hva med Maybe? List?
-- Ingen verdier som har typen Maybe eller List
-- Når man gir Maybe og List typer som argumenter, feks Maybe Int og List Bool, da kan de ha verdier
-- Maybe og List er typekonstruktører

-- Disse kan klassifiser ved hjelp av kinds, et typesystem for typer
-- Higher kinded types ~ higher order functions

data IntContainer (f :: * -> *) = IntContainer (f Int)

-- hva blir kinden til IntContainer?

intJust :: IntContainer Maybe
intJust = IntContainer (Just 1) :: IntContainer Maybe

-- siden Maybe har kind * -> *, så passer i IntContainer

intList :: IntContainer []
intList = IntContainer [1] :: IntContainer []

-- siden List har kind * -> *, så den passer også inn i IntContainer

--FUNKER IKKE
-- IntContainer 1 :: IntContainer 1
-- siden Int har kind *, altså ikke en typekonstruktør med 1 argument, så passer den ikke inn og dette fungerer ikke
-- Vi prøver jo da på - IntContainer (Int Int)

data M f = M (f Maybe)

-- hva blir kinden?
-- hva kan vi putte inn for f?

-- Type classes
class Summable (f :: * -> *) where
    sumInts :: f Int -> Int

instance Summable Maybe where
    sumInts :: Maybe Int -> Int
    sumInts = undefined

-- lage for List, Either , (,) a osv

-- Foldable

sumList :: [Int] -> Int
sumList [] = undefined
sumList (x : xs) = undefined

productList :: [Int] -> Int
productList [] = undefined
productList (x : xs) = undefined

concatList :: [[a]] -> [a]
concatList [] = undefined
concatList (x : xs) = undefined

-- Hva er felles her?
-- Lage en generell funksjon
foldrList :: a
foldrList = undefined

sumList' :: [Int] -> Int
sumList' = foldrList undefined

productList' :: [Int] -> Int
productList' = foldrList undefined

concatList' :: [[a]] -> [a]
concatList' = foldrList undefined

-- Kan vi gjøre det samme for Maybe?

--
class Foldable f where
    foldr :: TODO

-- Ser vi noen fellestrekk for alle måtene vi brukte foldr på?
-- Hadde det ikke vært kjekt om typene kunne bestemt kombineringsfunksjonen og startelementet?
-- Legge til fold til Foldable

fold :: TODO
fold = undefined

-- Trenger å vite noe om verdiene
-- Kombineringsfunksjon
-- element
-- Monoids!

-- assosiativt
-- identitetselement
-- aggregering
-- paralell

-- Ordering
-- [a]
--

-- Hva gjør vi med typer som kan forme forskjellige Monoids? feks
-- tall: (+) 0, (*) 1, min MAX_VALUE, max MIN_VALUE, osv
-- booleans : (&&) True, (||) False, xor False
-- newtypes!

-- Set, Map

-- IKKE MONOIDS?
-- (-)

-- Kombinere monoids
-- (a,b)
-- Maybe

-- foldMap . Legge til

-- skrive foldMap med foldr

-- Kun (<>)?
-- F.eks. non-empty list
-- First, Last
-- Maybe