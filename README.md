# homebrew-tensorfold

Unofficial Homebrew tap for the macOS (Metal) engine of [ashhart/TensorFold](https://github.com/ashhart/TensorFold).
It installs the release archive as `tensorfold` and `tensorfold-native`. Bottles are built by this tap's CI and
published to `ghcr.io/blivioniag/tensorfold/tensorfold`.

    brew install blivioniag/tensorfold/tensorfold

## Behind a registry that proxies ghcr.io (for example JFrog Artifactory)

    export HOMEBREW_ARTIFACT_DOMAIN=https://<host>/artifactory/api/docker/<ghcr-remote-repo>
    # only if that repository needs credentials:
    export HOMEBREW_DOCKER_REGISTRY_BASIC_AUTH_TOKEN=<base64 of user:password>
    brew install blivioniag/tensorfold/tensorfold

Homebrew replaces `https://ghcr.io` with that value and keeps the `/v2/...` path. The package must be readable by the proxy.
