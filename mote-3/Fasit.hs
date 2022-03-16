{-# LANGUAGE DeriveFoldable #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE KindSignatures #-}

import Data.Foldable

-- Kinds

-- Gi eksempler på en type/typekonstuktør i stdlib og en du lager selv med disse kindene :

-- *

-- Int
data BasicKind = Hei | Hopp

-- * -> *

-- Maybe, [], Either a, (,) a, (,,) a b, Data.Set
data SnocList a = Emp | Snoc (SnocList a) a

-- * -> * -> *

-- Either, (,), (,) a, Data.Map

data OneAorTwoB a b = One a | Two b b

-- (* -> * -> *) -> *    (kun lage selv)
data IntString f = IntString (f Int String)

iex1 :: IntString Either
iex1 = IntString (Left 1)

iex2 :: IntString (,)
iex2 = IntString (1, "hei")

-- Type classes

-- Vi har en klasse for typekonstruktører som kan gjøres om til lister

class ListLike f where
    toList :: f a -> [a]

-- Prøv å lag instanser for:
-- Maybe
data Identity a = Identity a

-- (,) a
-- Either a
-- []

instance ListLike Maybe where
    toList Nothing = []
    toList (Just x) = [x]

instance ListLike ((,) a) where
    toList (_, x) = [x]

instance ListLike (Either a) where
    toList (Right x) = [x]
    toList _ = []

instance ListLike [] where
    toList = id

-- Lag en class for typer sånn at vi kan swappe typeparameterene

class Swap f where
    swap :: f a b -> f b a

instance Swap Either where
    swap (Left a) = Right a
    swap (Right a) = Left a

instance Swap (,) where
    swap (a, b) = (b, a)

ex1 :: Either Int String
ex1 = Right "hei"

ex2 :: ([Int], Maybe Bool)
ex2 = ([1, 2, 3], Just True)

-- Klassen skal ha en funksjon 'swap' slik at man kan gjøre om ex1 til en verdi med type Either String Int
-- og ex2 til (Maybe Bool, [Int])

-- Hvordan ser klassen ut? Hva blir kinden?
-- Hva blir typen til swap?

-- Foldable

-- Lag foldable instance for
data Tree a = Empty | Bin (Tree a) a (Tree a) deriving (Foldable)

exTree = Bin (Bin Empty 1 Empty) 2 (Bin (Bin Empty 3 (Bin Empty 4 Empty)) 5 Empty)

--bruk foldr til å få folde exTree for å få ut følgende verdier :

-- Som en liste (inorder) : [1,2,3,4,5]
a1 = foldr (:) [] exTree

-- Som en liste (inorder), men uten oddetall : [2,4]
a2 = foldr (\x xs -> if even x then x : xs else xs) [] exTree

-- størrelsen : 5
a3 = foldr (\_ l -> 1 + l) 0 exTree

-- Litt vanskeligere :
-- Første elementet : Just 1
a4 = foldr (\x _ -> Just x) Nothing exTree

-- Partisjonere partall og odetall : ([2,4],[1,3,5])
a5 = foldr (\x (xs, ys) -> if even x then (x : xs, ys) else (xs, x : ys)) ([], []) exTree

--skriv følgende funksjoner med foldr
toList' :: Foldable f => f a -> [a]
toList' = foldr (:) []

-- Monoids

exFold :: [Maybe String]
exFold = [Just "a", Nothing, Just "b", Just "c"]

res = fold $ fold [Just "a", Nothing, Just "b", Just "c"]

-- alternativt
res' = foldMap fold [Just "a", Nothing, Just "b", Just "c"]

-- Dual kan brukes når man vil ha den "flippa" monoiden
-- bruk Dual og foldMap til å reversere en liste (du kan bruke getDual til å pakke ut, men ikke nødvendig)
newtype Dual a = Dual {getDual :: a} deriving (Show)

instance Semigroup a => Semigroup (Dual a) where
    Dual a <> Dual b = Dual (b <> a)

instance Monoid a => Monoid (Dual a) where
    mempty = Dual mempty

revvedList :: [Integer]
revvedList = getDual $ foldMap (Dual . (: [])) [1, 2, 3, 4]
