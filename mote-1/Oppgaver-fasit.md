# Oppgaver

## $ og .

### 1
Skriv om `map show (reverse (map (\x -> negate (x+1)) [1,2,3]))` til å bruke $ istedenfor paranteser.
(Trenger fortsatt paranteser rundt lambdaen `(\x -> ..)

Resultat:
```haskell
map show (reverse (map (\x -> negate (x+1)) [1,2,3]))
["-4","-3","-2"]
```

FASIT : map show $ reverse $ map (\x -> negate $ x+1) [1,2,3]



### 2
Definer en funksjon `f` som utfører, `map show (reverse (map (\x -> negate (x+1)) [1,2,3]))`, men at listen er et argument.
Definer to versjoner : en uten compose (.) med argument og en med (.) uten argument (point free)

Resultat : 
```haskell
> f [3,2,1]
["-2","-3","-4"]
```

FASIT : 
```haskell
f xs = map show $ reverse $ map (\x -> negate $ x+1) xs

f = map show . reverse . map (negate . (+1))
```

## Pattern matching

### 1

Definer en funksjon `f::[Int] -> Int` som tar inn en liste og returnerer 0 hvis første elementet er 0, eller 1 hvis andre elementet er 1, eller 5 hvis ikke.

Definer først med case og så med flere definisjoner

Resultat :
```haskell
f [0,1,2]
> 0
f [5,1,2]
> 1
f [5,5,2]
> 5
f []
> 5

```

FASIT :
```haskell
f (0:_) = 0
f (_:1:_) = 1
f _ = 5

f xs = case xs of
    0:_ -> 0
    _:1:_ -> 1
    _ -> 5
```

### 2

Definer samme funksjon som over med guards.
Bruk da head, tail og == istedenfor pattern matching

FASIT :
```haskell
f xs 
    | null xs = 5
    | head xs == 0 = 0
    | head (tail xs) == 1 = 1
    | otherwise = 5
```

## Sections

Skriv om `filter (\x -> x < 3) [0,1,2,3,4]` til å bruke section. 

FASIT:
```haskell
filter (< 3) [0,1,2,3,4]
```

Skriv om `map (\x -> take x "abcde") [1,2,3]` til å bruke section. 

FASIT:
```haskell
map (`take` "abcde") [1,2,3]
```

Tricky/finurlilg :
Skriv om `map (\f -> f [1,2,3]) [reverse,tail,(5:)]` til å bruke section. 
Hint : Penger og USA
FASIT:
```haskell
map ($ [1,2,3]) [reverse,tail,(5:)]
```

## Lister

Definer en funksjon `myFilter :: (a -> Bool) -> [a] -> [a]` som kun beholder elementer i lista som oppfyller predikatet. 
Skriv den selv, ikke bruk `filter`.

Skriv en funksjon `myZip :: [a] -> [b] -> [(a,b)]` som kombinerer to lister
eksempel
```Haskell
> myZip [1,2,3] "abcd"
[(1,'a'),(2,'b'),(3,'c')]
```

## Lazy

Definer en uendelig liste 1,2,3,4,5,6,7...
PS: ikke print hele

resultat:
```haskell
> take 5 nums
[1,2,3,4,5]
```

Fasit:
```haskell
nums = go 1
    where
        go x = x : g (x+1)

nums = 1 : map (+1) nums
```

## Stack

Lag et stackprosjekt med feks navn `mote1`.
Legg til `containers` som en dependency.
Se på https://hackage.haskell.org/package/containers-0.6.5.1/docs/Data-Set.html

Bruk funksjoner derfra til å lage mengder og prøv å ta feks union, intersection.

Prøv også samme data Data.Map.
Prøv union, intersection, og unionWith og intersectionWith


## Ekstra:
Løs advent of code 2015 dag 1,2,3 ... :))
