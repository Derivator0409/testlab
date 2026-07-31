import 'package:flutter/material.dart';

/// Teendőlista – hozzáadás, kipipálás, törlés (swipe).
///
/// Teszthez: Key('todo_input'), Key('add_todo'),
/// minden elem: Key('todo_item_$index'), Key('todo_checkbox_$index').
class TodoTab extends StatefulWidget {
  const TodoTab({super.key});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _Todo {
  _Todo(this.title, {this.done = false});
  String title;
  bool done;
}

class _TodoTabState extends State<TodoTab> {
  final _ctrl = TextEditingController();
  final List<_Todo> _todos = [
    _Todo('Példa teendő'),
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _add() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _todos.add(_Todo(text));
      _ctrl.clear();
    });
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
                child: TextField(
                  key: const Key('todo_input'),
                  controller: _ctrl,
                  decoration: const InputDecoration(
                    hintText: 'Új teendő...',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onSubmitted: (_) => _add(),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                key: const Key('add_todo'),
                onPressed: _add,
                child: const Text('Hozzáad'),
              ),
            ],
          ),
        ),
        Expanded(
          child: _todos.isEmpty
              ? const Center(child: Text('Nincs teendő'))
              : ListView.builder(
                  key: const Key('todo_list'),
                  itemCount: _todos.length,
                  itemBuilder: (context, i) {
                    final todo = _todos[i];
                    return Dismissible(
                      key: ValueKey('todo_item_$i'),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) => setState(() => _todos.removeAt(i)),
                      child: CheckboxListTile(
                        key: Key('todo_checkbox_$i'),
                        value: todo.done,
                        onChanged: (v) =>
                            setState(() => todo.done = v ?? false),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.done
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
