import 'dart:convert';

/// Health and readiness status returned by the Rust processing engine.
class EngineStatus {
  const EngineStatus({
    required this.engine,
    required this.version,
    required this.localOnly,
    required this.ready,
  });

  final String engine;
  final String version;
  final bool localOnly;
  final bool ready;

  factory EngineStatus.fromJson(String rawJson) {
    final decoded = jsonDecode(rawJson) as Map<String, dynamic>;
    return EngineStatus(
      engine: decoded['engine'] as String? ?? 'unknown',
      version: decoded['version'] as String? ?? '0.0.0',
      localOnly: decoded['localOnly'] as bool? ?? false,
      ready: decoded['ready'] as bool? ?? false,
    );
  }
}
