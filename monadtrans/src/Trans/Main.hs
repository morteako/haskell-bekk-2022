{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ViewPatterns #-}

module Main (main) where

import Control.Monad.Except
import Control.Monad.Reader
import Control.Monad.State
import Text.Read (readMaybe)

-- intro state
-- intro reader

-- lese to tall fra bruker i loop
-- gi liste fra tall..tall
-- legge på feilmelding

-- Either

-- lift?

-- printe alle gamle tall hver gang

type OMayT m a = Maybe (m a)

type OStat s m a = Maybe (m a)

type MayT m a = m (Maybe a)

type IoWithError a = ReaderT String (ExceptT String (StateT (Int, [(Int, Int)]) IO)) a

getNum :: IoWithError Int
getNum = do
  msg <- ask
  liftIO $ putStr $ "Input num " <> msg <> ":> "
  x <- liftIO getLine
  case readMaybe @Int x of
    Nothing -> do
      (succ -> c, xs) <- get
      liftIO $ putStrLn $ "Error count : " <> show c
      put (c, xs)
      throwError $ "invalid number " <> x
    Just num -> pure num

loop :: IoWithError ()
loop =
  flip
    catchError
    (liftIO . print)
    ( do
        prevs <- gets snd
        liftIO $ putStr "PREVS " >> print prevs
        a <- getNum
        b <- getNum
        modify (\(c, xs) -> (c, (a, b) : xs))
        liftIO $ print [a .. b]
    )
    >> loop

main :: IO ()
main = do
  void $ flip evalStateT (0, []) $ runExceptT $ flip runReaderT "MSG" loop
