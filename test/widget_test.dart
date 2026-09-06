import 'package:flutter_test/flutter_test.dart';
import 'package:cropd_up/main.dart';

void main() {
  testWidgets('CropD UP app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const CropDUpApp());

    expect(find.byType(CropDUpApp), findsOneWidget);
  });
}