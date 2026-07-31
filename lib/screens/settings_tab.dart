import 'package:flutter/material.dart';

/// Beállítások – kapcsolók, csúszka, legördülő menü.
///
/// Teszthez: Key('switch_notifications'), Key('switch_dark'),
/// Key('volume_slider'), Key('language_dropdown').
class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _notifications = true;
  bool _dark = false;
  double _volume = 50;
  String _language = 'Magyar';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          key: const Key('switch_notifications'),
          title: const Text('Értesítések'),
          value: _notifications,
          onChanged: (v) => setState(() => _notifications = v),
        ),
        SwitchListTile(
          key: const Key('switch_dark'),
          title: const Text('Sötét mód'),
          value: _dark,
          onChanged: (v) => setState(() => _dark = v),
        ),
        const Divider(),
        ListTile(
          title: const Text('Hangerő'),
          subtitle: Slider(
            key: const Key('volume_slider'),
            value: _volume,
            min: 0,
            max: 100,
            divisions: 10,
            label: '${_volume.round()}',
            onChanged: (v) => setState(() => _volume = v),
          ),
          trailing: Text('${_volume.round()}%',
              key: const Key('volume_label')),
        ),
        const Divider(),
        ListTile(
          title: const Text('Nyelv'),
          trailing: DropdownButton<String>(
            key: const Key('language_dropdown'),
            value: _language,
            items: const [
              DropdownMenuItem(value: 'Magyar', child: Text('Magyar')),
              DropdownMenuItem(value: 'English', child: Text('English')),
              DropdownMenuItem(value: 'Deutsch', child: Text('Deutsch')),
            ],
            onChanged: (v) => setState(() => _language = v ?? _language),
          ),
        ),
      ],
    );
  }
}
