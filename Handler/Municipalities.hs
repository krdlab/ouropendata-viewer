module Handler.Municipalities where

import Import

getMunicipalitiesR :: Handler Value
getMunicipalitiesR = do
    ms <- runDB $ selectList [] [] :: Handler [Entity Municipality]
    return $ object ["municipalities" .= ms]

