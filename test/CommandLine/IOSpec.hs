module CommandLine.IOSpec
  ( ioSpec
  ) where

import System.Directory (removeFile)
import System.IO.Temp (writeTempFile)
import Test.HUnit (assertEqual)

import CommandLine.IO (add, remove, view)

ioSpec :: IO ()
ioSpec = do
  tempFixture "" $ \tempName -> do
    add [tempName, "test"]
    addResult <- readFile tempName
    assertEqual "add test" "test\n" addResult
  -- TODO use hPutStrLn in view instead, then send to stdout?
  -- tempFixture "this\nthat\n" $ \tempName -> do
  --   view [tempName]
  --   assertEqual "view test" "0 - this\n1 - that\n" viewResult
  tempFixture "this\nthat\n" $ \tempName -> do
    remove [tempName, "0"]
    removeResult <- readFile tempName
    assertEqual "remove test" "that\n" removeResult

tempFixture :: String -> (String -> IO ()) -> IO ()
tempFixture contents action = do
  tempName <- writeTempFile "." "temp" contents
  action tempName
  removeFile tempName
