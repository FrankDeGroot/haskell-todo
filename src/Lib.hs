module Lib
    ( doCommand
    ) where

import System.Environment
import System.Directory
import System.IO
import System.IO.Temp
import Data.List

doCommand :: IO ()
doCommand = do
    (command:args) <- getArgs
    let (Just action) = lookup command dispatch
    action args
  
dispatch :: [(String, [String] -> IO ())]  
dispatch =  [ ("add", add)  
            , ("view", view)  
            , ("remove", remove)  
            ]

add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")

view :: [String] -> IO ()
view [fileName] = do
    contents <- readFile fileName
    let todoTasks = lines contents
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
    putStr $ unlines numberedTasks

remove :: [String] -> IO ()
remove [fileName, numberString] = do
    contents <- readFile fileName
    let number = read numberString
        todoTasks = lines contents
        newTodoItems = delete (todoTasks !! number) todoTasks
        newContents = unlines newTodoItems
    tempName <- writeTempFile "." "temp" newContents
    removeFile fileName
    renameFile tempName fileName    
