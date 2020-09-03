{ name = "msgpack-msgpack"
, dependencies =
  [ "argonaut-codecs"
  , "arraybuffer"
  , "arraybuffer-types"
  , "debug"
  , "effect"
  , "exceptions"
  , "jest"
  , "psci-support"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
