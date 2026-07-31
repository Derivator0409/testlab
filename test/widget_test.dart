import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:testlab/main.dart';
import 'package:testlab/screens/counter_tab.dart';
import 'package:testlab/screens/todo_tab.dart';

void main() {
  group('Login', () {
    testWidgets('üres mezőknél validációs hibát mutat', (tester) async {
      await tester.pumpWidget(const TestLabApp());

      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pump();

      expect(find.text('Add meg az email címet'), findsOneWidget);
      expect(find.text('Add meg a jelszót'), findsOneWidget);
    });

    testWidgets('rossz email formátumot elutasít', (tester) async {
      await tester.pumpWidget(const TestLabApp());

      await tester.enterText(find.byKey(const Key('email_field')), 'nem-email');
      await tester.enterText(
          find.byKey(const Key('password_field')), 'jelszo123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pump();

      expect(find.text('Érvénytelen email formátum'), findsOneWidget);
    });

    testWidgets('helyes adatokkal a Home képernyőre navigál', (tester) async {
      await tester.pumpWidget(const TestLabApp());

      await tester.enterText(
          find.byKey(const Key('email_field')), 'teszt@example.com');
      await tester.enterText(
          find.byKey(const Key('password_field')), 'jelszo123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('bottom_nav')), findsOneWidget);
    });
  });

  group('Counter', () {
    testWidgets('növelés és csökkentés helyesen működik', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CounterTab()));

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
    testWidgets('új teendő hozzáadható', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: TodoTab()));

      await tester.enterText(
          find.byKey(const Key('todo_input')), 'Bevásárlás');
      await tester.tap(find.byKey(const Key('add_todo')));
      await tester.pump();

      expect(find.text('Bevásárlás'), findsOneWidget);
    });
  });
}
