{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_monadtrans (
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

bindir     = "/Users/mortenkolstad/haskell-bekk-2022/monadtrans/.stack-work/install/x86_64-osx/8e5709e566a98b8ee3e84bfc044ee1d129a04176030e0425c8498e5627dc5774/9.0.2/bin"
libdir     = "/Users/mortenkolstad/haskell-bekk-2022/monadtrans/.stack-work/install/x86_64-osx/8e5709e566a98b8ee3e84bfc044ee1d129a04176030e0425c8498e5627dc5774/9.0.2/lib/x86_64-osx-ghc-9.0.2/monadtrans-0.1.0.0-FLGmVPc4R7JInIB2sPtV7z-monadtrans"
dynlibdir  = "/Users/mortenkolstad/haskell-bekk-2022/monadtrans/.stack-work/install/x86_64-osx/8e5709e566a98b8ee3e84bfc044ee1d129a04176030e0425c8498e5627dc5774/9.0.2/lib/x86_64-osx-ghc-9.0.2"
datadir    = "/Users/mortenkolstad/haskell-bekk-2022/monadtrans/.stack-work/install/x86_64-osx/8e5709e566a98b8ee3e84bfc044ee1d129a04176030e0425c8498e5627dc5774/9.0.2/share/x86_64-osx-ghc-9.0.2/monadtrans-0.1.0.0"
libexecdir = "/Users/mortenkolstad/haskell-bekk-2022/monadtrans/.stack-work/install/x86_64-osx/8e5709e566a98b8ee3e84bfc044ee1d129a04176030e0425c8498e5627dc5774/9.0.2/libexec/x86_64-osx-ghc-9.0.2/monadtrans-0.1.0.0"
sysconfdir = "/Users/mortenkolstad/haskell-bekk-2022/monadtrans/.stack-work/install/x86_64-osx/8e5709e566a98b8ee3e84bfc044ee1d129a04176030e0425c8498e5627dc5774/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "monadtrans_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "monadtrans_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "monadtrans_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "monadtrans_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "monadtrans_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "monadtrans_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
