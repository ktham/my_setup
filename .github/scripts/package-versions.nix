# Usage:
#   nix eval --json --impure --expr \
#     'import ./.github/scripts/package-versions.nix (builtins.getFlake "<flake-ref>")'
#
# Returns { "<name>" = { version = "..."; out = "..."; }; } for every
# package the flake installs: nix-darwin system packages, plus the
# home-manager packages of each user (this includes packages that
# `programs.*` modules add).
#
# `version` is null when the package does not set one (for example, the
# tailscale flake package). For those packages only, `out` is the store
# path hash, so the diff can still tell if the package changed.
flake:
let
  inherit (builtins) attrValues baseNameOf concatMap listToAttrs parseDrvName substring;

  entry = pkg:
    let
      parsed = parseDrvName (pkg.name or "unknown");
      version = pkg.version or parsed.version;
      hasVersion = version != "";
    in {
      name = pkg.pname or parsed.name;
      value = {
        version = if hasVersion then version else null;
        out = if hasVersion then null else substring 0 7 (baseNameOf pkg.outPath);
      };
    };

  pkgsOf = cfg:
    cfg.environment.systemPackages
    ++ concatMap (u: u.home.packages) (attrValues (cfg.home-manager.users or { }));

  configs = map (c: c.config) (attrValues (flake.darwinConfigurations or { }));
in
listToAttrs (map entry (concatMap pkgsOf configs))
