import 'package:chuck_norris_io/core/network/network_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNetworkInfoRepositoryConnected extends Mock
    implements NetworkInfoRepository {
  @override
  Future<bool> get hasConnection async => true;
}

class MockNetworkInfoRepositoryNoConnected extends Mock
    implements NetworkInfoRepository {
  @override
  Future<bool> get hasConnection async => false;
}

void networkInfoTest() {
  group('NetworkInfoRepository', () {
    test('hasConnection returns true when connected', () async {
      final networkInfoRepository = MockNetworkInfoRepositoryConnected();

      // Simulates that a connection is established
      final bool result = await networkInfoRepository.hasConnection;

      expect(result, true);
    });

    test('hasConnection returns false when not connected', () async {
      final networkInfoRepository = MockNetworkInfoRepositoryNoConnected();

      // Simulates that not a connection is established
      final bool result = await networkInfoRepository.hasConnection;

      expect(result, false);
    });
  });

  group('NetworkInfoRepositoryImpl', () {
    testWidgets('hasConnection returns true for no connectivity',
        (WidgetTester tester) async {
      late bool hasConnection;
      // Configure the integration test, create a MaterialApp
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final networkInfoRepository =
                  MockNetworkInfoRepositoryConnected();
              return ElevatedButton(
                onPressed: () async {
                  hasConnection = await networkInfoRepository.hasConnection;
                },
                child: const Text('Test Button'),
              );
            },
          ),
        ),
      );

      // Performs actions that generate the use of NetworkInfoRepositoryImp
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(hasConnection, true);
    });

    testWidgets('hasConnection returns false for no connectivity',
        (WidgetTester tester) async {
      late bool hasConnection;
      // Configure the integration test, create a MaterialApp
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final networkInfoRepository =
                  MockNetworkInfoRepositoryNoConnected();
              return ElevatedButton(
                onPressed: () async {
                  hasConnection = await networkInfoRepository.hasConnection;
                },
                child: const Text('Test Button'),
              );
            },
          ),
        ),
      );

      // Performs actions that generate the use of NetworkInfoRepositoryImp
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(hasConnection, false);
    });
  });
}
