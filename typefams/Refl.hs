{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}

data a :~: b where
    Refl :: a :~: a

---
symmetric :: a :~: b -> b :~: a
symmetric Refl = Refl

transetive :: a :~: b -> b :~: c -> a :~: c
transetive Refl Refl = Refl

cong :: a :~: b -> f a :~: f b
cong Refl = Refl

outer :: f a :~: g a -> f :~: g
outer Refl = Refl

inner :: f a :~: g b -> a :~: b
inner Refl = Refl

castWith :: (a :~: b) -> a -> b
castWith Refl a = a

data Nat = Z | S Nat

type family a + b where
    Z + b = b
    S n + b = S (n + b)

-- type family a + b where
--     Z + b = b
--     S n + b = S (n + b)

zeroIdentityL :: a :~: (Z + a)
zeroIdentityL = Refl

zeroIdentityR :: forall a. SNat a -> a :~: (a + Z)
zeroIdentityR SZ = Refl
zeroIdentityR (SS n) = cong q
  where
    q = zeroIdentityR n

-- commutative :: SNat a -> SNat a -> a :~: (a + Z)

data SNat s where
    SZ :: SNat Z
    SS :: SNat n -> SNat (S n)

deriving instance Show (SNat Z)
deriving instance Show (SNat n) => Show (SNat (S n))

class FromNat (s :: Nat) where
    toSNat :: SNat s

instance FromNat Z where
    toSNat = SZ

instance FromNat n => FromNat (S n) where
    toSNat = SS toSNat
