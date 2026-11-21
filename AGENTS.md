# AGENTS.md — Clearview Metadata Tool

This file defines mandatory rules for all contributors and AI coding agents working on **Clearview Metadata Tool**. Read this file before making any changes.

## 1. Project Overview

- **Name:** Clearview Metadata Tool
- **License:** GNU GPL-3.0-or-later
- **Stack:** Flutter / Dart (`app/`) + Rust (`engine/`) + Shared Interfaces (`packages/`)
- **Targets:** Windows 10/11 (primary), macOS, Android, iOS/iPadOS
- **Processing Model:** 100% local-first, offline-capable, zero cloud/telemetry.

## 2. Permanent Architecture & Safety Rules

1. **Read `AGENTS.md` before making changes.**
2. **Follow the established architecture:** UI lives in `app/`, all metadata inspection/cleaning/verification lives in `engine/`, and FFI/interface contracts live in `packages/`.
3. **Never implement image processing or metadata cleaning directly in Flutter/Dart.** All processing must pass through the Rust engine bridge.
4. **Keep processing logic in the shared Rust engine (`engine/`).** The engine must remain independently testable without Flutter (`cargo test`).
5. **Never overwrite, modify, or delete original photographs.** Always write to a distinct output path (e.g., `Photo_Cleaned.jpg`) with atomic write semantics and duplicate-filename protection.
6. **Never claim metadata was removed without verification.** Every export must be reopened, inspected, and verified against its SHA-256 original integrity check.
7. **Never silently convert image formats** or introduce unrequested lossy compression. Require explicit confirmation before any lossy conversion.
8. **Never silently discard image content or provenance information.** Warn explicitly when removing C2PA provenance manifests.
9. **Handle unsupported formats and RAW files explicitly.** Never claim an archived RAW file was cleaned if only a derivative was generated.
10. **Write automated tests alongside new functionality** (`cargo test` in `engine/`, `flutter test` in `app/`, and integration tests in `tests/`).
11. **Run relevant tests after every significant change.**
12. **Document all third-party dependencies and verify GPL-3.0-or-later license compatibility.**
13. **Do not introduce cloud services, analytics, telemetry, ads, accounts, or paid dependencies.**
14. **Maintain compatibility across Windows, macOS, Android, and iOS/iPadOS.**
15. **Update `docs/` when functionality or supported formats change.**
16. **Do not mark a milestone or feature complete until its acceptance criteria pass.**

## 3. Repository Layout

- `app/` — Flutter cross-platform UI and platform integrations
- `engine/` — Rust core metadata inspection, cleaning, and verification engine
- `packages/` — Shared FFI bridge definitions and interface models
- `tests/` — Cross-layer fixtures, unit tests, and integration tests
- `docs/` — Architecture, format support, privacy, and development guides
- `scripts/` — Build, test, and verification scripts
