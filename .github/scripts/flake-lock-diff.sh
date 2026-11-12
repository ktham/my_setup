#!/usr/bin/env bash
# Print a Markdown report of what changed between two commits of this flake:
#   1. every flake.lock input whose locked revision changed
#   2. every installed package whose version changed
#
# Usage: .github/scripts/flake-lock-diff.sh <base-sha> <head-sha>
# Run it from the repository root. Both commits must exist in the local clone.
set -euo pipefail

# builtins.getFlake needs full commit hashes.
BASE="$(git rev-parse --verify "$1^{commit}")"
HEAD="$(git rev-parse --verify "$2^{commit}")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="$(git rev-parse --show-toplevel)"

# --- Inputs -------------------------------------------------------------

# One JSON object per lock node (except root):
#   { "<node>": { rev, date, ref, url, compare } }
lock_nodes() {
  git show "$1:flake.lock" | jq '
    .nodes | del(.root) | with_entries(
      .value as $n
      | ($n.locked // {}) as $l
      | .value = {
          rev: ($l.rev // $l.narHash // null),
          date: (if $l.lastModified then ($l.lastModified | todate[0:10]) else null end),
          ref: ($n.original.ref // null),
          url: (if $l.type == "github" then "https://github.com/\($l.owner)/\($l.repo)" else null end)
        }
    )'
}

inputs_table=$(jq -rn \
  --argjson old "$(lock_nodes "$BASE")" \
  --argjson new "$(lock_nodes "$HEAD")" '
  def short: if . == null then "—" else .[0:7] end;
  def cell($n):
    if $n == null then "—"
    else
      (if $n.url and $n.rev then "[`\($n.rev | short)`](\($n.url)/commit/\($n.rev))"
       else "`\($n.rev | short)`" end)
      + (if $n.ref then " `\($n.ref)`" else "" end)
      + (if $n.date then " (\($n.date))" else "" end)
    end;
  ([$old, $new] | map(keys) | add | unique)[] as $k
  | $old[$k] as $o | $new[$k] as $n
  | select(($o.rev // null) != ($n.rev // null) or ($o.ref // null) != ($n.ref // null))
  | "| `\($k)` | \(cell($o)) | \(cell($n)) | "
    + (if $o and $n and $n.url and $o.rev != $n.rev
       then "[compare](\($n.url)/compare/\($o.rev)...\($n.rev))" else "" end)
    + " |"
')

# --- Packages -----------------------------------------------------------

package_versions() {
  nix eval --json --impure --expr \
    "import $SCRIPT_DIR/package-versions.nix (builtins.getFlake \"git+file://$REPO?rev=$1\")"
}

# If one side does not evaluate, a diff would be wrong, so compare nothing.
eval_error=""
if ! old_pkgs=$(package_versions "$BASE"); then
  eval_error="Could not evaluate the base commit \`${BASE:0:7}\`."
fi
if ! new_pkgs=$(package_versions "$HEAD"); then
  eval_error="Could not evaluate the head commit \`${HEAD:0:7}\`."
fi
if [ -n "$eval_error" ]; then
  old_pkgs='{}'
  new_pkgs='{}'
fi

# Versioned packages: one row for each version change, addition or removal.
packages_table=$(jq -rn --argjson old "$old_pkgs" --argjson new "$new_pkgs" '
  ([$old, $new] | map(keys) | add | unique)[] as $k
  | ($old[$k].version // null) as $o | ($new[$k].version // null) as $n
  | select(($o != null or $n != null) and $o != $n)
  | "| `\($k)` | \($o // "—") | **\($n // "removed")** |"
')

# Packages without a version: list the ones whose store path changed.
rebuilt=$(jq -rn --argjson old "$old_pkgs" --argjson new "$new_pkgs" '
  [ $new | to_entries[]
    | select(.value.version == null and $old[.key] != null
             and $old[.key].out != .value.out)
    | "`\(.key)`" ] | join(", ")
')

# --- Report -------------------------------------------------------------

echo "## Flake lock diff"
echo
echo "### Inputs"
echo
if [ -z "$inputs_table" ]; then
  echo "No input changed."
else
  echo "| input | old | new | |"
  echo "|---|---|---|---|"
  echo "$inputs_table"
fi
echo
echo "### Packages"
echo
if [ -n "$eval_error" ]; then
  echo "> [!WARNING]"
  echo "> $eval_error Package versions were not compared. See the workflow log."
elif [ -z "$packages_table" ]; then
  echo "No package version changed."
else
  echo "| package | old | new |"
  echo "|---|---|---|"
  echo "$packages_table"
fi
if [ -n "$rebuilt" ]; then
  echo
  echo "Rebuilt, but the package has no version number to compare: $rebuilt"
fi
echo
echo "_Packages are the nix-darwin system packages and the home-manager packages. Transitive dependencies are not listed._"
