{ name = "msgpack-msgpack"
, dependencies =
  [ "aff"
  , "argonaut-codecs"
  , "argonaut-core"
  , "arraybuffer"
  , "arraybuffer-types"
  , "arrays"
  , "bifunctors"
  , "effect"
  , "either"
  , "exceptions"
  , "prelude"
  , "spec"
  , "strings"
  , "uint"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
