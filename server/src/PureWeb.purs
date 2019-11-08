module PureWeb
  ( startLink
  , init
  , serverName
  , State
  )
  where

import Prelude

import PureLibrary as PureLibrary
import Data.Either (Either(..), either)
import Data.Maybe (Maybe(..), isJust, maybe)
import Effect (Effect)
import Erl.Atom (atom)
import Erl.Cowboy.Req (ReadBodyResult(..), Req, binding, readBody, setBody)
import Erl.Data.Binary (Binary)
import Erl.Data.Binary.IOData (IOData, fromBinary, toBinary)
import Erl.Data.List (List, nil, (:))
import Erl.Data.Tuple (Tuple2, tuple2)
import Pinto (ServerName(..), StartLinkResult)
import Pinto.Gen as Gen
import Simple.JSON (class WriteForeign, readJSON, writeJSON)
import Stetson (RestResult, StaticAssetLocation(..), StetsonHandler)
import Stetson as Stetson
import Stetson.Rest as Rest
import Unsafe.Coerce (unsafeCoerce)

newtype State = State {}

type PureWebStartArgs = { webPort :: Int }

serverName :: ServerName State
serverName = ServerName "pure_web"

startLink :: PureWebStartArgs -> Effect StartLinkResult
startLink args =
  Gen.startLink serverName $ init args

init :: PureWebStartArgs -> Effect State
init args = do
  Stetson.configure
    # Stetson.static "/assets/[...]" (PrivDir "pure_ps" "www/assets")
    # Stetson.static "/[...]" (PrivFile "pure_ps" "www/index.html")
    # Stetson.port args.webPort
    # Stetson.bindTo 0 0 0 0
    # Stetson.startClear "http_listener"
  pure $ State {}

