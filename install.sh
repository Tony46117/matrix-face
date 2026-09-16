#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="${HOME}/.local/bin"

echo "==> Installing dependencies (numpy, Pillow)..."
if ! python3 -m pip install -r "${SCRIPT_DIR}/requirements.txt" 2>/dev/null; then
  echo "    bare pip failed (PEP 668 externally-managed env?), retrying with --break-system-packages..."
  python3 -m pip install --break-system-packages -r "${SCRIPT_DIR}/requirements.txt"
fi

mkdir -p "${DEST_DIR}"
cp "${SCRIPT_DIR}/matrix" "${DEST_DIR}/matrix"
chmod +x "${DEST_DIR}/matrix"

if [ -d "${SCRIPT_DIR}/ref" ]; then
  mkdir -p "${DEST_DIR}/ref"
  cp -r "${SCRIPT_DIR}/ref/." "${DEST_DIR}/ref/"
fi

echo "==> Installed. Add to PATH if needed: export PATH=\"\$HOME/.local/bin:\$PATH\""
echo "    Run it: matrix"
