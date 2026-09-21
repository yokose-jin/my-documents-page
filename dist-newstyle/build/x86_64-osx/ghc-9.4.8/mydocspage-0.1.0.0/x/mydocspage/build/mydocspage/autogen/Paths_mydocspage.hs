{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_mydocspage (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/jin/.cabal/bin"
libdir     = "/Users/jin/.cabal/lib/x86_64-osx-ghc-9.4.8/mydocspage-0.1.0.0-inplace-mydocspage"
dynlibdir  = "/Users/jin/.cabal/lib/x86_64-osx-ghc-9.4.8"
datadir    = "/Users/jin/.cabal/share/x86_64-osx-ghc-9.4.8/mydocspage-0.1.0.0"
libexecdir = "/Users/jin/.cabal/libexec/x86_64-osx-ghc-9.4.8/mydocspage-0.1.0.0"
sysconfdir = "/Users/jin/.cabal/etc"

getBinDir     = catchIO (getEnv "mydocspage_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "mydocspage_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "mydocspage_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "mydocspage_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "mydocspage_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "mydocspage_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
