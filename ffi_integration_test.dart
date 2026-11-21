import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:clearview_metadata_tool/bridge/engine_bridge.dart';

/// Integration test proving Dart/Flutter can communicate with the compiled
/// Rust `clearview_engine` shared library over FFI.
///
/// Requires `cargo build --release` in `../engine/` before running, or
/// setting `CLEARVIEW_ENGINE_LIB` to the compiled shared library path.
void main() {
  test('Flutter communicates with Rust clearview_engine over FFI', () {
    final envPath = Platform.environment['CLEARVIEW_ENGINE_LIB'];
    final defaultPath = Platform.isWindows
        ? '../engine/target/release/clearview_engine.dll'
        : Platform.isMacOS
            ? '../engine/target/release/libclearview_engine.dylib'
            : '../engine/target/release/libclearview_engine.so';

    final libPath = (envPath != null && envPath.isNotEmpty) ? envPath : defaultPath;
    final bridge = NativeEngineBridge.open(libraryPath: libPath);

    final status = bridge.ping();
    expect(status.engine, equals('clearview_engine'));
    expect(status.localOnly, isTrue);
    expect(status.ready, isTrue);

    final version = bridge.version();
    expect(version, isNotEmpty);
    expect(status.version, equals(version));
  });
}
