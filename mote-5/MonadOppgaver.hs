{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE KindSignatures #-}

module Monads where

import qualified Control.Monad.Identity as Data.Functor
import Data.Function
import Text.Read
import Prelude hiding (return, (>>=))
import qualified Prelude

class Functor m => MyMonad (m :: * -> *) where
    (>>=) :: m a -> (a -> m b) -> m b
    return :: a -> m a

-- | Oppgave : implementer MyMonad-instance for Maybe (prøv uten å se på slides først)
instance MyMonad Maybe where
    (>>=) :: Maybe a -> (a -> Maybe b) -> Maybe b
    (>>=) = error "todo"
    return :: a -> Maybe a
    return = error "todo"

readInt :: String -> Maybe Int
readInt = readMaybe

halve :: Int -> Maybe Int
halve x = if mod x 2 == 0 then Just (div x 2) else Nothing

-- lag en funksjon som leser et tall fra string og så forsøker å dele det på to
readAndHalve :: String -> Maybe Int
readAndHalve s = readInt s >>= halve

{- |
 >>> readAndHalve "6"
 Just 3
 >>> readAndHalve "6"
 Nothing
 >>> readAndHalve "6y"
 Nothing
-}

-- Oppgave : hvordan ville du gjort om readAndHalve til readAndHalveAndHalve (altså dele to ganger)?

--En type som bare wrappere en verdi
--identitetsfunksjonen som en datatype, på en måte
-- (ignorer fancy deriveringsting)
newtype Identity a = Identity a
    deriving (Show)
    deriving (Functor, Applicative) via Data.Functor.Identity

instance Monad Identity where
    (>>=) = undefined

{- | Oppgave : implementer MyMonad-instance for Identity
 | Tips : Følg typene! Eller tenk på den som Maybe uten Nothing-case
 >>> return 3 >>= (\x -> Identity (x+x))
 Identity 6
-}

{- | implementer join (kan også kalles flatten)
 Den flater ut en monadisk struktur. Altså kombinerer stacka effekter
 Tips : følg typene
 >>> join (Just (Just 2))
 Just 2
-}
join :: MyMonad m => m (m a) -> m a
join = error "todo"

-- | bonus : implementer (>>=) ved hjelp av join og fmap
andThenJoin :: MyMonad m => (a -> m b) -> m a -> m b
andThenJoin = error "todo"