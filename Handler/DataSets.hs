{-# LANGUAGE OverloadedStrings #-}
module Handler.DataSets where

import Import

getDataSetsR :: Handler Value
getDataSetsR = do
    sets <- runDB $ selectList [] [] :: Handler [Entity DataSet]
    return $ object ["datasets" .= sets]

