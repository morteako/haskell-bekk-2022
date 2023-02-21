module Main where

import Control.Monad.Reader
import System.Environment (getArgs)

-- newtype Reader env a = Reader (env -> a)

newtype ReaderT' env m a = ReaderT' (env -> m a)

readerTIO :: ReaderT Int IO Int
readerTIO =
    ReaderT
        ( \b -> do
            i <- fmap read getLine
            pure $ i + b
        )

ex = do
    i <- readerTIO
    pure i

-- reader1 :: Reader String Integer
-- reader1 = Reader (\x -> if x == "hei" then 0 else 1)

-- 3 lag funksjoner

-- ask' :: Reader r r
-- ask' = ask

newtype App a = App (IO a)

readNumber :: ReaderT Bool IO Int
readNumber = do
    test <- ask
    lift $ do
        putStrLn "Input num :> "
        if not test
            then fmap read getLine
            else return 0

hereIsStuff :: ReaderT Bool IO ()
hereIsStuff = do
    a <- readNumber
    b <- readNumber
    c <- readNumber
    lift $ print $ [a, b, c]

main :: IO ()
main = do
    args <- getArgs
    let test = args == ["TEST"]
    print test
    print args
    runReaderT hereIsStuff test

    res <- runReaderT readerTIO 5
    print res
    pure ()

-- minieksempel, men irriterende å måtte sende ned argumenter utrolig mange lag manuelt
