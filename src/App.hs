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
startApp = run 8080 =<< mkApp

app :: PG.Connection -> Application
app conn = serve api $ server conn

server :: PG.Connection -> Server API
server conn =
        userListHandler
  :<|>  gameListHandler
  :<|>  genreListHandler
  :<|>  sessionListHandler
        where
          userListHandler = liftIO $ userList
          gameListHandler = liftIO $ gameList
          genreListHandler = liftIO $ genreList
          sessionListHandler = liftIO $ sessionList

          userList :: IO ([User])
          userList = do
            result :: [User] <- PG.query_ conn "SELECT * FROM users"
            return result

          gameList :: IO ([Game])
          gameList = do
            result :: [Game] <- PG.query_ conn "SELECT * FROM games"
            return result

          genreList :: IO ([Genre])
          genreList = do
            result :: [Genre] <- PG.query_ conn "SELECT * FROM genres"
            return result

          sessionList :: IO ([Session])
          sessionList = do
            result :: [Session] <- PG.query_ conn "SELECT * FROM sessions"
            return result

mkApp :: IO Application
mkApp = do
    conn <- PG.connect PG.defaultConnectInfo { PG.connectDatabase="bg" }
    return $ app conn
