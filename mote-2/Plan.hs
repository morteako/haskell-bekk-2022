-- # Møte 2 : Typer

-- ## Parametric polymorphishm . Gjelder for alle typer
-- # Typeparameter

intsLength :: [Int] -> Int
intsLength = undefined

charsLength :: [Char] -> Int
charsLength = undefined

allLength :: [a] -> Int
allLength = undefined
--allLength :: forall a . [a] -> Int

--kan da instansiere allLength med spesifikke typer

-- bruke @Int

id :: a -> a
id = undefined

fst :: (a,b) -> a
fst = undefined

-- Ikke noe instanceof i Haskell, så gir garantier


-- ## Forskjellig oppførsel for hver type

-- ### == : equals 

-- lett å lage en 
boolEq :: Bool -> Bool -> Bool
boolEq = undefined

stringEq :: String -> String -> Bool
stringEq = undefined

-- men hva med en generell likhetssjekk. Da må vi ha generelle typer, altså typeparametere

eq :: a -> a -> Bool
eq = undefined

-- Hvorfor funker ikke det?

-- Det er på en måte det motsatte av det vi vil ha


-- Vi trenger en slags interface Eq

-- type class Eq

-- instance



-- ### Show


-- ### Superklasser : Ord


-- ### Minimal

-- ==   <---> /=

-- ### Egenskaper

-- Ord
-- Refleksiv
-- Transetiv
-- Antisymmetrisk : a <= b og b <= a, da er a == b

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







