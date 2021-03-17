{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
module Handler.Critical where

import Import

getCriticalR :: Handler Html
getCriticalR = do
  defaultLayout $ do
      setTitle $ toHtml "Critical site"
      $(widgetFile "critical")

postCriticalR :: Handler Html
postCriticalR = do
  defaultLayout $ do
    toWidgetBody
        [hamlet|<p>Performed critical action|]


-- TODO: Add a post to modify a user
--       which requires manager rights
