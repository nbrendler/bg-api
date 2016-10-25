{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}


module App
    ( startApp
    ) where

import Control.Monad (foldM)
import Control.Monad.IO.Class (liftIO)

import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import qualified Database.PostgreSQL.Simple as PG

import Api
import Models

startApp :: IO ()
startApp = mkApp >>= run 8080

app :: PG.Connection -> Application
app conn = serve api $ server conn

server :: PG.Connection -> Server API
server conn =
        userList
  :<|>  userFetch
  :<|>  gameList
  :<|>  gameFetch
  :<|>  genreList
  :<|>  genreFetch
  :<|>  sessionList
  :<|>  sessionFetch
  where
    userList = liftIO $ fetchCollection conn
    userFetch id = liftIO $ fetchSingle conn id
    gameList = liftIO $ fetchCollection conn
    gameFetch id = liftIO $ fetchSingle conn id
    genreList = liftIO $ fetchCollection conn
    genreFetch id = liftIO $ fetchSingle conn id
    sessionList = liftIO $ fetchCollection conn
    sessionFetch id = liftIO $ fetchSingle conn id

mkApp :: IO Application
mkApp = do
    conn <- PG.connect PG.defaultConnectInfo { PG.connectDatabase="bg" }
    return $ app conn
