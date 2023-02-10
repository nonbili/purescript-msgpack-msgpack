module Test.Main (main) where

import Prelude

import Data.Array as Array
import Data.ArrayBuffer.Typed as TypedArray
import Data.Bifunctor (lmap)
import Data.Char as Char
import Data.Either (Either(..))
import Data.String.CodeUnits as CodeUnits
import Data.UInt as UInt
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Msgpack as Msgpack
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (runSpec)

obj :: { x :: Int }
obj = { x: 1 }

str :: String
str =
  CodeUnits.fromCharArray $ Array.mapMaybe Char.fromCharCode
    [ 129, 161, 120, 1 ]

main :: Effect Unit
main = do
  uint8Arr <- TypedArray.fromArray (UInt.fromInt <$> [ 129, 161, 120, 1 ])
  launchAff_ $ runSpec [consoleReporter] do
    describe "spec" $ do
      it "encode" $ do
        result <- liftEffect (TypedArray.eq (Msgpack.encode obj) uint8Arr)
        result `shouldEqual` true

      it "decode" $ do
        (lmap show $ Msgpack.decode uint8Arr) `shouldEqual` (Right obj)

      it "encode'" $ do
        (Msgpack.encode' obj) `shouldEqual` str

      it "decode'" $ do
        (lmap show $ Msgpack.decode' str) `shouldEqual` (Right obj)
