module CommandLine.IO
  ( add
  , view
  , remove
  ) where

import System.Directory (renameFile, removeFile)
import System.IO.Temp (writeTempFile)

import CommandLine.IO.Contents (removeFromContents, viewContents)

add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")
add _  = do putStrLn "Usage: add (file) (item)"

view :: [String] -> IO ()
view [fileName] = do
  contents <- readFile fileName
  putStr $ viewContents contents
view _ = do putStrLn "Usage: view (file)"

remove :: [String] -> IO ()
remove [fileName, numberString] = do
  contents <- readFile fileName
  let newContents = removeFromContents contents numberString
  tempName <- writeTempFile "." "temp" newContents
  removeFile fileName
  renameFile tempName fileName
remove _ = putStrLn "Usage: remove (file) (item #)"
