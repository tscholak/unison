module Main where

import EasyTest
import Control.Applicative
import Control.Monad

suite1 :: Test ()
suite1 = tests
  [ scope "a" ok
  , scope "b.c" ok
  , scope "b" ok
  , scope "b" . scope "c" . scope "d" $ ok
  , scope "c" ok ]

reverseTest :: Test ()
reverseTest = scope "list reversal" $ do
  nums <- listsOf [0..100] (int' 0 99)
  nums `forM_` \nums -> expect (reverse (reverse nums) == nums)

main :: IO ()
main = do
  run suite1
  runOnly "a" suite1
  runOnly "b" suite1
  runOnly "b" $ tests [suite1, scope "xyz" (crash "never run")]
  runOnly "b.c" $ tests [suite1, scope "b" (crash "never run")]
  run reverseTest
