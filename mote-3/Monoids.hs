-- Monoids

foldList :: (a -> a -> a) -> a -> [a] -> a
foldList f a [] = a
foldList f a (x : xs) = f x $ foldList f a xs

ex1 = foldList (+) 0 [1, 3, 5]

-- andre eksempler vi kan bruke for [Int]
-- for String ~ [Char]
-- Hva med [(Int,Int)]?
-- Hva med [Just String]?

-- Hva er felles?

--
