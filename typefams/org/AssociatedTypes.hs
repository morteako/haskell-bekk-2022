{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

import Data.ByteString as ByteString
import Data.ByteString.Char8 (unpack)
import Data.Kind (Type)
import Data.Word

class Container c where
    type Elem c
    elements :: c -> [Elem c]

instance Container [a] where
    type Elem [a] = a
    elements :: [a] -> [a]
    elements = id

instance Container ByteString where
    type Elem ByteString = Word8
    elements :: ByteString -> [Word8]
    elements = ByteString.unpack

-- felles oppgave
-- legg til Maybe
-- Legg til (Pair a a)

instance Container (a, a) where
    type Elem (a, a) = a
    elements :: (a, a) -> [a]
    elements (a, b) = [a, b]

class Container c => IContainer c where
    type Index c
    type Res c
    getIndex :: c -> Index c -> Res c

instance IContainer [a] where
    type Index [a] = Int
    type Res [a] = Maybe a
    getIndex xs i = Just (xs !! i)

instance IContainer (a, a) where
    type Index (a, a) = Bool
    type Res (a, a) = a
    getIndex (a, b) bo = if bo then b else a

-- typer til typer
-- hva med typer til verdier?
-- Det gir mest mening med singleton-typer
-- Singleton-typer er typer med kun en verdi
-- Altså typen bestemmer verdien
-- Verdien bestemmer typer
-- En til en mapping

data Nat = Z | S Nat

data DNat s where
    DZ :: DNat Z
    DS :: DNat n -> DNat (S n)

deriving instance Show (DNat Z)
deriving instance Show (DNat s) => Show (DNat (S s))

class FromNat s where
    toDNat :: DNat s

instance FromNat Z where
    toDNat = DZ

instance FromNat n => FromNat (S n) where
    toDNat = DS toDNat

-- ghci > toDNat @Z
-- DZ
-- ghci > toDNat @(S (S Z))
-- DS (DS DZ)