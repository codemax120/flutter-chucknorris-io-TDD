import 'package:chuck_norris_io/core/network/failure.dart';
import 'package:flutter_test/flutter_test.dart';

void failureTest() {
  group('ServerFailure', () {
    test('Constructor sets the error correctly', () {
      const String error = 'Test error';
      final failure = ServerFailure(error: error);

      expect(failure.error, error);
    });

    test('Equatable props include the error', () {
      const String error = 'Test error';
      final failure = ServerFailure(error: error);

      expect(failure.props, [error]);
    });
  });
}
