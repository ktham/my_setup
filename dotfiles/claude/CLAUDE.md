# My Environment
I use Nix. If a `flake.nix` exists at the repo root, prefix build/tool commands with
`nix develop --command <cmd>` (e.g. sbt, scala, node, python, cargo). If there's no
`flake.nix`, use the system tools directly.
