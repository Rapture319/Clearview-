import 'package:flutter/material.dart';

import 'bridge/engine_bridge.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ClearviewApp());
}

class ClearviewApp extends StatelessWidget {
  const ClearviewApp({super.key, this.engineClient});

  final EngineClient? engineClient;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clearview Metadata Tool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF0F766E),
        useMaterial3: true,
      ),
      home: HomeShell(engineClient: engineClient),
    );
  }
}
