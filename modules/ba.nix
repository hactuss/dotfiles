{wrappers, pkgs, ...}:{
  environment.systemPackages = [
    (wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.curl;
      runtimeInputs = [pkgs.jq];
      env = {
        CURL_CA_BUNDLE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      };
      flags = {
        "--silent" = true;
        "--connect-timeout" = "30";
      };
      # Or use args directly for more control:
      # args = [ "--silent" "--connect-timeout" "30" ];
      flagSeparator = "="; # Use --flag=value instead of --flag value (default is " ")
      preHook = ''
        echo "Making request..." >&2
      '';
    })
  ];
}
