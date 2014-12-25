{-# LANGUAGE FlexibleInstances #-}
module Model where

import ClassyPrelude.Yesod
import Database.Persist.Quasi
import Data.Aeson.TH

-- You can define all of your database entities in the entities file.
-- You can find more information on persistent and how to declare entities
-- at:
-- http://www.yesodweb.com/book/persistent/
share [mkPersist sqlSettings, mkMigrate "migrateAll"]
    $(persistFileWith lowerCaseSettings "config/models")

data DataSetResponse = DataSetResponse
    { title :: Text
    , description :: Text
    , updatedAt :: UTCTime
    , author :: Author
    }

$(deriveJSON defaultOptions ''DataSetResponse)

toDataSetResponse :: Entity DataSet -> Entity Author -> DataSetResponse
toDataSetResponse d a = DataSetResponse
    { title = dataSetTitle dval
    , description = dataSetDescription dval
    , updatedAt = dataSetUpdatedAt dval
    , author = entityVal a
    }
  where
    dval = entityVal d

