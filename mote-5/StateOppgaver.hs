{-# LANGUAGE DerivingVia #-}

import Control.Monad.State
import Data.Functor.Identity

--newtype State s a = State {runState :: s -> (Identity a, s)}

get' :: State s s
get' = undefined

put' :: s -> State s ()
put' = undefined

modify :: (s -> s) -> State s ()
modify f = do
    s <- get
    put $ f s

-- øker og gir siste verdi, ++i
inc :: State Int Int
inc = undefined

--bruk inc til å putte tall som øker inn i treet

data Tree a = Leaf a | Bin (Tree a) (Tree a)

-- size :: Tree a -> S

-- andThen :: (a -> State s b) -> State s a -> State s b
-- --Stack-operasjoner
-- push :: Int -> State [Int] ()
-- pop :: State [Int] Int
-- -- lage en funksjon som tar manipulerer staten (altså en stack) ved å legge øke øverste tall med 1

-- incTop :: State [Int] ()
-- incTop =
--     pop
--         & andThen (\poppedNum -> push (poppedNum + 1))

-- --med fmap
-- incTop :: State [Int] ()
-- incTop =
--     pop
--         & fmap (+ 1)
--         & andThen push

accSums :: Tree Integer -> Tree Integer
accSums = snd . go 0
  where
    go curSum (Leaf a) = (a + curSum, Leaf $ a + curSum)
    go curSum (Bin l r) =
        let (ls, l') = go curSum l
            (rs, r') = go ls r
         in (rs, Bin l' r')