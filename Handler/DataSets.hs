{-# LANGUAGE OverloadedStrings #-}
module Handler.DataSets where

import Import
import qualified Database.Esqueleto as E
import Database.Esqueleto ((^.))
import Response

getDataSetsR :: Handler Value
getDataSetsR = do
    sets <- runDB $ E.select $ E.from $ \(d `E.InnerJoin` a) -> do
        E.on (d ^. DataSetAuthorId E.==. a ^.AuthorId)
        return (d, a)
    let res = map (uncurry toDataSetResponse) sets
    return $ object ["datasets" .= res]

