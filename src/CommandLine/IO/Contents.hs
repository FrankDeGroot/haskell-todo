module CommandLine.IO.Contents
  ( viewContents
  , removeFromContents
  ) where

import Data.List (delete)

viewContents :: String -> String
viewContents contents =
  let todoTasks = lines contents
      numberedTasks = zipWith viewLine [0..] todoTasks
      in unlines numberedTasks

viewLine :: Int -> String -> String
viewLine n line = show n ++ " - " ++ line

removeFromContents :: String -> String -> String
removeFromContents contents numberString =
  let number = read numberString
      todoTasks = lines contents
      newTodoItems = delete (todoTasks !! number) todoTasks
      in unlines newTodoItems
