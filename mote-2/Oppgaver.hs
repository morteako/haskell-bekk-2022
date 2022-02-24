import qualified Data.List (sort)

-- Parametric polymorphishm

--Implementer funksjonene utifra typene :

constant :: a -> b -> a
constant = undefined

f :: (a -> b -> c) -> (a -> b) -> a -> c
f = undefined


-- Type classes

-- Eq og Ord

-- 1

-- Implementer Eq og Ord (valgfri, men den må gi ) for disse typene :


data Sjanger = Jazz | Rock | Pop | Klassisk deriving Show 

data NumberedVal a = NumberedVal Int a deriving Show

-- Kan skippe Ord for Tree, for mye jobb
data Tree a b = Empty | NodeA a | NodeB b | Nodes (Tree a b) (Tree a b) 
    deriving Show



-- 2
-- data Maybe a = Nothing | Just a

-- Implementer en funksjon som gir indexen elementet finnes, eller Nothing hvis det ikke finnes.
findIndex :: Eq a => a -> [a] -> Maybe Int
findIndex = undefined

-- 3

-- Implementer en funksjon `findMax` som gir det største elementet i en liste.
-- Hva skal funksjonen ha som type?
-- Hva er den mest generelle typen?

findMax = undefined

-- 4
-- Egen type class

-- Sortable er en type class for typer der man kan sortere innholdet 
-- den har funksjonen sort
-- sort "1432" ==> "1234"
-- sort (3,1) ==> (1,3)



class Sortable a where
    sort :: a --ikke riktig type, endre den til noe som gir mening 



-- Implementer for
-- String
-- [Int]
-- (Int,Int)
-- (Char,Char,Char)

-- bruk : Data.List.sort , som er importert


-- 5
-- Gjør instancene mer generelle ved å bruke contexts


-- 6
-- Legg til en funksjon : sortReverse


-- 7

main = do
    putStrLn ":)"