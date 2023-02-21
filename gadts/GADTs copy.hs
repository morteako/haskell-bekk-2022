{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE LambdaCase #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

data Nat = Z | S Nat

data Fin (n :: Nat) where
    FZ :: Fin n
    FS :: Fin n -> Fin (S n)

f :: Fin (S (S Z)) -> Int
f FZ = 0
f (FS FZ) = 1
f (FS (FS _)) = 2 -- hmm

-- exp

data Exp a where
    Var :: String -> Exp Int
    ILit :: Int -> Exp Int
    BLit :: Bool -> Exp Bool
    Add :: Exp Int -> Exp Int -> Exp Int
    LTExp :: Ord a => Exp a -> Exp a -> Exp Bool
    If :: Exp Bool -> Exp a -> Exp a -> Exp a

eval :: (String -> Int) -> Exp a -> a
eval env (Var s) = env s
eval env (ILit s) = s
eval env (BLit s) = s
eval env (Add a b) = eval env a + eval env b
eval env (LTExp a b) = eval env a < eval env b
eval env (If t a b) = if eval env t then eval env a else eval env b

-- existentials
data TypeRep a

data Dynamic where
    Dyn :: TypeRep a -> a -> Dynamic

data Unhid a where
    Unhid :: (String -> a) -> (a -> String) -> Unhid a

sUnhid :: Unhid a -> String -> String
sUnhid (Unhid sa as) s = as $ sa s

data Hid where
    Hid :: (String -> a) -> (a -> String) -> Hid

sHid :: Hid -> String -> String
sHid (Hid sa as) s = as $ sa s

-- existentials
data Showable where
    Showable :: Show a => a -> Showable

ys = map (\case (Showable a) -> show a) [Showable 1, Showable "hei"]

---- REAL WORLD
data CompanyInformation
data AuthorizedRepresentative
data BeneficialOwner

data CompanyInformationMsg
data AuthorizedRepresentativeMsg
data BeneficialOwnerMsg

data CompanyInformationModel a
data AuthorizedRepresentativeModel
data BeneficialOwnerModel a

data Msg a where
    CompanyInformationMessage :: CompanyInformationMsg -> Msg CompanyInformation
    AuthorizedRepresentativeMessage :: AuthorizedRepresentativeMsg -> Msg AuthorizedRepresentative
    BeneficialOwnerMessage :: AuthorizedRepresentative -> Msg BeneficialOwner

data Step a where
    CompanyInformationStep :: (CompanyInformationModel Msg) -> Step CompanyInformation
    AuthorizedRepresentativeStep :: AuthorizedRepresentativeModel -> Step AuthorizedRepresentative
    BeneficialOwnerStep :: (BeneficialOwnerModel Msg) -> Step BeneficialOwner

data Cmd a

updateStep :: Msg a -> Step a -> (Step a, Cmd Msg)
updateStep msg page =
    case (msg, page) of
        (CompanyInformationMessage subMsg, CompanyInformationStep subModel) ->
            undefined
        (AuthorizedRepresentativeMessage subMsg, AuthorizedRepresentativeStep subModel) ->
            undefined
        (BeneficialOwnerMessage subMsg, BeneficialOwnerStep subModel) ->
            undefined

data MsgN
    = CompanyInformationMessageN CompanyInformationMsg
    | AuthorizedRepresentativeMessageN AuthorizedRepresentativeMsg
    | BeneficialOwnerMessageN AuthorizedRepresentative

data StepN
    = CompanyInformationStepN (CompanyInformationModel Msg)
    | AuthorizedRepresentativeStepN AuthorizedRepresentativeModel
    | BeneficialOwnerStepN (BeneficialOwnerModel Msg)

updateStepN :: MsgN -> StepN -> (Step a, Cmd Msg)
updateStepN msg page =
    case (msg, page) of
        (CompanyInformationMessageN subMsg, CompanyInformationStepN subModel) ->
            undefined
        (AuthorizedRepresentativeMessageN subMsg, AuthorizedRepresentativeStepN subModel) ->
            undefined
        (BeneficialOwnerMessageN subMsg, BeneficialOwnerStepN subModel) ->
            undefined
        -- av 3*3=9 caser, så er er bare 3 gyldige
        -- hvis det hadde vært 10 steps og msgs, så hadde kun vært 10 av 100 gyldige
        _ -> undefined

---
