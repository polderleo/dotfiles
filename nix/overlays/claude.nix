# I maintain this claude-code overlay that uses bun instead of node.
# To disable the auto updater, run `claude config set --global autoUpdaterStatus disabled`

final: prev: {
  claude-code = final.stdenv.mkDerivation {
    name = "claude";
    version = "0.2.69";

    src = final.fetchurl {
      url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-0.2.69.tgz";
      sha256 = "sha256-bQjKhTZzItorMXUsqpPgrHHBBmTtHIpcv/bNJU6koCA=";
    };

    buildInputs = with final; [
      bun
    ];

    installPhase = ''
      mkdir -p $out/bin
      cp -r ./* $out/

      # Create a wrapper script
      cat > $out/bin/claude <<EOF
        #!/bin/sh
        exec ${final.bun}/bin/bun $out/cli.js "\$@"
      EOF
      chmod +x $out/bin/claude
    '';
  };
}
