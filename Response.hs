{-# LANGUAGE FlexibleInstances #-}
module Response where

import ClassyPrelude.Yesod
import Data.Aeson.TH
import Database.Persist.Sql (fromSqlKey)
import Model

data DataSetResponse = DataSetResponse
    { id :: Int64
    , title :: Text
    , description :: Text
    , updatedAt :: UTCTime
    , author :: Entity Author
    }

$(deriveJSON defaultOptions ''DataSetResponse)

toDataSetResponse :: Entity DataSet -> Entity Author -> DataSetResponse
toDataSetResponse d a = DataSetResponse
    { id = pk d
    , title = dataSetTitle dval
    , description = dataSetDescription dval
    , updatedAt = dataSetUpdatedAt dval
    , author = a
    }
  where
    dval = entityVal d
    pk e = fromSqlKey $ entityKey e

