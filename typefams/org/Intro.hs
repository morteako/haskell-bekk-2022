{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

import Data.Type.Equality

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

data S = SStart | SPause | SReStart | SStop

data StopClock s where
    Start :: StopClock SStart
    Pause :: StopClock SPause
    ReStart :: StopClock SReStart
    Stop :: StopClock SStop

type family ValidNext s where
    ValidNext SStart = '[SPause, SStop]
    -- ValidNext SLap = '[SLap,SPause,SStop]
    ValidNext SPause = '[SReStart, SStop]
    ValidNext SReStart = '[SPause, SStop]
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

data ClockList s where
    ListStop :: ClockList SStop
    ClockCons :: Elem s (ValidNext a) ~ 'True => StopClock a -> ClockList s -> ClockList a