{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE LambdaCase #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............

data IntOrString a where
    MyInt :: Int -> IntOrString Int
    MyString :: String -> IntOrString String

getInt :: IntOrString Int -> Int
getInt (MyInt i) = i

getString :: IntOrString String -> String
getString (MyString i) = i

getVal :: IntOrString a -> a
getVal (MyInt i) = i
getVal (MyString s) = s

--
-- data Maybe' a = Nothing | Just a

data Maybe'' b a where
    Nothing' :: Maybe'' Int a
    Just' :: a -> Maybe'' String a

withDefault :: Maybe a -> a -> a
withDefault Nothing a = a
withDefault (Just b) _ = b

data M a = M

data Void

mex :: M Void
mex = M

mint = Just' 1

mstring = Just' "he"

get :: Maybe'' String a -> a
get (Just' a) = a

-- withDefault' :: Maybe'' -> a -> a
-- withDefault' Nothing' a = a
-- withDefault' (Just' b) _ = b
-- type Isak = IntOrString Bool

-- v = undefined :: Isak

-- exp

data Exp a where
    Lit :: Int -> Exp Int
    LitB :: Bool -> Exp Bool
    Add :: Exp Int -> Exp Int -> Exp Int
    If :: Exp Bool -> Exp Int -> Exp Int -> Exp Int

eval :: Exp Int -> Int
eval (Lit i) = i
eval (Add a b) = eval a + eval b
eval (If (LitB b) t f) = if b then eval t else eval f

-- data Exp a

-- eval :: (String -> Int) -> Exp a -> a
-- eval = undefined

-- existentials

-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............
-- ..............

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
