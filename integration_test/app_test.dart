import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:testlab/main.dart';

// Futtatás:
//   flutter test integration_test/app_test.dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('teljes folyamat: login -> számláló -> teendő -> adat',
      (tester) async {
    await tester.pumpWidget(const TestLabApp());
    await tester.pumpAndSettle();

    // 1. Bejelentkezés
    await tester.enterText(
        find.byKey(const Key('email_field')), 'user@test.com');
    await tester.enterText(
        find.byKey(const Key('password_field')), 'titkos1');
    await tester.tap(find.byKey(const Key('login_button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('bottom_nav')), findsOneWidget);

    // 2. Számláló növelése
    await tester.tap(find.byKey(const Key('increment')));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    // 3. Váltás a Teendők fülre és hozzáadás
    await tester.tap(find.text('Teendők'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('todo_input')), 'Teszt elem');
    await tester.tap(find.byKey(const Key('add_todo')));
    await tester.pump();
    expect(find.text('Teszt elem'), findsOneWidget);

    // 4. Váltás az Adatok fülre és betöltés
    await tester.tap(find.text('Adatok'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('load_data')));
    await tester.pump(); // loading megjelenik
    expect(find.byKey(const Key('loading')), findsOneWidget);
    await tester.pumpAndSettle(); // adat betölt
    expect(find.byKey(const Key('data_list')), findsOneWidget);

    // 5. Kijelentkezés
    await tester.tap(find.byKey(const Key('logout_button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('login_button')), findsOneWidget);
  });
}
