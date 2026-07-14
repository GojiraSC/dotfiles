#!/usr/bin/env bash
set -euo pipefail

REPO="CachyOS/proton-cachyos"
DEST=~/.steam/root/compatibilitytools.d/

# Get latest release tag, e.g. "cachyos-11.0-20260602-slr"
TAG=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name"' | cut -d '"' -f4)

if [[ -z "$TAG" ]]; then
    echo "Could not determine latest release tag. GitHub API may be rate-limited, try again shortly."
    exit 1
fi

# Asset filenames drop the leading "cachyos-" from the tag
VERSION="${TAG#cachyos-}"
ASSET="proton-cachyos-${VERSION}-x86_64_v3.tar.xz"
URL="https://github.com/${REPO}/releases/download/${TAG}/${ASSET}"

echo "Latest proton-cachyos-slr release: ${TAG}"
echo "Asset: ${ASSET}"

cd /tmp
curl -fL -o "${ASSET}" "$URL"

# Checksum file drops the .tar.xz extension, e.g.
# proton-cachyos-11.0-20260702-slr-x86_64_v3.sha512sum
CHECKSUM_FILE="${ASSET%.tar.xz}.sha512sum"
CHECKSUM_URL="https://github.com/${REPO}/releases/download/${TAG}/${CHECKSUM_FILE}"

if curl -fsL -o "${CHECKSUM_FILE}" "$CHECKSUM_URL" 2>/dev/null; then
    echo "Verifying checksum..."
    sha512sum -c "${CHECKSUM_FILE}"
else
    echo "No checksum file found for this release; skipping verification."
fi

mkdir -p "$DEST"
tar -xf "${ASSET}" -C "$DEST"

echo "Installed proton-cachyos ${VERSION} to ${DEST}"
echo "Restart Steam to see it in the Compatibility dropdown."
