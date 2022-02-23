# Møte 2 : Typer

## Parametric polymorphishm . Gjelder for alle typer
# Typeparameter

intsLength :: [Int] -> Int

charsLength :: [Char] -> Int

allLength :: [a] -> Int
--allLength :: forall a . [a] -> Int

--kan da instansiere allLength med spesifikke typer

-- bruke @Int

id :: a -> a

fst :: (a,b) -> a

-- Ikke noe instanceof i Haskell, så gir garantier


## Forskjellig oppførsel for hver type

### == : equals 

-- lett å lage en 
boolEq :: Bool -> Bool -> Bool

stringEq :: String -> String -> Bool

men hva med 

eq :: a -> a -> Bool

Hvorfor funker ikke det?

Det er på en måte det motsatte av det vi vil ha


Vi trenger en slags interface Eq

type class Eq

instance


### Show


### Superklasser : Ord

Refleksiv
Transetiv
Antisymmetrisk : a <= b og b <= a, da er a == b

### Minimal

### Read

==   <---> /=

### Monoids

fold :: (a -> a -> a) -> a -> [a] -> a

-- fold (++) []
-- fold (+) 0
-- fold (*) 1
-- fold min INT_MAX
-- fold (\(a1,a2) (b1,b2) -> (a1+b1,min a2 b2)) (0, INT_MAX)




### Semigroups 

Ikke alle typer har identitets













