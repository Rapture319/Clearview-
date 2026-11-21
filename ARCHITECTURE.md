# Architecture — Clearview Metadata Tool

## High-Level Design

Clearview Metadata Tool separates presentation from all image and metadata processing:

- **`app/` (Flutter / Dart):** Cross-platform UI for Windows 10/11, macOS, Android, and iOS/iPadOS. Handles navigation, drag-and-drop / photo-picker integration, previews, and user confirmations. **Never performs metadata parsing or cleaning directly.**
- **`packages/clearview_bridge/` (Shared Interface):** Defines the C-ABI / `flutter_rust_bridge` contract and shared request/response schemas (`EngineStatus`, `CleaningProfile`, `MetadataReport`, `ProcessingReport`).
- **`engine/` (Rust Core):** Standalone, independently testable library (`clearview_engine`) exposing:
  1. **Format Identification & Validation**
  2. **Metadata Inspection Engine** (EXIF, IPTC, XMP, GPS, Thumbnails, ICC, MakerNotes, AI labels, C2PA)
  3. **Metadata Adapter Layer** (native Rust format handlers + optional desktop ExifTool adapter where suitable)
  4. **Metadata Cleaning Engine** (Profile A: Privacy Clean, Profile B: Full Metadata Clean, Custom)
  5. **Original Preservation & Export Verification** (SHA-256 pre/post hash, atomic writes, post-export re-inspection)

## Flutter-to-Rust Bridge Strategy

- **Primary Interface:** `flutter_rust_bridge` (v2) or `dart:ffi` C-ABI bindings over `libclearview_engine` (`cdylib` + `staticlib` for iOS).
- **Foundation C-ABI:** Milestone 1 establishes a C-compatible FFI entry point (`clearview_engine_ping`, `clearview_engine_version`, `clearview_free_string`) in `engine/src/ffi.rs` and a matching Dart `DynamicLibrary` wrapper in `app/lib/bridge/engine_bridge.dart`, ready for `flutter_rust_bridge` codegen as the API expands.

## Dependency & Licensing Register

| Component | Purpose | License | Status |
|---|---|---|---|
| `clearview_engine` | Core Rust library | GPL-3.0-or-later | Active (Milestone 1) |
| `flutter` / `dart` | Cross-platform UI | BSD-3-Clause | GPL-compatible |
| `ffi` (Dart) | Native FFI bindings | BSD-3-Clause | Planned (Milestone 1) |
| `flutter_rust_bridge` | Typed async Rust/Dart bridge | MIT | Planned (Milestone 2+) |
| `sha2` (Rust) | SHA-256 original integrity verification | MIT OR Apache-2.0 | Planned (Milestone 4) |
| `image` / `kamadak-exif` (Rust) | Pure-Rust image & EXIF handling | MIT / BSD-2-Clause | Planned (Milestone 2–3) |
| `c2pa` (Rust) | C2PA provenance inspection | MIT OR Apache-2.0 | Planned (Milestone 2) |
| `ExifTool` (Desktop optional) | Extended desktop metadata adapter | Artistic-1.0-Perl / GPL-1.0-or-later | Planned (Desktop adapter) |
