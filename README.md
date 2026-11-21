# Clearview Metadata Tool

A free, open-source, cross-platform desktop and mobile application for inspecting, removing, and verifying embedded metadata in digital photographs—100% locally on your device.

- **License:** GNU GPL-3.0-or-later (see `LICENSE`)
- **Platforms:** Windows 10/11 (primary), macOS, Android, iOS/iPadOS
- **Architecture:** Flutter / Dart UI (`app/`) + Rust core engine (`engine/`)

## Core Principles

1. **Privacy first:** No cloud processing, accounts, telemetry, analytics, or ads.
2. **Originals untouched:** Original photographs are never modified or overwritten; SHA-256 hashes verify original integrity before and after export.
3. **Independent verification:** Cleaned exports are reopened and re-inspected to confirm metadata removal and image validity.
4. **Honest reporting:** Unsupported formats, retained metadata, and lossy conversions are reported explicitly.

## Repository Structure

```
clearview-metadata-tool/
├── AGENTS.md              # Mandatory agent & contributor rules
├── README.md
├── LICENSE                # GNU GPL-3.0-or-later
├── CONTRIBUTING.md
├── SECURITY.md
├── app/                   # Flutter application
├── engine/                # Rust processing engine
├── packages/              # Shared FFI & data-model interfaces
├── tests/                 # Fixtures, unit, and integration tests
├── docs/                  # Architecture, formats, privacy, dev setup
└── scripts/               # Build and test scripts
```

## Quick Start

See [`docs/DEVELOPMENT.md`](docs/DEVELOPMENT.md) for toolchain installation, build commands, and test instructions.
