#!/usr/bin/env python3
"""Static foundation verification for Clearview Metadata Tool."""

from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parent.parent

REQUIRED_PATHS = [
    "AGENTS.md",
    "README.md",
    "LICENSE",
    "CONTRIBUTING.md",
    "SECURITY.md",
    ".gitignore",
    "docs/ARCHITECTURE.md",
    "docs/SUPPORTED_FORMATS.md",
    "docs/PRIVACY.md",
    "docs/DEVELOPMENT.md",
    "packages/clearview_bridge/README.md",
    "engine/Cargo.toml",
    "engine/src/lib.rs",
    "engine/src/models.rs",
    "engine/src/adapter.rs",
    "engine/src/ffi.rs",
    "engine/tests/foundation_test.rs",
    "app/pubspec.yaml",
    "app/lib/main.dart",
    "app/lib/models/engine_status.dart",
    "app/lib/bridge/engine_bridge.dart",
    "app/lib/screens/home_screen.dart",
    "app/test/widget_test.dart",
    "app/test/ffi_integration_test.dart",
    "scripts/test_all.sh",
]

missing = [p for p in REQUIRED_PATHS if not (ROOT / p).is_file()]
if missing:
    print(f"FAIL: Missing required files: {missing}", file=sys.stderr)
    sys.exit(1)

print(f"PASS: All {len(REQUIRED_PATHS)} foundation files present.")
