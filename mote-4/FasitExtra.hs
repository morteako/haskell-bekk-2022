{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE RankNTypes #-}

module FunctorsExtra where

import Prelude hiding (Functor, fmap)

class MyFunctor (f :: * -> *) where
    fmap :: (a -> b) -> f a -> f b

-- | puts a value into the functor
-- >>> setValue 1 Nothing
-- Nothing
-- >>> setValue 1 (Just "hei")
-- Just 1
-- >>> setValue "a" [True,False]
-- ["a","a"]
setValue :: MyFunctor f => a -> f b -> f a
setValue x = fmap (\_ -> x)

data State s a = State (s -> (a, s))

instance MyFunctor (State s) where
    fmap f (State sf) = State (\s -> let (a, s') = sf s in (f a, s'))

data Identity a = Identity a

data Const a b = Const a

data Compose f g a = Compose (f (g a))

instance MyFunctor Identity where
    fmap f (Identity a) = Identity (f a)

instance MyFunctor (Const a) where
    fmap f (Const c) = Const c

instance (MyFunctor f, MyFunctor g) => MyFunctor (Compose f g) where
    fmap f (Compose fga) = Compose (fmap (fmap f) fga)

-- Veldig vanskelig

-- Lens stuff
type Lens s t a b = forall f. MyFunctor f => (a -> f b) -> s -> f t

_identity :: Lens (Identity a) (Identity b) a b
_identity afb (Identity a) = fmap Identity $ afb a

-- | Oppgave : implementer view . Her gjelder det å bruke riktig Functor
-- >>> view _identity (Identity 1)
-- 1
view :: Lens s s a a -> s -> a
view lens s = let Const a = lens Const s in a

_1 :: Lens (a, c) (b, c) a b
_1 a2fb (a, c) = fmap (\x -> (x, c)) (a2fb a)

-- | Oppgave  : implementer _2 (samme som _1, bare for verdi nr 2)
-- >>> view _2 ("hei",1)
-- 1
_2 :: Lens (c, a) (c, b) a b
_2 a2fb (c, a) = fmap (\x -> (c, x)) (a2fb a)
