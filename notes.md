# Ports

jellyfin: 8096
navidrome: 4533
syncthing: 8384

# Command

```nix
builtins.filter (o: o.type.name == "bool" && o.default == true) options
```
