{-# LANGUAGE TypeApplications #-}

module Main (main) where

import Control.Monad.Except
import Control.Monad.State
import Text.Read (readMaybe)

-- lese to tall fra bruker i loop
-- gi liste fra tall..tall
-- legge på feilmelding

-- Either

-- lift?

-- printe alle gamle tall hver gang

type IoWithError a = ExceptT String (StateT [(Int, Int)] IO) a

getNum :: IoWithError Int
getNum = do
  liftIO $ putStr "Input num :> "
  x <- liftIO getLine
  case readMaybe @Int x of
    Nothing -> throwError $ "invalid number " <> x
    Just num -> pure num

loop :: IoWithError ()
loop =
  flip
    catchError
    (liftIO . print)
    ( do
        prevs <- get
        liftIO $ putStr "PREVS " >> print prevs
        a <- getNum
        b <- getNum
        modify ((a, b) :)
        liftIO $ print [a .. b]
    )
    >> loop

main :: IO ()
main = do
  void $ flip evalStateT [] $ runExceptT loop
