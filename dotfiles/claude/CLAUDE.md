# My Environment
I use Nix. If a `flake.nix` exists at the repo root, prefix all commands with
`nix develop --command <cmd>` so CLI tools provided by the flake are visible.

# Reviewing Comments on a Github Pull Request (PR)
A PR has two comment streams that must both be read:
  1. inline review comments:  `gh api repos/OWNER/REPO/pulls/N/comments`
  2. review summary bodies:   `gh api repos/OWNER/REPO/pulls/N/reviews`
For structured queries (filter by author, diff hunks, line numbers), hit
both API endpoints — one alone misses the other.
To just read through everything, `gh pr view N --comments` prints all
comments as one formatted text stream.
