import 'package:flutter_test/flutter_test.dart';

import 'package:clearview_metadata_tool/bridge/engine_bridge.dart';
import 'package:clearview_metadata_tool/main.dart';
import 'package:clearview_metadata_tool/models/engine_status.dart';

class _FakeEngineClient implements EngineClient {
  @override
  EngineStatus ping() => const EngineStatus(
        engine: 'clearview_engine',
        version: '0.1.0',
        localOnly: true,
        ready: true,
      );

  @override
  String version() => '0.1.0';
}

void main() {
  testWidgets('Home screen displays primary actions and Rust engine status',
      (WidgetTester tester) async {
    await tester.pumpWidget(ClearviewApp(engineClient: _FakeEngineClient()));

    expect(find.text('Clearview Metadata Tool'), findsOneWidget);
    expect(find.text('Import Photograph'), findsOneWidget);
    expect(find.text('Batch Processing'), findsOneWidget);
    expect(find.text('Metadata Inspector'), findsOneWidget);
    expect(find.text('Rust Engine v0.1.0 (Local)'), findsOneWidget);
  });
}
