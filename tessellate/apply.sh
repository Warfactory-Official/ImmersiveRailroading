#!/usr/bin/env bash
# apply.sh SRC: SRC = checkout at UPSTREAM_REF. Fail hard on any hunk failure.
set -euo pipefail
UPSTREAM_REF=ba11894cae7d1caf204901b768489a53d3271dba
HERE=$(cd "$(dirname "$0")" && pwd)
SRC=${1:?usage: apply.sh <upstream checkout>}
SRC=$(cd "$SRC" && pwd)
cd "$SRC"
[ "$(git rev-parse HEAD)" = "$(git rev-parse "$UPSTREAM_REF^{commit}")" ] || { echo "SRC not at $UPSTREAM_REF" >&2; exit 1; }
[ -z "$(git status --porcelain)" ] || { echo "SRC dirty" >&2; exit 1; }
for p in "$HERE"/patches/*.patch; do
  echo "apply $(basename "$p")"
  git apply --3way "$p" || { echo "PATCH FAILED: $p" >&2; exit 1; }
done
cp -a "$HERE/overlay/." "$SRC/"
rm -rf "$SRC/ImmersiveRailroadingIntegration"
git clone -q https://github.com/TeamOpenIndustry/ImmersiveRailroadingIntegration "$SRC/ImmersiveRailroadingIntegration"
git -C "$SRC/ImmersiveRailroadingIntegration" checkout -q 6dea48f91ac03fd89e0318affeba6df15fa35e24
