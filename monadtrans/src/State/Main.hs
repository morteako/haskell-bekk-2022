{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}

module Main where

import Control.Monad.Reader
import Control.Monad.State
import Data.Functor.Identity
import System.Environment (getArgs)

newtype MyState s a = MyState (s -> (a, s))

-- newtype StateT s m a = StateT (s -> m (a, s))

-- newtype State s a = State {runState :: s -> (a, s)}

-- ReaderT _ StatT IO [Int

get' :: MyState s s
get' = MyState (\s -> (s, s))

put' :: s -> MyState s ()
put' s = MyState (\_ -> ((), s))

stateTest :: State Int ()
stateTest = do
    s <- get
    put $ s * 2

stateTest2 :: State Int Int
stateTest2 = do
    s <- get
    put $ s * 4
    pure s

runStateTest = runState st 2
  where
    st = do
        stateTest
        stateTest2

-- modify :: (s -> s) -> State s ()
-- modify f = do
--     s <- get
--     put $ f s

-- -- øker og gir siste verdi, ++i
-- inc :: State Int Int
-- inc = undefined

push :: (MonadState [Int] m) => Int -> m ()
push i = do
    xs <- get
    let newXs = i : xs
    put newXs

pop :: (MonadState [Int] m, MonadIO m, MonadReader Int m) => m Int
pop = do
    xs <- get
    env <- ask
    put $ env : tail xs
    let r = head xs
    liftIO $ print r
    pure r

stackTest :: ReaderT Int (StateT [Int] IO) [Int]
stackTest = do
    push 3
    push 5
    a <- pop
    push 4
    push 5
    b <- pop
    c <- pop
    return [a, b, c]

-- -- lage en funksjon som tar manipulerer staten (altså en stack) ved å legge øke øverste tall med 1

-- incTop :: State [Int] ()
-- incTop = undefined

f :: Int -> Int
f x = x

g :: (i ~ Int) => i -> i
g x = x

main :: IO ()
main = do
    print ":)"
    print $ runStateTest
    res <- runStateT (runReaderT stackTest 100) []
    print res
    print $ f 5
    print $ g 5

-- minieksempel, men irriterende å måtte sende ned argumenter utrolig mange lag manuelt
