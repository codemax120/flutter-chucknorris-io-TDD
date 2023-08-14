import 'package:chuck_norris_io/core/network/failure.dart';
import 'package:chuck_norris_io/core/usecases/usecase.dart';
import 'package:chuck_norris_io/features/random/domain/entities/random_entitie.dart';
import 'package:chuck_norris_io/features/random/domain/repositories/random_repository.dart';
import 'package:chuck_norris_io/features/random/domain/usecases/get_random.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRandomRepositorySuccess extends Mock implements RandomRepository {
  @override
  Future<Either<Failure, RandomEntity>> getRandom() async {
    const randomEntity = RandomEntity(
      id: '123',
      url: 'https://example.com',
      value: 'Chuck Norris jokes are funny',
      iconUrl: 'https://example.com/icon',
      createdAt: '2023-08-11',
      updatedAt: '2023-08-11',
      categories: [],
    );
    return const Right(randomEntity);
  }
}

class MockRandomRepositoryError extends Mock implements RandomRepository {
  @override
  Future<Either<Failure, RandomEntity>> getRandom() async {
    return Left(ServerFailure());
  }
}

void getRandomUseCaseTest() {
  group('GetRandomUseCase', () {
    late GetRandomUseCase useCaseSuccess;
    late GetRandomUseCase useCaseError;
    late MockRandomRepositorySuccess mockRandomRepositorySuccess;
    late MockRandomRepositoryError mockRandomRepositoryError;

    setUp(() {
      mockRandomRepositorySuccess = MockRandomRepositorySuccess();
      mockRandomRepositoryError = MockRandomRepositoryError();
      useCaseSuccess =
          GetRandomUseCase(repository: mockRandomRepositorySuccess);
      useCaseError = GetRandomUseCase(repository: mockRandomRepositoryError);
    });

    const randomEntity = RandomEntity(
      id: '123',
      url: 'https://example.com',
      value: 'Chuck Norris jokes are funny',
      iconUrl: 'https://example.com/icon',
      createdAt: '2023-08-11',
      updatedAt: '2023-08-11',
      categories: [],
    );

    test('should return RandomEntity from repository', () async {
      // Call the use case
      final result = await useCaseSuccess(NoParams());

      // Verify
      expect(result, equals(const Right(randomEntity)));
      verifyNoMoreInteractions(mockRandomRepositorySuccess);
    });

    test('should return Failure from repository', () async {
      // Call the use case
      final result = await useCaseError(NoParams());

      // Verify
      expect(result, equals(Left(ServerFailure())));
      verifyNoMoreInteractions(mockRandomRepositoryError);
    });
  });
}
