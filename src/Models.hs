{-# LANGUAGE OverloadedStrings #-}
module Models where

import Data.Aeson (ToJSON, toJSON, object, (.=))
import Data.Text
import Database.PostgreSQL.Simple.FromRow (FromRow, fromRow, field)

data User = User
  { userId        :: Int
  , userName      :: Text
  } deriving (Eq, Show)

instance ToJSON User where
  toJSON (User id name) =
    object ["id" .= id, "name" .= name]

instance FromRow User where
  fromRow = User <$> field <*> field

data Game = Game
  { gameId          :: Int
  , gameName        :: Text
  , gameDescription :: Text
  , gameMinPlayers  :: Int
  , gameMaxPlayers  :: Int
  , gamePublisher   :: Text
  } deriving (Eq, Show)

instance ToJSON Game where
  toJSON (Game id desc min max name pub) =
    object
    [ "id"          .= id
    , "name"        .= name
    , "publisher"   .= pub
    , "description" .= desc
    , "minPlayers"  .= min
    , "maxPlayers"  .= max
    ]

instance FromRow Game where
  fromRow = Game <$> field <*> field <*> field <*> field <*> field <*> field

data Genre = Genre
  { genreId   :: Int
  , genreName :: Text
  } deriving (Eq, Show)

instance ToJSON Genre where
  toJSON (Genre id name) =
    object
    [ "id"          .= id
    , "name"        .= name
    ]

instance FromRow Genre where
  fromRow = Genre <$> field <*> field

data Session = Session
  { sessionId     :: Int
  , sessionGameId :: Int
  } deriving (Eq, Show)

instance ToJSON Session where
  toJSON (Session id game) =
    object
    [ "id"     .= id
    , "gameId" .= game
    ]

instance FromRow Session where
  fromRow = Session <$> field <*> field

data Score = Score
  { scoreUserId    :: Int
  , scoreSessionId :: Int
  , scoreScore     :: Maybe Int
  } deriving (Eq, Show)

instance ToJSON Score where
  toJSON (Score user session score) =
    object
    [ "userId"    .= user
    , "sessionId" .= session
    , "score"      .= score
    ]

instance FromRow Score where
  fromRow = Score <$> field <*> field <*> field

data Image = Image
  { imageGameId  :: Int
  , imageUrl     :: Text
  , imagePrimary :: Bool
  } deriving (Eq, Show)

instance FromRow Image where
  fromRow = Image <$> field <*> field <*> field
