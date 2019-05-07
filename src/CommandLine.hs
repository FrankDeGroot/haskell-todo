module CommandLine
    ( doCommand
    ) where

import System.Environment (getArgs)

import CommandLine.IO (add, view, remove)

doCommand :: IO ()
doCommand = do
  args <- getArgs
  case args of
    (command:options) ->
      case lookup command dispatch of
        (Just action) -> action options
        _ -> putStrLn "Usage: (add|view|remove) (options)"
    _ -> putStrLn "Usage: (add|view|remove) (options)"

dispatch :: [(String, [String] -> IO ())]
dispatch = [ ("add", add)  
           , ("view", view)  
           , ("remove", remove)  
           ]
