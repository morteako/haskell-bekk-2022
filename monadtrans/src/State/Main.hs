module Main where

import System.Environment (getArgs)

import Control.Monad.State
import Data.Functor.Identity

newtype MyState s a = MyState (s -> (a, s))

-- newtype State s a = State {runState :: s -> (a, s)}

-- get' :: MyState s s
-- get' = undefined

-- put' :: s -> MyState s ()
-- put' = undefined

-- modify :: (s -> s) -> MyState s ()
-- modify f = do
--     s <- get
--     put $ f s

-- -- øker og gir siste verdi, ++i
-- inc :: State Int Int
-- inc = undefined

-- push :: Int -> State [Int] ()
-- pop :: State [Int] Int
-- -- lage en funksjon som tar manipulerer staten (altså en stack) ved å legge øke øverste tall med 1

-- incTop :: State [Int] ()
-- incTop = undefined

main :: IO ()
main = do
    print ":)"

-- minieksempel, men irriterende å måtte sende ned argumenter utrolig mange lag manuelt
