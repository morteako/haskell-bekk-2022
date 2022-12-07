{-# LANGUAGE TypeApplications #-}

module Main (main) where

import Text.Read (readMaybe)

-- lese to tall fra bruker i loop
-- gi liste fra tall..tall
-- legge på feilmelding

-- Either

-- lift?

-- printe alle gamle tall hver gang

getNum = do
  putStr "Input num :> "
  x <- getLine
  case readMaybe @Int x of
    Nothing -> pure $ Left $ "invalid number " <> x
    Just num -> pure $ Right num

loop :: IO ()
loop = do
  a <- getNum
  case a of
    Left e -> print e
    Right a -> do
      b <- getNum
      case b of
        Left e -> print e
        Right b -> print [a .. b]

  loop

main :: IO ()
main = do
  loop
