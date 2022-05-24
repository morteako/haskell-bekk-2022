module MonadsDo where

import Text.Read

-- Oversett til do-notation:

d1 = Just 1 >>= halve

d1do = do
    undefined

d2 = Just 2 >>= \x -> halve x >>= \_ -> Just x

d2do = do
    undefined

{- | skriv map3 med do-notation. Bonus : uten do-notation
 >>> map3 (\x y z -> x+y+z) (Just 3) (Just 3) (Just 3)
 Just 9
-}
map3 :: Monad m => (a -> b -> c -> d) -> m a -> m b -> m c -> m d
map3 = error "todo"

map3AndThen :: Monad m => (a -> b -> c -> d) -> m a -> m b -> m c -> m d
map3AndThen = error "todo"

-- skriv andMap med do-notation
andMap :: Monad m => m (a -> b) -> m a -> m b
andMap = error "todo"

-- Oppgave

readInt :: String -> Maybe Int
readInt = readMaybe

halve :: Int -> Maybe Int
halve x = if mod x 2 == 0 then Just (div x 2) else Nothing

-- lag en funksjon som leser et tall fra string og så forsøker å dele det på to to ganger, og så gang det med 10
-- med do-notation
readAndHalve2TimesThenTimes10 :: String -> Maybe Int
readAndHalve2TimesThenTimes10 = undefined

{- | få list1233 til å bli som i testen, ved å bytte ut  de to første undefined med funksjoner
 >>> list1233
 [(1,2,3),(1,2,3)]
-}
list1233 :: [(Int, Int, Int)]
list1233 = do
    one <- undefined 1
    two <- [2] >>= undefined
    three <- undefined (+ 1) [2]
    return (one, two, three)

{- | Hva blir resultatet av de forskjellige uttrykene? prøv å evaluer i hodet før du sjekker i repl
 Det kan kanskje hjelpe å skrive om til do-notation eller and-then

 Just 2 >> Just 3

 Nothing >> Just 3

 Just 4 >> Nothing

 [1,2,3] >> ["2","2"]

 ["2","2"] >> [1,2,3]
-}