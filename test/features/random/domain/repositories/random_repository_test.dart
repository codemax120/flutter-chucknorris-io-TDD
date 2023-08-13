import 'package:chuck_norris_io/core/network/failure.dart';
import 'package:chuck_norris_io/features/random/domain/entities/random_entitie.dart';
import 'package:chuck_norris_io/features/random/domain/repositories/random_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRandomRepositorySuccess extends Mock implements RandomRepository {
  @override
  Future<Either<Failure, RandomEntity>> getRandom() async {
    return const Right<Failure, RandomEntity>(
      RandomEntity(
        id: '123',
        url: 'https://example.com',
        value: 'Chuck Norris jokes are funny',
        iconUrl: 'https://example.com/icon',
        createdAt: '2023-08-11',
        updatedAt: '2023-08-11',
        categories: [],
      ),
    );
  }
}

class MockRandomRepositoryFailure extends Mock implements RandomRepository {
  @override
  Future<Either<Failure, RandomEntity>> getRandom() async {
    return Left(ServerFailure());
  }
}

void randomRepositoryTest() {
  group('random repository test', () {
    const randomEntity = RandomEntity(
      id: '123',
      url: 'https://example.com',
      value: 'Chuck Norris jokes are funny',
      iconUrl: 'https://example.com/icon',
      createdAt: '2023-08-11',
      updatedAt: '2023-08-11',
      categories: [],
    );

    test('should return RandomEntity when getRandom is called', () async {
      // Arrange
      final mockRepository = MockRandomRepositorySuccess();

      // Act
      final result = await mockRepository.getRandom();

      // Assert
      expect(result, equals(const Right(randomEntity)));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ServerFailure when getRandom fails', () async {
      // Arrange
      final mockRepository = MockRandomRepositoryFailure();
      final serverFailure = ServerFailure();

      // Act
      final result = await mockRepository.getRandom();

      // Assert
      expect(result, equals(Left(serverFailure)));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
