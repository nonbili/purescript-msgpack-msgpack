module Test.Main where

import Prelude

import Data.Array as Array
import Data.ArrayBuffer.Typed as TypedArray
import Data.Bifunctor (lmap)
import Data.Char as Char
import Data.Either (Either(..))
import Data.String.CodeUnits as CodeUnits
import Data.UInt as UInt
import Effect (Effect)
import Effect.Class (liftEffect)
import Jest (expectToBeTrue, expectToEqual, test)
import Msgpack as Msgpack

obj :: { x :: Int }
obj = { x: 1 }

str :: String
str =
  CodeUnits.fromCharArray $ Array.mapMaybe Char.fromCharCode
    [ 129, 161, 120, 1 ]

main :: Effect Unit
main = do
  uint8Arr <- TypedArray.fromArray $ UInt.fromInt <$> [ 129, 161, 120, 1 ]

  test "encode" $ do
    expectToBeTrue =<< liftEffect (TypedArray.eq (Msgpack.encode obj) uint8Arr)

  test "decode" $ do
    expectToEqual (lmap show $ Msgpack.decode uint8Arr) (Right obj)

  test "encode'" $ do
    expectToEqual (Msgpack.encode' obj) str

  test "decode'" $ do
    expectToEqual (lmap show $ Msgpack.decode' str) (Right obj)
