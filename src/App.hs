module App
    ( startApp
    ) where

import Network.Wai
import Network.Wai.Handler.Warp
import Servant

import Api
import Models

users :: [User]
users = [
  User 1 "Guy" "Somebody",
  User 2 "Mr" "Dudeman"
  ]

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve api server

server :: Server API
server = return users
