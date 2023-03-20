{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

import Data.ByteString as ByteString
import Data.ByteString.Char8 (unpack)
import Data.Kind (Type)
import Data.Word

-- sett på lukkede type families

-- nå se på åpne

class Container c where
    type Elem c
    toList :: c -> [Elem c]

instance Container [a] where
    type Elem [a] = a
    toList :: [a] -> [a]
    toList = id

instance Container (Maybe a) where
    type Elem (Maybe a) = a
    toList m = case m of
        Just x -> [x]
        Nothing -> []

instance Container ByteString where
    type Elem ByteString = Word8
    toList = ByteString.unpack

instance Container (a, a) where
    type Elem (a, a) = a
    toList (a, b) = [a, b]

-- felles oppgave
-- Legg til (a, a)

class Container c => IndexedContainer c where
    type Index c
    type Res c
    getIndex :: Index c -> c -> Res c

instance IndexedContainer [a] where
    type Index [a] = Int
    type Res [a] = Maybe a
    getIndex i xs = Just (xs !! i)

instance IndexedContainer (a, a) where
    type Index (a, a) = Bool
    type Res (a, a) = a
    getIndex b (x, y) = (if b then y else x)

appendq :: (Container c1, Container c2, Elem c1 ~ Elem c2) => c1 -> c2 -> [Elem c1]
appendq c1 c2 = toList c1 ++ toList c2

xs :: [Integer]
xs = appendq [1, 2, 3] (2 :: Integer, 2 :: Integer)

-- typer til typer
-- hva med typer til verdier?
-- Det gir mest mening med singleton-typer
-- Singleton-typer er typer med kun en verdi
-- Altså typen bestemmer verdien
-- Verdien bestemmer typer
-- En til en mapping

-- data Singleton = Singleton

-- data AB = A | B

-- data D s where
--     AA :: D A
--     BB :: D B

data Nat = Z | S Nat

data SNat s where
    SZ :: SNat Z
    SS :: SNat n -> SNat (S n)

deriving instance Show (SNat Z)
deriving instance Show (SNat n) => Show (SNat (S n))

class FromNat (s :: Nat) where
    toSNat :: SNat s

instance FromNat Z where
    toSNat = SZ

instance FromNat n => FromNat (S n) where
    toSNat = SS toSNat

-- ghci > toDNat @Z
-- DZ
-- ghci > toDNat @(S (S Z))
-- DS (DS DZ)