module Main where

import System.Environment (getArgs)

-- newtype Reader env a = Reader (env -> a)

-- 3 lag funksjoner

readNumber test = do
    putStrLn "Input num :> "
    if not test
        then fmap read getLine
        else return 0

hereIsStuff test = do
    a <- readNumber test
    b <- readNumber test
    c <- readNumber test
    print $ [a, b, c]

main :: IO ()
main = do
    args <- getArgs
    let test = args == ["TEST"]
    print test
    print args
    hereIsStuff test

-- minieksempel, men irriterende å måtte sende ned argumenter utrolig mange lag manuelt
