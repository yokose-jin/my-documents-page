module DirToNode where

import Control.Monad (forM)
import Data.List (sort)
import Data.Maybe (catMaybes)
import NodeTypes
import System.Directory (doesDirectoryExist, doesFileExist, listDirectory)
import System.FilePath (takeExtension, takeFileName, (</>))

dirToNode :: FilePath -> IO Node
dirToNode path = do
  entries <- listDirectory path
  children <- fmap catMaybes $ forM (sort entries) $ \entry -> do
    let fullPath = path </> entry
    isDir <- doesDirectoryExist fullPath
    if isDir
      then Just <$> dirToNode fullPath
      else do
        isFile <- doesFileExist fullPath
        if isFile && takeExtension entry == ".pdf"
          then return $ Just (File entry fullPath)
          else return Nothing
  return $ Directory (takeFileName path) path children