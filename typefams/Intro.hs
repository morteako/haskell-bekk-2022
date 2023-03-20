{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

import Data.Type.Equality

-- lukkede / closed type families
-- jobbe med GADTs

type family PairType a where
    PairType String = [String]
    PairType Int = Bool

makePair :: a -> PairType a -> (a, PairType a)
makePair a b = (a, b)

ex1 = makePair (1 :: Int)

ex2 = makePair "(1::Int)"

-- gadt-eksempel

-- .
-- Ish praktisk eksempel
-- .
-- .
-- .
-- .
-- .
-- .
-- .
-- .
-- .
-- .

data S = SStart | SPause | SReStart | SStop

data StopClock s where
    Start :: StopClock SStart
    Pause :: StopClock SPause
    ReStart :: StopClock SReStart
    Stop :: StopClock SStop

type family ValidNext s where

type family Elem a xs where

next :: IO ()
next = undefined

-- OPPGAVE 1
-- Legg til Lap til Stopclock (og SLap S). Hva skal være gyldig neste states? Fiks ValidNext og next

-- OPPGAVE 2
-- Lag en listedatatype som lar deg bygge opp lister med gyldige stopclock-commands

-- Gyldige :
-- c = ClockCons Start ListStop
-- c' = ClockCons Start $ ClockCons Pause ListStop
-- Ugyldige:
-- c'' = ClockCons Start $ ClockCons Pause $ ClockCons Pause ListStop
