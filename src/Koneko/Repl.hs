--  --                                                          ; {{{1
--
--  File        : Koneko/Repl.hs
--  Maintainer  : Felix C. Stegerman <flx@obfusk.net>
--  Date        : 2020-01-30
--
--  Copyright   : Copyright (C) 2020  Felix C. Stegerman
--  Version     : v0.0.1
--  License     : GPLv3+
--
--  --                                                          ; }}}1

{-# LANGUAGE OverloadedStrings #-}

module Koneko.Repl (repl, repl', promptText, errorText) where

import Control.Monad (unless)
import Data.String (IsString)
import Data.Text.Lazy (Text)
import System.IO (hPutStrLn, stderr)

import qualified Data.Text.Lazy as T
import qualified Data.Text.Lazy.IO as T

import Koneko.Data (Context, Stack)
import Koneko.Eval (evalText, tryK)
import Koneko.Misc (prompt)
import Koneko.Prim (replDef)

-- TODO: readline? or just rlwrap?

repl :: Context -> Stack -> IO ()
repl c s = () <$ repl' False promptText c s

-- | NB: when an exception is caught during the evaluation of a line,
-- the exeption is printed and the repl continues with the stack reset
-- to what it was before that line; however, any definitions that were
-- added to a module before the exception occurred will have taken
-- effect.
repl' :: Bool -> Text -> Context -> Stack -> IO Stack
repl' breakOnError pr ctx st = replDef ctx >> loop ctx st
  where
    loop :: Context -> Stack -> IO Stack
    loop c s = prompt (Just pr) >>= maybe (s <$ T.putStrLn "") f
      where
        f line = if T.null line then loop c s else do
          r <- tryK $ evalText "(repl)" line c s
          let err e = do  hPutStrLn stderr $ errorText ++ show e
                          if breakOnError then return s else loop c s
              ok s' = do  unless (shouldSkip s' line) $       --  TODO
                            putStrLn $ show $ head s'         -- safe!
                          loop c s'
          either err ok r

shouldSkip :: Stack -> Text -> Bool
shouldSkip s line = null s || T.head line `elem` [',',';']    -- safe!

promptText, errorText :: IsString s => s
promptText  = ">>> "
errorText   = "*** ERROR: "

-- vim: set tw=70 sw=2 sts=2 et fdm=marker :
