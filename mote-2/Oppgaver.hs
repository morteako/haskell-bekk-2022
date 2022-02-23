{-# OPTIONS_GHC -Wincomplete-patterns #-}
{-# LANGUAGE FlexibleInstances #-}

module Oppgaver where




import qualified Data.List (sort)

-- Parametric polymorphishm

-- Implementer funksjonene utifra typene :

constant :: a -> b -> a
constant a _ = a

f :: (a -> b -> c) -> (a -> b) -> a -> c
f abc ab a = abc a $ ab a



-- Type classes

-- Eq og Ord

-- 1

-- Implementer Eq og Ord (valgfri hva slags ordning, men den må være en gyldig ordning ) for disse typene :


data Sjanger = Jazz | Rock | Pop | Klassisk deriving Show 



instance Eq Sjanger where
    Jazz == Jazz = True
    Rock == Rock = True
    Pop == Pop = True
    Klassisk == Klassisk = True
    _ == _ = False

-- Ordning basert på rekkefølgen de er ført opp. Som er det samme som deriving gjør
instance Ord Sjanger where
    Jazz <= _ = True
    _ <= Jazz = False
    Rock <= _ = True
    _ <= Rock = False
    Pop <= _ = True
    _ <= Pop = False
    Klassisk <= Klassisk = True


data NumberedVal a = NumberedVal Int a deriving Show

instance Eq a => Eq (NumberedVal a) where
    NumberedVal i a == NumberedVal i' a' = i == i' && a == a'

instance Ord a => Ord (NumberedVal a) where
    NumberedVal i a <= NumberedVal i' a' 
        | i < i' = True
        | i == i' && a <= a' = True
        | otherwise = False

data Tree a b = Empty | NodeA a | NodeB b | Nodes (Tree a b) (Tree a b) 
    deriving Show

instance (Eq a,Eq b) => Eq (Tree a b) where
    Empty == Empty = True
    NodeA a == NodeA a' = a == a'
    NodeB b == NodeB b' = b == b'
    Nodes l r == Nodes l' r' = l == l' && r == r'
    _ == _ = False

-- 2
-- data Maybe a = Nothing | Just a

-- Implementer en funksjon som gir indexen elementet finnes, eller Nothing hvis det ikke finnes.
findIndex :: Eq a => a -> [a] -> Maybe Int
findIndex a xs = go 0 xs
    where
        go _ [] = Nothing
        go i (x:xs) | x == a = Just i
        go i (_:xs) = go (i+1) xs

-- 3

-- Implementer en funksjon `findMax` som gir det største elementet i en liste.
-- Hva skal funksjonen ha som type?
-- Hva er den mest generelle typen?

findMax :: Ord a => [a] -> Maybe a
findMax [] = Nothing
findMax (x:xs) = case findMax xs of
    Nothing -> Just x
    Just x' -> Just $ max x x'

-- kan også forenkles ved å bruke innebygget Ord for Maybe
findMax' :: Ord a => [a] -> Maybe a
findMax' [] = Nothing
findMax' (x:xs) = Just x `max` findMax xs

-- 4
-- Egen type class

-- Sortable er en type class for typer der man kan sortere innholdet og også gi en liste med elementene
-- Alle elementene har da samme type 
-- den har funksjonene sort og asList
-- sort "1432" ==> "1234"
-- asList "1432" ==> "1432"
-- sort (3,1) ==> (1,3)
-- asList (3,1) ==> [1,3]

-- Endre typene for sort og asList slik at til det de burde være

class Sortable a where
    sort :: a -> a 
    sortReverse :: a -> a

-- dette burde alltid være sant : asList (sort xs) == List.sort (asList xs)
-- Prøv å kom på en annen egenskap som alltid burde være sann

-- Implementer for
-- [Char]
-- [Int]
-- (Int,Int)
-- (Char,Char)

-- bruk : Data.List.sort , som er importert

-- instance Sortable [Char] where
--     sort = Data.List.sort

-- instance Sortable [Int] where
--     sort = Data.List.sort


-- instance Sortable (Int,Int) where
--     sort (a,b) = case compare a b of
--         LT -> (a,b)
--         EQ -> (a,b)
--         GT -> (b,a)

-- instance Sortable (Char,Char) where
--     sort (a,b) = case compare a b of
--         LT -> (a,b)
--         EQ -> (a,b)
--         GT -> (b,a)




-- 5
-- Gjør instancene mer generelle ved å bruke contexts

instance Ord a => Sortable [a] where
    sort = Data.List.sort
    sortReverse = reverse . Data.List.sort

instance Ord a => Sortable (a,a) where
    sort (a,b) = case compare a b of
        LT -> (a,b)
        EQ -> (a,b)
        GT -> (b,a)

    sortReverse ab = (b,a)
        where
            (a,b) = sort ab


-- 6
-- Legg til en funksjon : sortReverse

-- 7
