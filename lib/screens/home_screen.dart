import 'package:flutter/material.dart';

import 'counter_tab.dart';
import 'todo_tab.dart';
import 'data_tab.dart';
import 'settings_tab.dart';

/// Fő képernyő alsó navigációval (4 fül).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const route = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final _tabs = const [
    CounterTab(),
    TodoTab(),
    DataTab(),
    SettingsTab(),
  ];

  final _titles = const ['Számláló', 'Teendők', 'Adatok', 'Beállítások'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
        actions: [
          IconButton(
            key: const Key('logout_button'),
            icon: const Icon(Icons.logout),
            tooltip: 'Kijelentkezés',
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed('/login'),
          ),
        ],
      ),
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: NavigationBar(
        key: const Key('bottom_nav'),
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.add_circle_outline), label: 'Számláló'),
          NavigationDestination(
              icon: Icon(Icons.checklist_outlined), label: 'Teendők'),
          NavigationDestination(
              icon: Icon(Icons.cloud_download_outlined), label: 'Adatok'),
          NavigationDestination(
              icon: Icon(Icons.settings_outlined), label: 'Beállítások'),
        ],
      ),
    );
  }
}
