# Development Guide

## Prerequisites

1. **Rust Toolchain** (stable): Install via [rustup](https://rustup.rs/) (`rustc`, `cargo`).
2. **Flutter SDK** (stable, 3.22+ recommended): Install from [flutter.dev](https://docs.flutter.dev/get-started/install) with platform targets enabled:
   - Windows 10/11: Visual Studio 2022 with "Desktop development with C++"
   - macOS: Xcode + CocoaPods
   - Android: Android SDK + NDK
   - iOS: Xcode (macOS host)

## Building the Rust Engine

```bash
cd engine
cargo build --release
cargo test
```

This produces the native shared library (`clearview_engine.dll` on Windows, `libclearview_engine.so` on Linux, `libclearview_engine.dylib` on macOS).

## Running the Flutter Application

```bash
cd app
flutter pub get
flutter test
flutter run -d windows   # or macos / linux / android / ios
```

Make sure the compiled `clearview_engine` library is on the runtime library path (or copied beside the Flutter runner executable).

## Running All Tests

```bash
./scripts/test_all.sh
```
