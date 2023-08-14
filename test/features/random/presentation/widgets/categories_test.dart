import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:chuck_norris_io/features/random/presentation/widgets/categories.dart';

void categoriesWidgetTest() {
  testWidgets('Categories displays correct title and categories',
      (WidgetTester tester) async {
    final categories = [
      'Category 1',
      'Category 2',
      'Category 3',
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Categories(title: 'Test Title', list: categories),
          ),
        ),
      ),
    );

    final titleFinder = find.text('Test Title');
    expect(titleFinder, findsOneWidget);

    final titleWidget = tester.widget<Text>(titleFinder);
    final titleStyle = titleWidget.style!;
    expect(titleStyle.fontWeight, FontWeight.w800);
    expect(titleStyle.fontSize, 0.3.dp);

    final listViewFinder = find.byType(SingleChildScrollView);
    expect(listViewFinder, findsOneWidget);

    final listViewWidget = tester.widget<SingleChildScrollView>(listViewFinder);
    expect(listViewWidget.scrollDirection, Axis.horizontal);

    for (final category in categories) {
      expect(find.text(category), findsOneWidget);
    }

    final dividerFinder = find.byType(Divider);
    expect(dividerFinder, findsOneWidget);

    final dividerWidget = tester.widget<Divider>(dividerFinder);
    expect(dividerWidget.color, Colors.black45);
    expect(dividerWidget.height, 5.h);
  });
}
