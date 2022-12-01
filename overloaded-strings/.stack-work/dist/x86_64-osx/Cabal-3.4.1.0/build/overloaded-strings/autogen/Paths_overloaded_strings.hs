{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_overloaded_strings (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
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
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/mortenkolstad/haskell-bekk-2022/overloaded-strings/.stack-work/install/x86_64-osx/5135fa68917e29cf523ec689c8206c3b4d6f76bf383190422909900984d7e1fc/9.0.2/bin"
libdir     = "/Users/mortenkolstad/haskell-bekk-2022/overloaded-strings/.stack-work/install/x86_64-osx/5135fa68917e29cf523ec689c8206c3b4d6f76bf383190422909900984d7e1fc/9.0.2/lib/x86_64-osx-ghc-9.0.2/overloaded-strings-0.1.0.0-FABoLtJDWQZ4ilZR4aHBYB-overloaded-strings"
dynlibdir  = "/Users/mortenkolstad/haskell-bekk-2022/overloaded-strings/.stack-work/install/x86_64-osx/5135fa68917e29cf523ec689c8206c3b4d6f76bf383190422909900984d7e1fc/9.0.2/lib/x86_64-osx-ghc-9.0.2"
datadir    = "/Users/mortenkolstad/haskell-bekk-2022/overloaded-strings/.stack-work/install/x86_64-osx/5135fa68917e29cf523ec689c8206c3b4d6f76bf383190422909900984d7e1fc/9.0.2/share/x86_64-osx-ghc-9.0.2/overloaded-strings-0.1.0.0"
libexecdir = "/Users/mortenkolstad/haskell-bekk-2022/overloaded-strings/.stack-work/install/x86_64-osx/5135fa68917e29cf523ec689c8206c3b4d6f76bf383190422909900984d7e1fc/9.0.2/libexec/x86_64-osx-ghc-9.0.2/overloaded-strings-0.1.0.0"
sysconfdir = "/Users/mortenkolstad/haskell-bekk-2022/overloaded-strings/.stack-work/install/x86_64-osx/5135fa68917e29cf523ec689c8206c3b4d6f76bf383190422909900984d7e1fc/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "overloaded_strings_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "overloaded_strings_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "overloaded_strings_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "overloaded_strings_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "overloaded_strings_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "overloaded_strings_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
