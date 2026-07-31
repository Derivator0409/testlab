import 'dart:math';

import 'package:flutter/material.dart';

/// Aszinkron adatbetöltés szimulálása: loading / siker / hiba állapotok.
///
/// Teszthez hasznos: a betöltés gomb megnyomása után előbb
/// CircularProgressIndicator (Key('loading')), majd lista vagy hibaüzenet.
class DataTab extends StatefulWidget {
  const DataTab({super.key});

  @override
  State<DataTab> createState() => _DataTabState();
}

enum _Status { idle, loading, success, error }

class _DataTabState extends State<DataTab> {
  _Status _status = _Status.idle;
  List<String> _items = [];

  Future<void> _load({bool forceError = false}) async {
    setState(() => _status = _Status.loading);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    // Determinisztikus: forceError esetén mindig hiba, egyébként siker.
    if (forceError) {
      setState(() => _status = _Status.error);
    } else {
      setState(() {
        _items = List.generate(
            8, (i) => 'Elem #${i + 1} (${Random(i).nextInt(1000)})');
        _status = _Status.success;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  key: const Key('load_data'),
                  onPressed: _status == _Status.loading ? null : () => _load(),
                  icon: const Icon(Icons.cloud_download),
                  label: const Text('Betöltés'),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                key: const Key('load_error'),
                onPressed: _status == _Status.loading
                    ? null
                    : () => _load(forceError: true),
                child: const Text('Hiba'),
              ),
            ],
          ),
        ),
        Expanded(child: _buildBody()),
      ],
    );
  }

  Widget _buildBody() {
    switch (_status) {
      case _Status.idle:
        return const Center(child: Text('Nyomd meg a Betöltés gombot'));
      case _Status.loading:
        return const Center(
          child: CircularProgressIndicator(key: Key('loading')),
        );
      case _Status.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 8),
              Text('Hiba történt a betöltéskor',
                  key: const Key('error_message')),
            ],
          ),
        );
      case _Status.success:
        return ListView.builder(
          key: const Key('data_list'),
          itemCount: _items.length,
          itemBuilder: (context, i) => ListTile(
            leading: CircleAvatar(child: Text('${i + 1}')),
            title: Text(_items[i]),
          ),
        );
    }
  }
}
