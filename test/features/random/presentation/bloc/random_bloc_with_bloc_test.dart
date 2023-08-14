import 'package:bloc_test/bloc_test.dart';
import 'package:chuck_norris_io/features/random/domain/entities/random_entitie.dart';
import 'package:chuck_norris_io/core/usecases/usecase.dart';
import 'package:chuck_norris_io/core/network/failure.dart';
import 'package:chuck_norris_io/features/random/domain/usecases/get_random.dart';
import 'package:chuck_norris_io/features/random/presentation/bloc/random_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetRandomUseCase extends Mock implements GetRandomUseCase {
  @override
  Future<Either<Failure, RandomEntity>> call(NoParams params) async {
    return Right(RandomEntity.empty());
  }
}

class MockGetRandomUseCaseError extends Mock implements GetRandomUseCase {
  @override
  Future<Either<Failure, RandomEntity>> call(NoParams params) async {
    return Left(ServerFailure());
  }
}

void randomBlocTestWithPackage() {
  group('Random Bloc Test', () {
    late RandomBloc bloc;
    late MockGetRandomUseCase mockGetRandomUseCase;

    setUp(() {
      mockGetRandomUseCase = MockGetRandomUseCase();
      bloc = RandomBloc(getRandomUseCase: mockGetRandomUseCase);
    });

    blocTest<RandomBloc, RandomState>(
      'emits [LoadingState, SuccessGetRandomState] when GetRandomEvent is added and successful',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(const GetRandomEvent()),
      expect: () => [
        LoadingState(),
        SuccessGetRandomState(randomEntity: RandomEntity.empty()),
      ],
    );
  });

  group('Random Bloc Test', () {
    late RandomBloc bloc;
    late MockGetRandomUseCaseError mockGetRandomUseCase;

    setUp(() {
      mockGetRandomUseCase = MockGetRandomUseCaseError();
      bloc = RandomBloc(getRandomUseCase: mockGetRandomUseCase);
    });

    blocTest<RandomBloc, RandomState>(
      'emits [LoadingState, FailedGetRandomState] when GetRandomEvent is added and fails',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(const GetRandomEvent()),
      expect: () => [
        LoadingState(),
        FailedGetRandomState(),
      ],
    );
  });
}
