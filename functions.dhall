let map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/dbcf50c27b1592a6acfd38cb3ba976e3a36b74fe/Prelude/List/map sha256:dd845ffb4568d40327f2a817eb42d1c6138b929ca758d50bc33112ef3c885680

let types = ./types.dhall

let buildRepo =
        λ(owner : Text)
      → λ(language : Text)
      → λ(repoName : Text)
      → { owner, repoName, language } : types.ProjectId

let ghRemoteUrl =
      λ(p : types.ProjectId) → "git@github.com:${p.owner}/${p.repoName}.git"

let localPath =
      λ(p : types.ProjectId) → "\$HOME/projects/${p.language}/${p.repoName}"

let addLocations =
        λ(p : types.ProjectId)
      → p ⫽ { remoteUrl = ghRemoteUrl p, localPath = localPath p }

let mapLocations =
        λ(ps : List types.ProjectId)
      → map types.ProjectId types.ProjectIdWithLocations addLocations ps

in  { buildRepo, ghRemoteUrl, localPath, addLocations, mapLocations }
