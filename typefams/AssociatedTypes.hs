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

class Container c

-- felles oppgave
-- legg til Maybe
-- Legg til (Pair a a)

-- class Container c => IContainer c where

-- append Elem c1 ~Elem c2 ??

-- typer til typer
-- hva med typer til verdier?
-- Det gir mest mening med singleton-typer
-- Singleton-typer er typer med kun en verdi
-- Altså typen bestemmer verdien
-- Verdien bestemmer typer
-- En til en mapping

data Nat = Z | S Nat

-- data DNat s where

class FromNat s

-- ghci > toDNat @Z
-- DZ
-- ghci > toDNat @(S (S Z))
-- DS (DS DZ)