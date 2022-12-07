{-# LANGUAGE TypeApplications #-}

module Main (main) where

-- lese to tall fra bruker i loop
-- gi liste fra tall..tall
-- legge på feilmelding

-- Either

-- lift?

-- printe alle gamle tall hver gang

getNum = do
  putStr "Input num :> "
  x <- getLine
  pure $ read @Int x

loop :: IO ()
loop = do
  a <- getNum
  b <- getNum
  print $ [a .. b]
  loop

main :: IO ()
main = do
  loop
