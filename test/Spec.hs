module Spec where

import CommandLine.IO.ContentsSpec (contentsSpec)
import CommandLine.IOSpec (ioSpec)

main :: IO ()
main = do
  contentsSpec
  ioSpec
