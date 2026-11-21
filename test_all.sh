#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Building and testing Rust engine..."
cd "$ROOT_DIR/engine"
cargo test
cargo build --release

echo "==> Running Flutter pub get and tests..."
cd "$ROOT_DIR/app"
flutter pub get
flutter test
