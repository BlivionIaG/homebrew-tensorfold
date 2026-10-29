# homebrew-tensorfold

Unofficial Homebrew tap for the macOS (Metal) engine of [ashhart/TensorFold](https://github.com/ashhart/TensorFold).
It installs the release archive as `tensorfold` and `tensorfold-native`. Bottles are built by this tap's CI and
published to `ghcr.io/blivioniag/tensorfold/tensorfold`.

    brew install blivioniag/tensorfold/tensorfold

## tensorfold-glp: the control-vector build

`tensorfold-glp` is the same engine with native control-vector (GLP) steering, built from
[BlivionIaG/TensorFold](https://github.com/BlivionIaG/TensorFold) (upstream `main` plus the GLP feature branch)
and released as [`v1.1.8-glp.1`](https://github.com/BlivionIaG/TensorFold/releases/tag/v1.1.8-glp.1).
It installs as `tensorfold-glp` and `tensorfold-glp-native`, so it sits beside the plain `tensorfold` formula
instead of replacing it. Bottles for it are published to `ghcr.io/blivioniag/tensorfold/tensorfold-glp`.

    brew install blivioniag/tensorfold/tensorfold-glp

Serve a model with a control vector:

    tensorfold-glp serve MODEL --glp control.gglp --glp-alpha 1.0

The control vector is a `.gglp` container; `docs/control-vectors.md` in the fork describes its format and
the `tf-qwen27-steer-derive` tool that derives one.

## Behind a registry that proxies ghcr.io (for example JFrog Artifactory)

    export HOMEBREW_ARTIFACT_DOMAIN=https://<host>/artifactory/api/docker/<ghcr-remote-repo>
    # only if that repository needs credentials:
    export HOMEBREW_DOCKER_REGISTRY_BASIC_AUTH_TOKEN=<base64 of user:password>
    brew install blivioniag/tensorfold/tensorfold

Homebrew replaces `https://ghcr.io` with that value and keeps the `/v2/...` path. The package must be readable by the proxy.
