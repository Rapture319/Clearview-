import 'package:flutter/material.dart';

import '../bridge/engine_bridge.dart';
import '../models/engine_status.dart';

enum NavSection {
  home('Home', Icons.home_outlined),
  cleanPhoto('Clean Photo', Icons.cleaning_services_outlined),
  batchClean('Batch Clean', Icons.collections_outlined),
  inspector('Metadata Inspector', Icons.manage_search_outlined),
  history('Processing History', Icons.history_outlined),
  settings('Settings', Icons.settings_outlined),
  about('About / Open Source', Icons.info_outline);

  const NavSection(this.label, this.icon);
  final String label;
  final IconData icon;
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, this.engineClient});

  final EngineClient? engineClient;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  NavSection _selected = NavSection.home;
  EngineStatus? _engineStatus;
  String? _engineError;

  @override
  void initState() {
    super.initState();
    _checkEngine();
  }

  void _checkEngine() {
    try {
      final client = widget.engineClient ?? NativeEngineBridge.open();
      final status = client.ping();
      setState(() {
        _engineStatus = status;
        _engineError = null;
      });
    } catch (err) {
      setState(() {
        _engineStatus = null;
        _engineError = err.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 720;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clearview Metadata Tool'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _EngineStatusBadge(
              status: _engineStatus,
              error: _engineError,
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          if (isWide)
            NavigationRail(
              selectedIndex: _selected.index,
              onDestinationSelected: (i) {
                setState(() => _selected = NavSection.values[i]);
              },
              labelType: NavigationRailLabelType.all,
              destinations: NavSection.values
                  .map(
                    (s) => NavigationRailDestination(
                      icon: Icon(s.icon),
                      label: Text(s.label),
                    ),
                  )
                  .toList(),
            ),
          Expanded(
            child: _selected == NavSection.home
                ? _HomeContent(
                    onNavigate: (section) =>
                        setState(() => _selected = section),
                  )
                : Center(
                    child: Text(
                      '${_selected.label} — Scheduled for upcoming milestone',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: _selected.index.clamp(0, 3),
              onDestinationSelected: (i) {
                setState(() => _selected = NavSection.values[i]);
              },
              destinations: NavSection.values
                  .take(4)
                  .map(
                    (s) => NavigationDestination(
                      icon: Icon(s.icon),
                      label: s.label,
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.onNavigate});

  final ValueChanged<NavSection> onNavigate;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          'Local-First Photo Privacy',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Inspect, clean, and verify photo metadata on your device. Originals are never modified.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: () => onNavigate(NavSection.cleanPhoto),
              icon: const Icon(Icons.add_photo_alternate_outlined),
              label: const Text('Import Photograph'),
            ),
            OutlinedButton.icon(
              onPressed: () => onNavigate(NavSection.batchClean),
              icon: const Icon(Icons.collections_outlined),
              label: const Text('Batch Processing'),
            ),
            OutlinedButton.icon(
              onPressed: () => onNavigate(NavSection.inspector),
              icon: const Icon(Icons.manage_search_outlined),
              label: const Text('Metadata Inspector'),
            ),
          ],
        ),
        const SizedBox(height: 32),
        const Card(
          child: ListTile(
            leading: Icon(Icons.analytics_outlined),
            title: Text('Photographs Processed: 0'),
            subtitle: Text('Recent processing activity will appear here.'),
          ),
        ),
      ],
    );
  }
}

class _EngineStatusBadge extends StatelessWidget {
  const _EngineStatusBadge({this.status, this.error});

  final EngineStatus? status;
  final String? error;

  @override
  Widget build(BuildContext context) {
    if (status != null && status!.ready) {
      return Chip(
        avatar: const Icon(Icons.verified_user_outlined, size: 18),
        label: Text('Rust Engine v${status!.version} (Local)'),
      );
    }
    return Tooltip(
      message: error ?? 'Engine unavailable',
      child: const Chip(
        avatar: Icon(Icons.warning_amber_outlined, size: 18),
        label: Text('Engine Not Loaded'),
      ),
    );
  }
}
