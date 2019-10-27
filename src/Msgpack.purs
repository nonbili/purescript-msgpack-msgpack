module Msgpack
  ( encode
  , encode'
  , decode
  , decode'
  ) where

import Prelude

import Data.Argonaut.Core (Json)
import Data.Argonaut.Decode (class DecodeJson, decodeJson)
import Data.Argonaut.Encode (class EncodeJson, encodeJson)
import Data.ArrayBuffer.Types (Uint8Array)
import Data.Bifunctor (lmap)
import Data.Either (Either(..))
import Effect.Exception (Error, error)

foreign import encode_ :: Json -> Uint8Array
encode :: forall a. EncodeJson a => a -> Uint8Array
encode = encode_ <<< encodeJson

foreign import encodeToString_ :: Json -> String
encode' :: forall a. EncodeJson a => a -> String
encode' = encodeToString_ <<< encodeJson

foreign import decode_
  :: forall a
   . (Error -> Either Error Json)
  -> (Json -> Either Error Json)
  -> Uint8Array
  -> Either Error a

decode :: forall a. DecodeJson a => Uint8Array -> Either Error a
decode s = decode_ Left Right s >>= lmap error <<< decodeJson

foreign import decodeString_
  :: forall a
   . (Error -> Either Error Json)
  -> (Json -> Either Error Json)
  -> String
  -> Either Error a

decode' :: forall a. DecodeJson a => String -> Either Error a
decode' s = decodeString_ Left Right s >>= lmap error <<< decodeJson
