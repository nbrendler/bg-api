{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TypeOperators   #-}

module Api where

import Data.Proxy
import Servant.API

import Models

type API =
    "users" :> Get '[JSON] [User]

api :: Proxy API
api = Proxy
