let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.15.7-20230209/packages.dhall
        sha256:32885192e68e912d3370525efe51dbeb75383caf893775b81ef4fdfbfc274f82

let nonbili =
      https://github.com/nonbili/package-sets/releases/download/v0.7/packages.dhall
        sha256:b09c8d62a7a1e04fd150d32d80f575c0f1e6d82f2dc2a763eb4271cdb61a154d

let overrides = {=}

let additions = {=}

in  upstream // nonbili // overrides // additions
