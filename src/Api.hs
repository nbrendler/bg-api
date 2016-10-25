{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TypeOperators   #-}

module Api where

import Data.Proxy
import Servant.API

import Models

type API =
       "users"    :> Get '[JSON] [User]
  :<|> "users"    :> Capture "id" Int :> Get '[JSON] (Maybe User)
  :<|> "games"    :> Get '[JSON] [Game]
  :<|> "games"    :> Capture "id" Int :> Get '[JSON] (Maybe Game)
  :<|> "genres"   :> Get '[JSON] [Genre]
  :<|> "genres"   :> Capture "id" Int :> Get '[JSON] (Maybe Genre)
  :<|> "sessions" :> Get '[JSON] [Session]
  :<|> "sessions" :> Capture "id" Int :> Get '[JSON] (Maybe Session)

api :: Proxy API
api = Proxy
