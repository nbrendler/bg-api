{-# LANGUAGE TemplateHaskell #-}
module Models where

import Data.Aeson
import Data.Aeson.TH

data User = User
  { userId        :: Int
  , userFirstName :: String
  , userLastName  :: String
  } deriving (Eq, Show)

$(deriveJSON defaultOptions ''User)
