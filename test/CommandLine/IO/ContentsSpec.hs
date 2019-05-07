module CommandLine.IO.ContentsSpec
    ( contentsSpec
    ) where

import Test.HUnit (assertEqual)

import CommandLine.IO.Contents (viewContents, removeFromContents)

contentsSpec = do
  assertEqual "viewContents" "0 - this\n1 - that\n" $ viewContents "this\nthat\n" 
  assertEqual "removeFromContents" "this\nthat\n" $ removeFromContents "this\nsuch\nthat\n" "1"
