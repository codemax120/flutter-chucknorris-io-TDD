import 'package:chuck_norris_io/features/random/presentation/widgets/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void categoryTesteWidget() {
  testWidgets('RandomCategory displays correct category',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: RandomCategory(category: 'Test Category'),
        ),
      ),
    );

    final containerFinder = find.byType(Container);
    expect(containerFinder, findsWidgets);

    final containerWidget = tester.widget<Container>(containerFinder.first);
    expect(containerWidget.margin, EdgeInsets.only(bottom: 2.h, right: 1.w));

    final cardFinder = find.byType(Card);
    expect(cardFinder, findsWidgets);

    final cardWidget = tester.widget<Card>(cardFinder.first);
    expect(cardWidget.elevation, 0);
    expect(cardWidget.shadowColor, Colors.grey.withOpacity(0.4));
    expect(cardWidget.color, Colors.deepOrangeAccent.withOpacity(0.4));

    final textFinder = find.text('Test Category');
    expect(textFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(textFinder);
    final textStyle = textWidget.style!;
    expect(textStyle.fontWeight, FontWeight.w800);
    expect(textStyle.fontSize, 0.3.dp);
    expect(textStyle.fontFamily, 'Jost_800');
  });
}
