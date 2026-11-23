import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:millionaire_syria/main.dart';

void main() {
  testWidgets('Millionaire Syria mode selection renders', (tester) async {
    await tester.pumpWidget(const MillionaireApp());

    expect(find.text('المليونير السوري'), findsOneWidget);
    expect(find.text('اختر مستوى التحدي'), findsOneWidget);
    expect(find.text('سهل'), findsOneWidget);
    expect(find.text('متوسط'), findsOneWidget);
    expect(find.text('صعب'), findsOneWidget);
    expect(find.text('الأطفال'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'جاد');
    await tester.tap(find.text('متوسط'));
    await tester.pump();
    expect(find.text('تأكيد الإجابة'), findsOneWidget);
  });
}
