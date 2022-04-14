-- Functors
-- Typer som kan bli mappet over
-- Functors
-- Man vil ofte transformere data
-- Et standard eksempel er å mappe en funksjon over en liste
-- Deklarativt
-- Lettere å generalisere funksjon enn features i språket (loops)
-- En generalisering av containers / boks
-- Den abstraksjonen blir nok strukket litt langt
mapList = undefined

-- > mapList not []
-- []

-- > mapList not [True,False]
-- [False,True]

-- Map - Maybe a
-- mapMaybe :: (a->b) -> Maybe a -> Maybe b
-- mapMaybe f Nothing = Nothing
-- mapMaybe f (Just x) = Just (f x)
mapMaybe = undefined

-- > mapMaybe show Nothing
-- Nothing

-- > mapMaybe show (Just 1)
-- Just "1"

-- Map - Either e a
mapEither = undefined

-- type?
-- > mapEither show (Left True)
-- Left True

-- > mapEither (+1) (Right 1)
-- Right 2

-- Sammenligne map-funksjonene
mapList :: (a -> b) -> [] a -> [] b
mapMaybe :: (a -> b) -> Maybe a -> Maybe b
mapEither :: (a -> b) -> Either e a -> Either e b
-- Sammenligne map-funksjonene
-- Litt formattering
mapList' :: (a -> b) -> [] a -> [] b
mapMaybe' :: (a -> b) -> Maybe a -> Maybe b
mapEither' :: (a -> b) -> (Either e) a -> (Either e) b
-- Hvordan skal vi generalisere det her?
-- Ser at det er en typekonstruktør
mapList'' :: (a -> b) -> [] a -> [] b
mapMaybe'' :: (a -> b) -> Maybe a -> Maybe b
mapEither'' :: (a -> b) -> (Either e) a -> (Either e) b
mapGeneralized :: (a -> b) -> f a -> f b
mapGeneralized = unefined

-- f er da en higher kinded type

-- Siden det er forskjellig implementasjon per type trenger vi en type class

-- class MyFunctor (f :: * -> *) where

-- Man kan se det som at man løfter en funksjon til å jobbe på et høyere nivå. Feks fra Int -> Int til Maybe Int -> Maybe Int

-- Instancene kan lages ved si at fmap = mapList eller mapMaybe osv. Eller man kan definere funksjonen i instancen

-- instance MyFunctor Maybe where
--     mfmap :: (a -> b) -> Maybe a -> Maybe b
--     fmap = mapMaybe

-- instance MyFunctor (Either e) where
--     mfmap :: (a -> b) -> (Either e) a -> (Either e) b
--     mfmap f (Right a) = Right (f a)
--     mfmap f (Left e) = Left e

-- Typesignaturen er ikke nødvendig, bare for å hjelpe
-- (Either e) a er det samme som Either e a

-- Lage funksjoner som funker for alle Functors
mapAddOne :: Functor f => f Int -> f Int
mapAddOne = fmap (+ 1)

-- > mapAddOne (Just 1)
-- Just 2

-- > mapAddone [1,2,3]
-- [2,3,4]

-- I Elm feks så måtte vi ha laget en per Functor, altså mapAddOneMaybe, mapAddOneList, mapAddOneEither osvosv

-- Lage funksjoner som funker for alle Functors
deepShow :: (Functor f, Functor g, Show a) => f (g a) -> f (g String)
deepShow = fmap (fmap show)

-- -- her er f List, g Maybe og a Int
-- > deepShow [Just 1, Nothing, Just 3]
-- [Just "1",Nothing,Just "3"]

-- -- her er f Maybe, g List og a Int
-- > deepShow (Just [1,2,3])
-- Just ["1","2","3"]
-- Uten en functor-typeclasse så måtte man skrevet en implementasjon av denne funksjonen per kombinasjon av to functorer

-- Hvorfor generalisere?
-- mindre endringer når man endrer typer
-- kan skrive generelle funksjoner
-- parametricity => Functor f sier mye mer enn Model/DataType
-- ved å begrense hva man kan gjøre er det lettere å forstå
-- eksempel : a -> a sier mer enn Int -> Int
-- kan også gi opphav til implementasjson av lenses :
-- forall f. Functor f => (a -> f b) -> s -> f t
-- Lover
-- Hvordan forventer vi at en fmap-funksjon oppfører seg?
-- Mappe en funksjon som ikke gjør noe returnerer samme verdi
-- fmap id x = x
-- id er identitetsfunksjonen, altså id a = a
-- Mappe flere ganger er samme som en gang
-- fmap f (fmap g x) = fmap (f . g) x
-- Dette følger automatisk i Haskell av første regelen
-- Dette, sammen med typesignaturen, gjør at det finnes kun en lovlig Functor instance for hver typekonstruktør
-- Lovlig og ulovlig functor instance

-- Hvilken av disse functor instancene er lovlige/ulovlige og hvorfor?
data Two a = Two a a

-- instance Functor Two where
--     fmap f (Two a1 a2) = Two (f a1) (f a2)

-- instance Functor Two where
--     fmap f (Two a1 a2) = Two (f a1) (f a1)

-- instance Functor Two where
--     fmap f (Two a1 a2) = Two (f a2) (f a1)

-- er alle (f :: * -> *) Functors???

-- (,)

-- KRav
data Product f g a = Product (f a) (g a)
data Sum f g a = SumL (f a) | SumR (g a)

--
-- deriving Functor
-- deriving Foldable

-- Oppgaver
-- Functors.hs

-- Fjern kommentaren fra -- doctest ["-isrc", "src/Functors.hs"] altså fjern -- for å kjøre tester.

-------- stuff

mapList' = undefined
mapMaybe' = undefined
mapEither' = undefined
mapList'' = undefined
mapMaybe'' = undefined
mapEither'' = undefined