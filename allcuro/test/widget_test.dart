import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:allcuro/app/app.dart';

void main() {
  testWidgets('renders the home screen inside the app shell', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: AllcuroApp()));
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('ALLCURO'), findsWidgets);
  });
}
