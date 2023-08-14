import 'package:chuck_norris_io/features/random/presentation/widgets/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void categoryTesteWidget() {
  testWidgets('RandomCategory displays correct category',
      (WidgetTester tester) async {
    const String category = 'Test Category';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RandomCategory(category: category),
        ),
      ),
    );

    final categoryFinder = find.text(category);
    expect(categoryFinder, findsOneWidget);

    final cardFinder = find.byType(Card);
    expect(cardFinder, findsOneWidget);

    final textFinder = find.byType(Text);
    expect(textFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(textFinder);
    final textStyle = textWidget.style;

    expect(textStyle?.fontWeight, FontWeight.w800);
    expect(textStyle?.fontSize, 0.3.dp);
  });
}
