{ pkgs, ... }:
# TODO: Declare the .ideavim config here (write to home)
{
  # TODO: Remove once fix is merged
  nixpkgs.overlays =
    let
      rider-overlay = (
        final: prev: {
          rider = prev.jetbrains.rider.overrideAttrs (attrs: {
            postInstall = ''
              cd $out/rider

              ls -d $PWD/plugins/cidr-debugger-plugin/bin/lldb/linux/*/lib/python3.8/lib-dynload/* |
              xargs patchelf \
                --replace-needed libssl.so.10 libssl.so \
                --replace-needed libcrypto.so.10 libcrypto.so \
                --replace-needed libcrypt.so.1 libcrypt.so

              for dir in lib/ReSharperHost/linux-*; do
                rm -rf $dir/dotnet
                ln -s ${prev.dotnet-sdk_7.unwrapped}/share/dotnet $dir/dotnet
              done
            '';
          });
        }
      );
    in
    [ rider-overlay ];

  home.packages = [ pkgs.rider ];

  # Allow old dotnet versions
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-wrapped-7.0.410"
    "dotnet-sdk-7.0.410"
    "dotnet-sdk-wrapped-6.0.428"
    "dotnet-sdk-6.0.428"
    "dotnet-core-combined"
  ];
}
