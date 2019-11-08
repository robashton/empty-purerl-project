module PureLibrary where

import Prelude

import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Newtype (wrap)
import Effect (Effect)
import Erl.Data.List (List)
import Pinto (ServerName(..), StartLinkResult)
import Pinto.Gen (CallResult(..))
import Pinto.Gen as Gen

type PureLibraryStartArgs = {
}

type State = {
}

serverName :: ServerName State
serverName = ServerName "pure_library"

startLink :: PureLibraryStartArgs -> Effect StartLinkResult
startLink args =
  Gen.startLink serverName $ init args

init :: PureLibraryStartArgs -> Effect State
init args = do
  pure $ {}
