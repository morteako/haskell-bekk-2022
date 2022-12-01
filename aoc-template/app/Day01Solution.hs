module Day01 where

import Data.List (sort, sortOn)
import Data.List.Extra (splitOn)

-- readmaybe
parse :: [Char] -> [[Int]]
parse = fmap (fmap read . words) . splitOn "\n\n"

solveA :: [[Int]] -> Int
solveA = maximum . fmap sum

solveB :: [[Int]] -> Int
solveB = sum . take 3 . sortOn negate . fmap sum

main :: IO ()
main = do
  xs <- readFile "inputs/1"

  let parsed = parse xs
  -- print parsed

  let resA = solveA parsed
  print resA

  let resB = solveB parsed
  print resB
