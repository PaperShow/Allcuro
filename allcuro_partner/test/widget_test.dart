import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:allcuro_partner/main.dart';

void main() {
  testWidgets('boots to the welcome screen when signed out', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const ProviderScope(child: AllcuroPartnerApp()));
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('ALLCURO PARTNER'), findsWidgets);
    expect(find.text('Get started'), findsOneWidget);
  });
}
