#!/usr/bin/env bash
set -euo pipefail

VERSION=$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest | grep tag_name | cut -d '"' -f4)
DEST=~/.steam/root/compatibilitytools.d/

echo "Latest GE-Proton version: ${VERSION}"

cd /tmp
curl -LO "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${VERSION}/${VERSION}.tar.gz"
curl -LO "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${VERSION}/${VERSION}.sha512sum"

sha512sum -c "${VERSION}.sha512sum"

mkdir -p "$DEST"
tar -xf "${VERSION}.tar.gz" -C "$DEST"

echo "Installed ${VERSION} to ${DEST}"
echo "Restart Steam to see it in the Compatibility dropdown."
