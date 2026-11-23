import 'package:flutter_test/flutter_test.dart';
import 'package:millionaire_syria/main.dart';

void main() {
  testWidgets('Millionaire Syria home screen renders', (tester) async {
    await tester.pumpWidget(const MillionaireApp());
    expect(find.text('المليونير السوري'), findsOneWidget);
    expect(find.text('السؤال 1 من 15'), findsOneWidget);
    expect(find.text('تأكيد الإجابة'), findsOneWidget);
  });
}
