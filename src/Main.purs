module Main where

import Prelude  

import Effect.Console as Console
import HTTPure as HTTPure

main = 
  HTTPure.serve 8080 router $ Console.log "Server now port 8080"
  where
    router _ = HTTPure.ok "Hello world"