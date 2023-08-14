import 'package:chuck_norris_io/core/routes/page_generator.dart';
import 'package:chuck_norris_io/features/main/common_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void commonMainWidgetTest() {
  testWidgets('MyApp initializes correctly', (WidgetTester tester) async {
    await mockNetworkImages(
      () async => await tester.pumpWidget(
        const MyApp(),
      ),
    );

    final materialAppFinder = find.byType(MaterialApp);
    expect(materialAppFinder, findsOneWidget);

    final responsiveSizerFinder = find.byType(ResponsiveSizer);
    expect(responsiveSizerFinder, findsOneWidget);

    final initialRoute = find.byKey(const ValueKey('initialRoute'));
    expect(initialRoute, findsOneWidget);

    final materialAppWidget = tester.widget<MaterialApp>(materialAppFinder);
    final localizationsDelegates = materialAppWidget.localizationsDelegates;

    expect(materialAppWidget.title, 'ChuckNorris');
    expect(materialAppWidget.locale, equals(const Locale('es', 'ES')));
    expect(materialAppWidget.onGenerateRoute, equals(getNamedPage));
    expect(
      localizationsDelegates,
      contains(GlobalMaterialLocalizations.delegate),
    );
    expect(
      localizationsDelegates,
      contains(GlobalWidgetsLocalizations.delegate),
    );
    expect(
      localizationsDelegates,
      contains(GlobalCupertinoLocalizations.delegate),
    );
  });
}
