import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:testlab/main.dart';
import 'package:testlab/screens/counter_tab.dart';
import 'package:testlab/screens/todo_tab.dart';

void main() {
  group('Counter', () {
    testWidgets('noveles es csokkentes helyesen mukodik', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: CounterTab())),
      );

      expect(find.byKey(const Key('counter_value')), findsOneWidget);
      expect(find.text('0'), findsOneWidget);

      await tester.tap(find.byKey(const Key('increment')));
      await tester.tap(find.byKey(const Key('increment')));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);

      await tester.tap(find.byKey(const Key('decrement')));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.byKey(const Key('reset')));
      await tester.pump();
      expect(find.text('0'), findsOneWidget);
    });
  });

  group('Todo', () {
    testWidgets('uj teendo hozzaadhato', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: TodoTab())),
      );

      await tester.enterText(
          find.byKey(const Key('todo_input')), 'Bevasarlas');
      await tester.tap(find.byKey(const Key('add_todo')));
      await tester.pump();

      expect(find.text('Bevasarlas'), findsOneWidget);
    });
  });
}
