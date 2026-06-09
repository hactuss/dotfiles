# Filters out .git directories and all regular files that are not Nix files
src = builtins.filterSource (path: type:
  let
    baseName = baseNameOf path;
  in
    # Exclude .git directories
    (type == "directory" && baseName != ".git") ||
    # Include only .nix files
    (type == "regular" && builtins.match ".*\\.nix" baseName != null)
) ./.;
