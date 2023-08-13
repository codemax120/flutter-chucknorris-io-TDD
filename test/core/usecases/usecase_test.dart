import 'package:chuck_norris_io/core/network/failure.dart';
import 'package:chuck_norris_io/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

class TestUseCase extends UseCase<int, NoParams> {
  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    // Simulate a successful result
    return const Right(42);
  }
}

void usecaseTest() {
  group('UseCase', () {
    test('should return a value when invoked', () async {
      // Arrange
      final useCase = TestUseCase();
      final params = NoParams();

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isA<Right<Failure, int>>());
      expect(result.getOrElse(() => throw 'Unexpected error'), 42);
    });
  });
}
