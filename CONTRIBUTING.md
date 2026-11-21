# Contributing to Clearview Metadata Tool

Thank you for your interest in contributing! Please read `AGENTS.md` and `docs/DEVELOPMENT.md` before submitting changes.

## Guidelines

1. **License Compatibility:** All contributions are licensed under **GNU GPL-3.0-or-later**. Any new third-party crate or Dart package must be GPL-3.0-compatible and documented in the dependency register.
2. **Architecture Boundaries:** Keep all metadata parsing, cleaning, hashing, and verification in `engine/` (Rust). Keep `app/` (Flutter) strictly for UI and platform file-picker/share integration.
3. **Testing:** Every change must include automated unit or integration tests and pass `cargo test` and `flutter test` before merging.
4. **Privacy:** Never introduce network calls, telemetry, analytics, or crash-reporting SDKs.
