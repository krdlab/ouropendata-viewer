{-# LANGUAGE OverloadedStrings #-}
module Handler.DataSets where

import Import

getDataSetsR :: Handler Value
getDataSetsR = return $ object ["test" .= (["dummy1", "dummy2", "dummy3"] :: [Text])]

