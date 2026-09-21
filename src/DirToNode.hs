module DirToNode where

import Control.Monad (forM)
import Data.List (sort)
import NodeTypes
import System.Directory (doesDirectoryExist, doesFileExist, listDirectory)
import System.FilePath (takeFileName, (</>))

dirToNode :: FilePath -> IO Node
dirToNode path = do
  entries <- listDirectory path
  children <- forM (sort entries) $ \entry -> do
    let fullPath = path </> entry
    isDir <- doesDirectoryExist fullPath
    if isDir
      then dirToNode fullPath
      else do
        isFile <- doesFileExist fullPath
        if isFile
          then return (File entry fullPath)
          else error $ "Unsupported filesystem entry: " ++ fullPath
  return $ Directory (takeFileName path) path children
