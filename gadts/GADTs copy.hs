{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE LambdaCase #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

data Nat = Z | S Nat

data Fin (n :: Nat) where
    FZ :: Fin (S n)
    FS :: Fin n -> Fin (S n)

f :: Fin (S (S Z)) -> Int
f FZ = 0
f (FS FZ) = 1
f (FS (FS _)) = 2 -- hmm

-- exp

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
