import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import '../models/engine_status.dart';

typedef _PingNative = Pointer<Utf8> Function();
typedef _PingDart = Pointer<Utf8> Function();

typedef _VersionNative = Pointer<Utf8> Function();
typedef _VersionDart = Pointer<Utf8> Function();

typedef _FreeStringNative = Void Function(Pointer<Utf8>);
typedef _FreeStringDart = void Function(Pointer<Utf8>);

/// Abstraction for communicating with the Rust processing engine.
abstract class EngineClient {
  EngineStatus ping();
  String version();
}

/// FFI-backed client communicating with `libclearview_engine`.
class NativeEngineBridge implements EngineClient {
  NativeEngineBridge(DynamicLibrary library)
      : _ping = library.lookupFunction<_PingNative, _PingDart>(
          'clearview_engine_ping',
        ),
        _version = library.lookupFunction<_VersionNative, _VersionDart>(
          'clearview_engine_version',
        ),
        _freeString =
            library.lookupFunction<_FreeStringNative, _FreeStringDart>(
          'clearview_free_string',
        );

  /// Opens the platform-appropriate `clearview_engine` shared or static library.
  factory NativeEngineBridge.open({String? libraryPath}) {
    if (libraryPath != null && libraryPath.isNotEmpty) {
      return NativeEngineBridge(DynamicLibrary.open(libraryPath));
    }
    if (Platform.isWindows) {
      return NativeEngineBridge(DynamicLibrary.open('clearview_engine.dll'));
    }
    if (Platform.isMacOS) {
      return NativeEngineBridge(
        DynamicLibrary.open('libclearview_engine.dylib'),
      );
    }
    if (Platform.isIOS) {
      return NativeEngineBridge(DynamicLibrary.process());
    }
    return NativeEngineBridge(DynamicLibrary.open('libclearview_engine.so'));
  }

  final _PingDart _ping;
  final _VersionDart _version;
  final _FreeStringDart _freeString;

  @override
  EngineStatus ping() {
    final ptr = _ping();
    if (ptr == nullptr) {
      throw StateError('clearview_engine_ping returned null pointer');
    }
    try {
      return EngineStatus.fromJson(ptr.toDartString());
    } finally {
      _freeString(ptr);
    }
  }

  @override
  String version() {
    final ptr = _version();
    if (ptr == nullptr) {
      throw StateError('clearview_engine_version returned null pointer');
    }
    try {
      return ptr.toDartString();
    } finally {
      _freeString(ptr);
    }
  }
}
