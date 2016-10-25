{-# LANGUAGE OverloadedStrings #-}
module Models where

import Data.Aeson (ToJSON, toJSON, object, (.=))
import Data.Text
import qualified Database.PostgreSQL.Simple as PG
import Database.PostgreSQL.Simple.FromRow (FromRow, fromRow, field)

type ID = Int

class Queryable a where
    fetchCollection :: PG.Connection -> IO [a]
    fetchSingle     :: PG.Connection -> ID -> IO (Maybe a)

fetchAll :: (FromRow a) => PG.Query -> PG.Connection -> IO [a]
fetchAll q conn = do
    result <- PG.query_ conn q
    return result

fetchById :: (FromRow a, Eq a) => PG.Query -> PG.Connection -> ID -> IO (Maybe a)
fetchById q conn id = do
    result <- PG.query conn q (PG.Only id)
    if result == []
      then return Nothing
      else return $ Just $ Prelude.head result

data User = User
  { userId        :: Int
  , userName      :: Text
  } deriving (Eq, Show)

instance ToJSON User where
  toJSON (User id name) =
    object ["id" .= id, "name" .= name]

instance FromRow User where
  fromRow = User <$> field <*> field

instance Queryable User where
  fetchCollection = fetchAll "SELECT * FROM users"
  fetchSingle = fetchById "SELECT * FROM users WHERE id = ?"

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

instance Queryable Game where
  fetchCollection = fetchAll "SELECT * FROM games"
  fetchSingle = fetchById "SELECT * FROM games WHERE id = ?"

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

instance Queryable Genre where
  fetchCollection = fetchAll "SELECT * FROM genres"
  fetchSingle = fetchById "SELECT * FROM genres WHERE id = ?"

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

instance Queryable Session where
  fetchCollection = fetchAll "SELECT * FROM sessions"
  fetchSingle = fetchById "SELECT * FROM sessions WHERE id = ?"

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
