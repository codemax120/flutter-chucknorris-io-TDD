import 'package:chuck_norris_io/features/random/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void customButtonWidgetTest() {
  testWidgets('CustomButton displays correct title',
      (WidgetTester tester) async {
    const buttonTitle = 'Test Button';

    await tester.pumpWidget(
      MaterialApp(
        home: ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return Scaffold(
              body: Center(
                child: CustomButton(
                  title: buttonTitle,
                  callback: () {},
                ),
              ),
            );
          },
        ),
      ),
    );

    final buttonFinder = find.text(buttonTitle);
    expect(buttonFinder, findsOneWidget);
  });

  testWidgets('CustomButton calls callback when pressed',
      (WidgetTester tester) async {
    bool callbackCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: CustomButton(
              title: 'Test Button',
              callback: () {
                callbackCalled = true;
              },
            ),
          ),
        ),
      ),
    );

    final buttonFinder = find.byType(CustomButton);
    await tester.tap(buttonFinder);
    await tester.pump();

    expect(callbackCalled, isTrue);
  });
}
