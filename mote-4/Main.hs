import Functor

main = do
    print ":)"

    print $ mapList show [1, 2, 3]

    print $ mapMaybe (+ 1) (Just 2)
    print $ mapMaybe (+ 1) Nothing

    print $ mapAddOne (Just 1)
    print $ mapAddOne (Right 1 :: Either String Int)

    -- print $ Nothing
    print $ deepShow [Just 1]
    print $ deepShow $ Just [1, 2, 3]
    print $ sum (2, 3)
    print $ Functor.fmap show (2, 3)
