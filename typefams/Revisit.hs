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

append :: Vector n a -> Vector m a -> Vector w a
append = undefined

-- r = append (VCons 1 VNil) (VCons 2 VNil)
