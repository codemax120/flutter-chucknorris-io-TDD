import 'package:chuck_norris_io/core/network/exception.dart';
import 'package:flutter_test/flutter_test.dart';

void serverExceptionTest() {
  group('Server Exception Test', () {
    test('Constructor sets the message correctly', () {
      const String message = 'Test error message';
      final exception = ServerException(message: message);

      expect(exception.message, message);
    });

    test('Default constructor creates an exception without a message', () {
      final exception = ServerException();

      expect(exception.message, isNull);
    });
  });
}
