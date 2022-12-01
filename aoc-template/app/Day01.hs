module Day01 where

parse = id

solveA = id

solveB = id

main :: IO ()
main = do
  xs <- readFile "inputs/1"

  let parsed = parse xs
  print parsed

  let resA = solveA parsed
  print resA

  let resB = solveB parsed
  print resB
