## Parametric polymorphishm

Implementer funksjonene utifra typene :
```haskell
constant :: a -> b -> a

f :: (a -> b -> c) -> (a -> b) -> a -> c
```


## Type classes

### Eq og Ord

#### 1

Implementer Eq og Ord (valgfri, men den må gi ) for disse typene :

```haskell
data Sjanger = Jazz | Rock | Pop | Klassisk deriving Show 

data NumberedVal a = NumberedVal Int a deriving Show

data Tree a b = Empty | NodeA a | NodeB b | Nodes (Tree a b) (Tree a b) 
    deriving Show
```



#### Maybe (bare for å vise)
```haskell
data Maybe a = Nothing | Just a
```


#### 2

Implementer en funksjon `findIndex :: Eq a => a -> [a] -> Maybe Int`
som gir indexen elementet finnes, eller Nothing hvis det ikke finnes.

#### 3

Implementer en funksjon `findMax` som gir det største elementet i en liste.
Hva skal funksjonen ha som type?
Hva er den mest generelle typen?

### Egen type class
Lag en typeklasse for typer der man kan sortere innholdet og også gi en liste med elementene 

sort "1432" ==> "1234"
asList "1432" ==> "1432"

sort (3,1) ==> (1,3)
asList (3,1) ==> [1,3]

tanken er da at 
asList (sort xs) == List.sort (asList xs)

Implementer for
String
[Int]
(Int,Int)
(Char,Char,Char)

(bruk : import qualified Data.List (sort))

####
Gjør instancene mer generelle ved å bruke contexts


####
Legg til en funksjon : sortReverse

Tips til ting som kan brukes:
sortOn
sortWith
Data.Ord.Down


#### Finn flere instancer

Finn minst 1 instance for en type fra standardlib

Lag minst en egen type og lag instance
