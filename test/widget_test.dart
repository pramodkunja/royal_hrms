import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:royal_hrms/main.dart';

void main() {
  testWidgets('App boots and renders the splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: RoyalHrmsApp()));
    await tester.pump();

    expect(find.byType(RoyalHrmsApp), findsOneWidget);
  });
}
