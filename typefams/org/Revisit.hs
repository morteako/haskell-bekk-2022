{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

module Revisit where

import Prelude hiding (zip)

data Nat = Z | S Nat

data Vector (n :: Nat) (a :: *) where
    VNil :: Vector Z a
    VCons :: a -> Vector m a -> Vector (S m) a

append :: Vector n a -> Vector m a -> Vector (n + m) a
append VNil ys = ys
append (VCons x xs) ys = VCons x (append xs ys)

type family a + b where
    Z + b = b
    S n + b = S (n + b)

r = append (VCons 1 VNil) (VCons 2 VNil)
