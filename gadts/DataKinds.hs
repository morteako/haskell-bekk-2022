{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE LambdaCase #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

data Nat = Z | S Nat

n :: Nat
n = Z

type N = Z

natVal :: Nat
natVal = Z

data Proxy a = Proxy

data LT (n :: Nat) (m :: Nat) where
    LTZ :: LT Z (S m)
    LTS :: LT n m -> LT (S n) (S m)

enMindreTo :: LT ('S 'Z) ('S ('S Z))
enMindreTo = LTS LTZ

data Fin (n :: Nat) where
    FZ :: Fin (S n)
    FS :: Fin n -> Fin (S n)

-- max3 :: Fin (S (S (S Z)))
-- max3 = FS $ FS $ FS FZ
-- max#

-- lengthOfShortVector :: LT n (S (S Z)) -> Vector n a -> Int
-- lengthOfShortVector LTZ VNil = 0
-- lengthOfShortVector (LTS lt) (VCons _ VNil) = 1
-- -- lengthOfShortVector (LTS lt) (VCons _ VNil) = 1

data Vector (n :: Nat) (a :: *) where
    VNil :: Vector n a
    VCons :: a -> Vector m a -> Vector (S m) a

-- append :: Vector n a -> Vector m a -> Vector (n+m) a
-- append = undefined
-- v0 = VNil

-- v1 :: Vector (S (S Z)) String
-- v1 = VCons "a" VNil

-- vhead :: Vector (S n) a -> a
-- vhead (VCons a _) = a

-- vtail :: Vector (S n) a -> Vector n a
-- vtail (VCons a xs) = VCons a xs

-- list
data HList (xs :: [*]) where
    HNil :: HList '[]
    HCons :: a -> HList xs -> HList (a : xs)

data Person = Person {alder :: Int, navn :: String, cool :: Bool}

pAlder :: Int -> HList xs -> HList (Int : xs)
pAlder = HCons

pNavn :: String -> HList xs -> HList (String : xs)
pNavn = HCons

pCool :: Bool -> HList xs -> HList (Bool : xs)
pCool = HCons

makePerson :: HList [Int, String, Bool] -> Person
makePerson (HCons a (HCons navn (HCons b HNil))) = Person{alder = a, navn = navn, cool = b}

p :: HList '[Int, String, Bool]
p =
    pAlder 0 $ pNavn "hei" $ pCool False HNil

person = makePerson p

-- intAndString :: HList '[Integer, String]
-- intAndString = HCons 5 $ HCons True HNil

swap :: HList (a : b : xs) -> HList (b : a : xs)
swap (HCons a (HCons b xs)) = HCons b $ HCons a xs

getVal :: Elem a xs -> HList xs -> a
getVal FirstElem (HCons a _) = a
getVal (RestElem e) (HCons _ xs) = getVal e xs

data Elem a xs where
    FirstElem :: Elem a (a : ys)
    RestElem :: Elem a ys -> Elem a (b : ys)

res = getVal (RestElem FirstElem) (HCons "hei" $ HCons True $ HCons Nothing HNil)

-------------------------------------
-- tillater typed type level programming
-- forskjell

data Info a = Unvalidated Int | Invalid Int | Valid Int

data IValid

checkValid :: Info a -> Either String (Info IValid)
checkValid = undefined

sendInfoToDB :: Info IValid -> IO ()
sendInfoToDB = undefined

-- dummy1 :: Info' String -> Info' String
-- dummy1 xs = xs

data ValidationState = SValid | SInvalid | SUnvalidated

data GInfo a where
    GUnvalidated :: Int -> GInfo SUnvalidated
    GInvalid :: Int -> GInfo SInvalid
    GValid :: Int -> GInfo SValid

-- -- gir nå feil
-- dummy2 :: GInfo String -> Info String
-- dummy2 xs = xs

-- andre bonuser :
-- pattern matching
-- slipper smart-konstruktører
-- trenger ikke egen modul osv

-- kan også bruke kinds osv uten GADTs

data Info' (a :: ValidationState) = Unvalidated' Int | Invalid' Int | Valid' Int
