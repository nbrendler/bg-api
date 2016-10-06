{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TypeOperators   #-}

module Api where

import Data.Proxy
import Servant.API

import Models

type API =
       "users"    :> Get '[JSON] [User]
  :<|> "games"    :> Get '[JSON] [Game]
  :<|> "genres"   :> Get '[JSON] [Genre]
  :<|> "sessions" :> Get '[JSON] [Session]

api :: Proxy API
api = Proxy
