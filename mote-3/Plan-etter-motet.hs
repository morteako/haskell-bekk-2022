{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE RankNTypes #-}

import qualified Data.Map as Map
import qualified Data.Set as Set
import Prelude hiding (Foldable, Monoid)

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
intJust = IntContainer (Just 1)

-- siden Maybe har kind * -> *, så passer i IntContainer

--[Int]
--[] Int
intList :: IntContainer []
intList = IntContainer [1]

-- * -> *

-- siden List har kind * -> *, så den passer også inn i IntContainer

--FUNKER IKKE
-- q = IntContainer 1 :: IntContainer Int
-- siden Int har kind *, altså ikke en typekonstruktør med 1 argument, så passer den ikke inn og dette fungerer ikke
-- Vi prøver jo da på - IntContainer (Int Int)

data M f = M (f Maybe)

-- hva blir kinden?
-- hva kan vi putte inn for f?
qq = M (IntContainer $ Just 5)

-- Type classes
class Summable (f :: * -> *) where
    sumInts :: f Int -> Int

instance Summable Maybe where
    sumInts :: Maybe Int -> Int
    sumInts Nothing = 0
    sumInts (Just x) = x

instance Summable [] where
    sumInts [] = 0
    sumInts (x : xs) = x + sumInts xs

instance Summable (Either a) where
    sumInts (Left _) = 0
    sumInts (Right x) = x

instance Summable ((,) a) where
    sumInts (_, b) = b

-- lage for List, Either , (,) a osv

-- Foldable

sumList :: [Int] -> Int
sumList [] = 0
sumList (x : xs) = x + sumList xs

productList :: [Int] -> Int
productList [] = 1
productList (x : xs) = x * productList xs

concatList :: [[a]] -> [a]
concatList [] = []
concatList (x : xs) = x ++ concatList xs

-- Hva er felles her?
-- Lage en generell funksjon
foldrList :: (a -> b -> b) -> b -> [a] -> b
foldrList f v [] = v
foldrList f v (x : xs) = f x (foldrList f v xs)

sumList' :: [Int] -> Int
sumList' = foldrList (+) 0

productList' :: [Int] -> Int
productList' = foldrList (*) 1

concatList' :: [[a]] -> [a]
concatList' = foldrList (++) []

-- IKKE : a <> b == b <> a

-- a <> (b <> c) = (a <> b) <> c

-- a <> e = a = e <> a
-- (+) e : 0
-- (*) e : 1
-- (++) e : []
-- max e : MIN_VALUE

-- Kan vi gjøre det samme for Maybe?

foldrMaybe :: (a -> b -> b) -> b -> Maybe a -> b
foldrMaybe f v Nothing = v
foldrMaybe f v (Just x) = f x v

--
class Foldable (f :: * -> *) where
    foldr :: (a -> b -> b) -> b -> f a -> b

    fold :: Monoid a => f a -> a
    fold = Main.foldr (Main.<>) Main.mempty

    foldMap :: Monoid m => (a -> m) -> f a -> m
    foldMap func = Main.foldr (\x xs -> func x Main.<> xs) Main.mempty

-- fold = undefined

instance Foldable Maybe where
    foldr = foldrMaybe

instance Foldable [] where
    foldr = foldrList

-- Ser vi noen fellestrekk for alle måtene vi brukte foldr på?
-- Hadde det ikke vært kjekt om typene kunne bestemt kombineringsfunksjonen og startelementet?
-- Legge til fold til Foldable

-- Trenger å vite noe om verdiene
-- Kombineringsfunksjon
-- identetselement
-- Monoids!

class Monoid (a :: *) where
    mempty :: a
    (<>) :: a -> a -> a

instance Monoid [x] where
    mempty = []
    (<>) = (++)

-- assosiativt
-- identitetselement
-- aggregering
-- paralell

-- data Ordering = LT | EQ | GT

instance Monoid Ordering where
    mempty = EQ
    LT <> _ = LT
    GT <> _ = GT
    EQ <> o = o

-- Ordering
-- [a]
--

-- Hva gjør vi med typer som kan forme forskjellige Monoids? feks
-- tall: (+) 0, (*) 1, min MAX_VALUE, max MIN_VALUE, osv
-- booleans : (&&) True, (||) False, xor False
-- newtypes!

newtype Sum a = Sum a

instance Num a => Monoid (Sum a) where
    mempty = Sum 0
    (<>) (Sum a) (Sum b) = Sum (a + b)

-- Set, Map

s1 = Set.fromList [1 .. 5]
s2 = Set.fromList [3 .. 7]

m1 = Map.fromList [(0, "hei"), (1, "hopp")]
m2 = Map.fromList [(1, "kopp"), (2, "hallo")]

data NonEmpty a = NonEmpty a [a]

class Semigroup2 a where
    (<<>) :: a -> a -> a

class Semigroup a => Monoid2 a where
    mmempty :: a -> a -> a

instance Semigroup a => Semigroup (Maybe a) where
    Nothing <> a = a
    a <> Nothing = a
    Just a <> Just b = a Prelude.<> b

instance Semigroup a => Monoid (Maybe a) where
    mempty = Nothing

instance (Semigroup a, Semigroup b) => Semigroup (a, b) where
    (a, b) <> (a', b') = (a <> a', b <> b')

-- IKKE MONOIDS?
-- (-)

-- Kombinere monoids
-- (a,b)

-- foldMap . Legge til

-- skrive foldMap med foldr

-- Kun (<>)?
-- F.eks. non-empty list
-- First, Last
-- Maybe