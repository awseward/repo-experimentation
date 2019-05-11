let map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/dbcf50c27b1592a6acfd38cb3ba976e3a36b74fe/Prelude/List/map sha256:dd845ffb4568d40327f2a817eb42d1c6138b929ca758d50bc33112ef3c885680

let types = ./types.dhall

let myRepo =
        λ(language : Text)
      → λ(repoName : Text)
      →   { owner = "awseward", repoName = repoName, language = language }
        : types.ProjectId

let ghRemoteUrl =
      λ(p : types.ProjectId) → "git@github.com:${p.owner}/${p.repoName}.git"

let localPath =
        λ(p : types.ProjectId)
      → "${env:HOME as Text}/projects/${p.language}/${p.repoName}"

let addLocations =
        λ(p : types.ProjectId)
      → p ⫽ { remoteUrl = ghRemoteUrl p, localPath = localPath p }

in  { myRepo =
        myRepo
    , myFs =
        myRepo "fsharp"
    , myHs =
        myRepo "haskell"
    , myRkt =
        myRepo "racket"
    , ghRemoteUrl =
        ghRemoteUrl
    , localPath =
        localPath
    , addLocations =
        addLocations
    }
