import 'package:flutter/material.dart';

/// Klasszikus számláló – növelés, csökkentés, nullázás.
///
/// Teszthez: Key('counter_value'), Key('increment'),
/// Key('decrement'), Key('reset').
class CounterTab extends StatefulWidget {
  const CounterTab({super.key});

  @override
  State<CounterTab> createState() => _CounterTabState();
}

class _CounterTabState extends State<CounterTab> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Aktuális érték:'),
          const SizedBox(height: 8),
          Text(
            '$_count',
            key: const Key('counter_value'),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filledTonal(
                key: const Key('decrement'),
                iconSize: 36,
                onPressed: () => setState(() => _count--),
                icon: const Icon(Icons.remove),
              ),
              const SizedBox(width: 24),
              IconButton.filledTonal(
                key: const Key('increment'),
                iconSize: 36,
                onPressed: () => setState(() => _count++),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton(
            key: const Key('reset'),
            onPressed: () => setState(() => _count = 0),
            child: const Text('Nullázás'),
          ),
        ],
      ),
    );
  }
}
