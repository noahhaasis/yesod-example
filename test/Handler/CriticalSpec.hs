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

        it "assert post fails for unkown user" $ do
          userEntity <- createUser "Turing"
          authenticateAs userEntity

          request $ do
            addPostParam "username" "Alan"
            setMethod "POST"
            setUrl CriticalR
          statusIs 403

        it "assert post fails if user is not the manager" $ do
          userEntity <- createUser "Turing"
          authenticateAs userEntity

          _ <- createUser "Alan"

          request $ do
            addPostParam "username" "Alan"
            setMethod "POST"
            setUrl CriticalR
          statusIs 403

        it "assert post is successfull when logged in as manager" $ do
          userEntity <- createUser "Turing"
          authenticateAs userEntity

          _ <- createUserWithManager "Alan" (entityKey userEntity)

          request $ do
            addPostParam "username" "Alan"
            setMethod "POST"
            setUrl CriticalR
          statusIs 200

        it "assert post works for manager of manager" $ do
          userEntity <- createUser "Turing"
          authenticateAs userEntity

          middleUser <- createUserWithManager "Goedel" (entityKey userEntity)

          _ <- createUserWithManager "Alan" (entityKey middleUser)

          request $ do
            addPostParam "username" "Alan"
            setMethod "POST"
            setUrl CriticalR
          statusIs 200
