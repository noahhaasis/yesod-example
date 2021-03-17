{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
module Handler.CriticalSpec (spec) where

import TestImport

spec :: Spec
spec = withApp $ do

    describe "Critical page" $ do
        it "assert get access for anonymous user" $ do
            get CriticalR
            statusIs 200

        it "assert post fails for anonymous user" $ do
          post CriticalR
          statusIs 403
