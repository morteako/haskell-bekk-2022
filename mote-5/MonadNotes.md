---


marp:true
marp: true
---
<!-- paginate: true -->
# Functors og Monads
## Plan
* Kort gjennomgang av Haskell-konsepter
* Functors
* Monads
---
# Vanskelig tema 
* Lærer forskjellig
* Abstrakt
* Alternative fremgangsmåter
* Forskjellige læringsmåter
* Noe som blir sagt kan være liltt upresist for å slippe detaljer

---

# Monads

* Et abstrakt interface for å kombinere utregninger med "effekter" (chaining effectful computations)
    * Effekter - ikke nødvendigvis SIDE-effekter
    * Ganske annerledes effekt for hver konkrete monad 
    * Lister - Flere muligheter
    * Maybe - Short circuit
    * Either e - Feilhåndtering
    * State s - Utregning med en read og write state
    * IO - håndtere sideeffekter (egentlig en special case av State)
    * osv 
* Men alle følger overordnede regler og oppfører seg derfor "forutsigbart"
* De kan kombineres (men det skal ikke vi se på)
* Vi skal prøve å komme fram til definisjonen selv
--- 

# Kombinere Maybe - eksempel

Vi vil ta første strengen, gjøre om til tall og gange med 10.
Da må vi ta hensyn til at ting kan feile (Maybe).
## Rett fram :
```haskell
safeHead :: [a] -> Maybe a
safeReadInt :: String -> Maybe Int

numstrs = ["3","2","3"]

maybeFirstInt :: Maybe Int
maybeFirstInt = case safeHead numstrs of
    Nothing -> Nothing
    Just first -> case safeReadInt first of
        Nothing -> Nothing
        Jusst num -> Just (num*10)
```

--- 

# Kombinere Maybe - eksempel

Dette blir veldig klønete. Ser at det er et pattern og skriver finere

```haskell
andThen :: (a -> Maybe b) -> Maybe a -> Maybe b
andThen _ Nothing= Nothing
andThen f (Just a) = f a

--piping som i elm, & = |>
maybeFirstInt = numstrs
    & safeHead
    & andThen safeRead
    & andThen (\x -> Just (x * 10))
```

Kan vi forenkle det her bittelitt? Hint hint : Functors

--- 
# Kombinere Maybe - eksempel


```haskell
andThen :: (a -> Maybe b) -> Maybe a -> Maybe b
andThen _ Nothing= Nothing
andThen f (Just a) = f a

--piping , samme som Elm sin |>
maybeFirstInt = numstrs
    & safeHead
    & andThen safeRead
    & fmap (*10)
```

---

# Kombinere List
Gjøre noe lignende, bare for lister.
Vi vil for hvert tall telle opp fra 0 til tallet (3 -> [0,1,2,3]) og så replisere det tallet like mange ganger som seg selv (3 -> [3,3,3])
og så gjøre om tallene til strenger

```haskell
replicateSelf :: Int -> [Int]
replicatesef x = replicate x x
countUp :: Int -> [Int]
countUp x = [0..x]

nums = [1,2,3]

vi ser at vi må ha en flatMap (andThen)
```

--- 
# Kombinere List - flatMap

```haskell
flatMap :: (a -> [b]) -> [a] -> [b]
flatMap f [] = []
flatMap f (x:xs) = f x ++ flatMap f xs
```
--- 
# Kombinere List - flatMap

```haskell
replicateSelf :: Int -> [Int]
replicatesef x = replicate x x
countUp :: Int -> [Int]
countUp x = [0..x]

nums = [1,2,3]

countedAndReplicated = fmap show (flatMap replicateSelf (flatMap countUp nums))

-- lettere med chaining

countedAndReplicated2 = nums
    & flatMap countUp
    & flatMap replicateSelf
    & fmap show
```

--- 

# Kombinere State
Lister og Maybe er jo ganske like. De inneholder enten 0 - 1 eller 0  - uendelig mange verdier.
Men alle Monads er ikke sånn.
Feks State - state-utregninger
```haskell
data State s a
s er typen til staten
a er typen som blir bereget ut av state-utregningen

State [Int] Bool er da en state-utregning som har [Int] som state og som gir en Bool

siden vi vil kombinere state-utregninger på samme måte
så har vi andThen for state også (implementasjon ikke viktig)
andThen :: (a -> State s b) -> State s a -> State s b
```

Sekvenserer beregninger med state-effekt

--- 

# Generalisere

```haskell
andThen :: (a -> Maybe b) -> Maybe a -> Maybe b
flatMap :: (a -> List b) -> List a -> List b
andThen :: (a -> State s b) -> State s a -> State s b
andThen :: (a -> IO b) -> IO a -> IO b
```

Hvordan generaliserer vi dette?

--- 

# Generalisere
Bruker en higher kinded type variabel
```haskell
andThen :: (a -> f b) -> f a -> f b

andThen :: (a -> Maybe b) -> Maybe a -> Maybe b -- f er Maybe
andThen :: (a -> List b) -> List a -> List b -- f er List
andThen :: (a -> State s b) -> State s a -> State s b -- f er State s b
andThen :: (a -> IO b) -> IO a -> IO b -- f er IO
```
--- 

