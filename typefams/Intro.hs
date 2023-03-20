{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

import Data.Type.Equality

-- to kategorier: Åpne/open vs lukkede/closed
-- lukkede / closed type families
-- Closed
-- jobbe med GADTs

-- data Pairtype a where
type family PairType a where
    PairType String = [String]
    PairType Int = Bool
    PairType a = a

q :: PairType Int
q = False

makePair :: a -> PairType a -> (a, PairType a)
makePair a b = (a, b)

ex1 = makePair (1 :: Int) True

ex2 = makePair [1 :: Int] [2]

-- gadt-eksempel

data IntOrString a where
    Int :: Int -> IntOrString Int
    String :: String -> IntOrString String

type family ExtraInfo a where
    ExtraInfo Int = (Int, Int)
    ExtraInfo String = Maybe String

printInfo :: IntOrString a -> ExtraInfo a -> IO ()
printInfo (Int i) v = do
    print i
    print $ fst v
    print $ snd v
printInfo (String s) v = do
    print $ s ++ maybe "" id v

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

type family ValidNext (s :: S) where
    ValidNext SStart = '[SPause, SStop]
    ValidNext SPause = '[SReStart, SStop]
    ValidNext SReStart = '[SPause, SStop]
    ValidNext SStop = '[]

type family Elem a xs where
    Elem _ '[] = False
    Elem x (x : _) = True
    Elem x (_ : xs) = Elem x xs

next :: (Elem next (ValidNext cur) ~ True) => StopClock cur -> StopClock next -> IO ()
next Start Stop = print "STOP"
next Start Pause = print "Pause"
next Pause ReStart = print "Pause"
next Pause Stop = print "Pause"
next ReStart Pause = print "Pause"
next ReStart Stop = print "Pause"

-- OPPGAVE 1
-- Legg til Lap til Stopclock (og SLap S). Hva skal være gyldig neste states? Fiks ValidNext og next

-- OPPGAVE 2
-- Lag en listedatatype som lar deg bygge opp lister med gyldige stopclock-commands

-- Gyldige :
-- c = ClockCons Start ListStop
-- c' = ClockCons Start $ ClockCons Pause ListStop
-- Ugyldige:
-- c'' = ClockCons Start $ ClockCons Pause $ ClockCons Pause ListStop
