{ pkgs, pkgs-stable, ... }:
{
  # Programming languages and runtimes
  languages = with pkgs-stable; [
    # Languages
    nodejs
    rustc
    rustup
    go
    
    # Build tools
    just
    ktlint
    
    # Python with common packages
    (python3.withPackages (ps: [
      ps.ansible
      ps.datadog
      ps.requests
      ps.botocore
      ps.boto3
      ps.pyyaml
      ps.tox
      ps.pytest
      ps.pip
    ]))
  ] ++ (with pkgs; [
    # Unstable language tools
    deno
  ]);
}