# Monad*
```haskell
class Monad m where
    andThen :: (a -> m b) -> m a -> m b
```

Nå er vi veldig nærme å ha en fullverdig definisjon av Monad
 
---

# Functor vs Monad 

andThen mapper med en effektfull funksjon
Hvis vi hadde hatt en funksjon :: a -> m a, så kunne vi implementert
fmap via andThen (typemessig og lovmessig)

```haskell
andThen :: Monad m   => (a -> m b) -> m a -> m b
fmap    :: Functor f => (a ->   b) -> f a -> f b 

--wrapper verdien i en basic monad struktur
--en utregning uten effekt
return :: Monad m => a -> m a
--for Maybe - return x = Just x
--for List - return x = [x]

fmapFromAndThen :: Monad m => (a -> b) -> m a -> m b
fmapFromAndThen f ma = andThen (\x -> return (f x)) ma
```

---

# Monad**
* Vi så at alle Monads er også Functors.
    * Monads er kraftigere enn Functors
    * Monad er derfor en subclasse av Functors
    * Functor superklasse av Monads
* legger på return   
```haskell
class Functor f => Monad m where
    andThen :: (a -> m b) -> m a -> m b
    return :: a -> m a
```

---
# Monad instance - Maybe

```haskell
class Functor f => Monad m where
    andThen :: (a -> m b) -> m a -> m b
    return :: a -> m a

instance Monad Maybe where
    andThen :: (a -> Maybe b) -> Maybe a -> Maybe b
    andThen _ Nothing= Nothing
    andThen f (Just a) = f a

    return :: a -> Maybe a
    return x = Just x
```
--- 

# Generelle funksjoner - map2
```haskell
> map2 (+) (Just 2) (Just 3)
Just 5

map2 :: Monad m => (a -> b -> c) -> m a -> m b -> m c
map2 f ma mb = andThen (\a -> andThen (\b -> return (f a b)) mb) ma
```

Oppgaver å lage map3 og andMap

--- 

# >> - gjøre ting i sekvens

* andThen kombinerer to monadiske utregninger
* Ofte vil man gjøre noe kun for effekten og ikke verdien.
* Kan ses på som en monadisk pipe for kun effekter
    
```haskell
ma >> mb :: Monad m => m a -> m b -> m b
ma >> mb = andThen (\_ -> mb) ma

print :: Show a => a -> IO ()

print 1 >> print 2 --printer 1 og så 2

drop3IfNotEmpty :: [a] -> Maybe [a]
drop3IfNotEmpty xs = safeHead xs >> return (drop 3 xs)

> drop3IfNotEmpty [1,2,3,4,5]
Just [4,5]
> drop3IfNotEmpty [1,2,3,4,5]
Nothing
```
---

# Do notation

Ser at å chaine andThen osv er ganske krøkkete

Heldigvis finnes en løsning 

## Do notation

Syntaktisk sukker for andThen og >>

--- 

# Do notation - eksempel

```haskell
nameReturn :: IO String
nameReturn = do putStr "What is your first name? "
                first <- getLine
                putStr "And your last name? "
                last <- getLine
                let full = first ++ " " ++ last
                putStrLn ("Pleased to meet you, " ++ full ++ "!")
                return full
```

--- 

# Do notation - Linjeskift

* Linjeskift tilsvarer at man gjør det ene og så det andre.
* Som i vanlig imperativ programmering

```haskell
do 
    print 1
    print 2
```
samme som

```haskell
print 1 >> print 2
```

--- 

# Do notation - andThen

* andThen får man ved å bruke <-
* Jeg tenker på som at man drar a-en ut av m a -en , altså monaden

```haskell
do 
    verdi <- monadTing
    gjørNoe verdi

samme som

andThen (\verdi -> gjørNoe verdi) monadTing

eks
xs = do 
    x <- [1,2,3]
    [x,x]
> [1,1,2,2,3,3]
```

--- 

# Do notation - fmap og map2

```haskell
fmapDo f fa = do 
    a <- fa
    return (f a)

map2Do f fa fb = do
    a <- fa
    b <- fb
    return (f a b)
```

---
# Generelle funksjoner

Siden vi har muligheten til å generalisere monads, kan vi lage generelle funksjoner
Feks en som gjentar en monadisk effekt flere ganger og samler opp resultatene i en liste

```haskell
replicateM :: Monad m => Int -> m a -> m [a]
replicateM n m = loop n
  where
    loop cnt
        | cnt <= 0  = return []
        | otherwise = do
            x <- m
            xs <- loop (cnt - 1)
            return $ x:xs

> replicateM 3 getLine
aa --leses fra input
bbb
cccc
["aa","bbb","cccc"]

> replicateM 3 [1,2]
[[1,1,1],[1,1,2],[1,2,1],[1,2,2],[2,1,1],[2,1,2],[2,2,1],[2,2,2]]
```
