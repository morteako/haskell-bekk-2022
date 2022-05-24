import Control.Applicative
import Control.Monad (replicateM)

-- getLine :: String
-- print :: Show a => a -> IO ()
-- readFile :: String -> IO String

-- Test ting i REPL altså ghci

-- Oppgave
-- implementer : printLen :: IO (), som leser en streng og printer lengden på strenger
-- bonus : gjør det uten do-notation

printLen :: IO ()
printLen = do
    l <- getLine
    print $ length l

-- alternativ : getLine >>= print . length

-- Oppgave
-- implementer getFirst10 som returnerer første 10 chars fra en fil
getFirst10 :: String -> IO String
getFirst10 path = do
    content <- readFile path
    return $ take 10 content

-- alternativ : fmap (take 10) $ readFile path

--Oppgave
--implementer getNlines som leser inn n linjer fra bruker og så concater alle sammen

getNLines :: Int -> IO String
getNLines 0 = return ""
getNLines lineNr = do
    line <- getLine
    lines <- getNLines (lineNr - 1)
    return $ line ++ lines

--alternativ
getNLines' :: Int -> IO String
getNLines' 0 = return ""
getNLines' lineNr =
    liftA2 (++) getLine (getNLines' (lineNr - 1))

-- liftA2 er map2 fra Elm

-- alternativ 2, for ineresserte
getNLines'' n = fmap concat $ replicateM n getLine
