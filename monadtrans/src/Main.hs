{-# LANGUAGE TypeApplications #-}

module Main (main) where

import Control.Monad.Except
import Text.Read (readMaybe)

-- lese to tall fra bruker i loop
-- gi liste fra tall..tall
-- legge på feilmelding

-- Either

-- lift?

-- printe alle gamle tall hver gang

type IoWithError a = ExceptT String IO a

getNum :: IoWithError Int
getNum = do
  lift $ putStr "Input num :> "
  x <- lift getLine
  case readMaybe @Int x of
    Nothing -> throwError $ "invalid number " <> x
    Just num -> pure num

loop :: IoWithError ()
loop =
  flip
    catchError
    (lift . print)
    ( do
        a <- getNum
        b <- getNum
        lift $ print [a .. b]
    )
    >> loop

main :: IO ()
main = do
  void $ runExceptT loop
