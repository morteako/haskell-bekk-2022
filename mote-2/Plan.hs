{-# LANGUAGE FlexibleInstances #-}

import qualified Data.Set as Set

-- # Møte 2 : Typer

-- ## Parametric polymorphishm . Gjelder for alle typer
-- # Typeparameter

-- intsLength :: [Int] -> Int
-- intsLength [] = 0
-- intsLength (_:xs) = 1 + intsLength xs

-- charsLength :: [Char] -> Int
-- charsLength [] = 0
-- charsLength (_:xs) = 1 + charsLength xs

allLength :: [a] -> Int
allLength [] = 0
allLength (_:xs) = 1 + allLength xs
--allLength :: forall a . [a] -> Int

--kan da instansiere allLength med spesifikke typer

-- bruke @Int

id :: a -> a
id x = x

fst :: (a,b) -> a
fst (a,b) = a

-- Ikke noe instanceof i Haskell, så gir garantier


-- ### == : equals 

-- lett å lage en 
boolEq :: Bool -> Bool -> Bool
boolEq True True = True
boolEq False False = True
boolEq _ _ = False

charEq = undefined

stringEq :: String -> String -> Bool
stringEq "" "" = True
stringEq (x:xs) (y:ys) = charEq x y && stringEq xs ys
stringEq _ _ = False

-- men hva med en generell likhetssjekk. Da må vi ha generelle typer, altså typeparametere

-- eq :: a -> a -> Bool
-- eq = undefined

-- Hvorfor funker ikke det?

-- Det er på en måte det motsatte av det vi vil ha

-- ## Forskjellig oppførsel for hver type

-- Vi trenger en slags interface Eq

-- class Eq' a where
--     eq :: a -> a -> Bool

-- instance Eq' Bool where
--     eq True True = True
--     eq False False = True
--     eq _ _ = False

data Hei = HeiOgHopp | HoppOgHei deriving (Eq,Ord,Show,Read) 

-- instance Eq Hei where
--     HeiOgHopp == HeiOgHopp = True
--     HoppOgHei == HoppOgHei = True
--     _ == _ = False
-- type class Eq

-- instance



-- ### Show

-- ### Superklasser : Eq => Ord



-- ### Egenskaper

-- Eq - ekvivalensrelasjon
-- Refleksiv : a == a = True
-- Symmetrisk : a == b  --> b == a
-- Transitiv : a == b && b == c -> a == c


-- Ord <=
-- Refleksiv a <= a = True
-- Transitiv : a <= b && b <= c   -> a <= c
-- Antisymmetrisk : a <= b og b <= a, da er a == b



-- Type classes : typer til verdier

class Default a where
    value :: a

instance Default [Char] where
    value = "hei"

instance Default Int where
    value = 5

instance Default Bool where
    value = True

-- Deriving

-- Data.Set


-- Read

-- Coherence







-- ### Monoids

-- fold :: (a -> a -> a) -> a -> [a] -> a

-- fold (++) []
-- fold (+) 0
-- fold (*) 1
-- fold min INT_MAX
-- fold (\(a1,a2) (b1,b2) -> (a1+b1,min a2 b2)) (0, INT_MAX)




-- ### Semigroups 

-- Ikke alle typer har identitets





main = do
    print ":)"







