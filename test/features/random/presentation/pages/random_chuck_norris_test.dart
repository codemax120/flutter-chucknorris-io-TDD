import 'package:chuck_norris_io/features/random/domain/entities/random_entitie.dart';
import 'package:chuck_norris_io/features/random/presentation/bloc/random_bloc.dart';
import 'package:chuck_norris_io/features/random/presentation/pages/random_chuck_norris.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart' as mocktail;

class MockRandomBloc extends mocktail.Mock implements RandomBloc {}

void randomChuckNorrisScreenWidgetTest() {
  group('RandomChuckNorrisScreen', () {
    late RandomBloc mockRandomBloc;
    late RandomEntity randomEntity;

    setUp(() async {
      mockRandomBloc = MockRandomBloc();
      randomEntity = const RandomEntity(
        id: '123',
        url: 'https://example.com',
        value: 'Chuck Norris jokes are funny',
        iconUrl: 'https://example.com/icon',
        createdAt: '2023-08-11',
        updatedAt: '2023-08-11',
        categories: ['category1', 'category2'],
      );
    });

    testWidgets('should render RandomChuckNorrisScreen correctly',
        (WidgetTester tester) async {
      mocktail.when(() => mockRandomBloc.state).thenReturn(LoadingState());

      mocktail
          .when(() => mockRandomBloc.state)
          .thenReturn(SuccessGetRandomState(randomEntity: randomEntity));

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<RandomBloc>.value(
            value: mockRandomBloc,
            child: const RandomChuckNorrisScreen(),
          ),
        ),
      );

      // Assert
      expect(find.byType(RandomChuckNorrisScreen), findsOneWidget);
    });
  });
}
