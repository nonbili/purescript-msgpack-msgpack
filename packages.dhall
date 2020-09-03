let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.13.8-20200831/packages.dhall sha256:cdb3529cac2cd8dd780f07c80fd907d5faceae7decfcaa11a12037df68812c83

let nonbili =
      https://github.com/nonbili/package-sets/releases/download/v0.7/packages.dhall sha256:b09c8d62a7a1e04fd150d32d80f575c0f1e6d82f2dc2a763eb4271cdb61a154d

let overrides = {=}

let additions = {=}

in  upstream // nonbili // overrides // additions
