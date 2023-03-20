{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

import Data.Kind
import Data.Type.Equality
import Data.Word
import GHC.TypeError

type family PairType a where
    PairType String = [String]
    PairType Int = Bool

makePair :: a -> PairType a -> (a, PairType a)
makePair a b = (a, b)

ex1 = makePair (1 :: Int)

ex2 = makePair "(1::Int)"

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

data S = SStart | SPause | SReStart | SStop | SLap

data StopClock s where
    Start :: StopClock SStart
    Pause :: StopClock SPause
    ReStart :: StopClock SReStart
    Lap :: StopClock SLap
    Stop :: StopClock SStop

type family ValidNext s where
    ValidNext SStart = '[SPause, SStop, SLap]
    ValidNext SLap = '[SLap, SPause, SStop]
    ValidNext SPause = '[SReStart, SStop]
    ValidNext SReStart = '[SPause, SStop, SLap]
    ValidNext SStop = '[]

type family Elem a xs where
    Elem _ '[] = False
    Elem x (x : xs) = True
    Elem x (_ : xs) = Elem x xs

next :: (Elem ss (ValidNext s) ~ 'True) => StopClock s -> StopClock ss -> IO ()
next Start Pause = print "paused"
next Start Stop = print "stopped"
next Pause ReStart = print "restart"
next Pause Stop = print "stop"
next ReStart Stop = print "stop"
next ReStart Pause = print "paused"
next Lap Pause = print "paused"
next Lap Lap = print "paused"
next Lap Stop = print "paused"
next _ _ = print "paused"

-- OPPGAVE 1
-- Legg til Lap til Stopclock (og SLap S). Hva skal være gyldig neste states? Fiks ValidNext og next

-- OPPGAVE 2
-- Lag en listedatatype som lar deg bygge opp lister med gyldige stopclock-commands

-- Gyldige :
-- c = ClockCons Start ListStop
-- c' = ClockCons Start $ ClockCons Pause ListStop
-- Ugyldige:
-- c'' = ClockCons Start $ ClockCons Pause $ ClockCons Pause ListStop

c = ClockCons Start ListStop
c' = ClockCons Start $ ClockCons Pause ListStop
c'' = ClockCons Start $ ClockCons Pause $ ClockCons ReStart ListStop

-- c''' = ClockCons Start $ ClockCons Pause $ ClockCons Pause ListStop

p = ClockCons Pause $ ClockCons ReStart ListStop

data ClockList s where
    ListStop :: ClockList SStop
    -- ClockCons :: Elem next (ValidNext cur) ~ 'True => StopClock cur -> ClockList next -> ClockList cur
    ClockCons :: ClockCheck (Elem s (ValidNext a)) => StopClock a -> ClockList s -> ClockList a

data StartClockList where
    Started :: ClockList SStart -> StartClockList
    AddStart :: ((s == SStart) ~ False) => StopClock SStart -> ClockList s -> StartClockList

ss = Started $ ClockCons Start $ ClockCons Pause ListStop
ss' = AddStart Start $ ClockCons Pause ListStop

-- sss' = AddStart Start $ ClockCons Start ListStop

type family ClockCheck s :: Constraint where
    ClockCheck True = ()
    ClockCheck False = TypeError (Text "Not a valid clocklist. stop before start blablabl")

-- pp = Started $ ClockCons Pause $ ClockCons ReStart ListStop

ppp = AddStart Start $ ClockCons Pause $ ClockCons ReStart ListStop

type family ByteSize x where
    ByteSize Word16 = Int
    ByteSize Word8 = Int

-- ByteSize a =
--     TypeError
--         ( Text "The type "
--             :<>: ShowType a
--             :<>: Text " is not exportable."
--         )

type A = ByteSize Word8
type B = ByteSize Word16
type C = ByteSize Int
