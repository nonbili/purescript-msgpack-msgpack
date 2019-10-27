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
import Data.ArrayBuffer.Types (ArrayBuffer)
import Data.Bifunctor (lmap)
import Data.Either (Either(..))
import Effect.Exception (Error, error)

foreign import encode_ :: Json -> ArrayBuffer
encode :: forall a. EncodeJson a => a -> ArrayBuffer
encode = encode_ <<< encodeJson

foreign import encodeToString_ :: Json -> String
encode' :: forall a. EncodeJson a => a -> String
encode' = encodeToString_ <<< encodeJson

foreign import decode_
  :: forall a
   . (Error -> Either Error Json)
  -> (Json -> Either Error Json)
  -> ArrayBuffer
  -> Either Error a

decode :: forall a. DecodeJson a => ArrayBuffer -> Either Error a
decode s = decode_ Left Right s >>= lmap error <<< decodeJson

foreign import decodeString_
  :: forall a
   . (Error -> Either Error Json)
  -> (Json -> Either Error Json)
  -> String
  -> Either Error a

decode' :: forall a. DecodeJson a => String -> Either Error a
decode' s = decodeString_ Left Right s >>= lmap error <<< decodeJson
