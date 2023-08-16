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

void randomBlocTest() {
  group('Random Bloc Test', () {
    test(
        'emits [LoadingState, SuccessGetRandomState] when GetRandomEvent is added and successful without blocTest',
        () async {
      MockGetRandomUseCase mockGetRandomUseCase = MockGetRandomUseCase();

      // Crear una instancia del Bloc con la implementación falsa
      final bloc = RandomBloc(getRandomUseCase: mockGetRandomUseCase);

      final states = <RandomState>[
        LoadingState(),
        SuccessGetRandomState(randomEntity: RandomEntity.empty())
      ];

      bloc.stream.listen((state) {
        states.add(state);
      });

      // Agrega tu lógica de prueba aquí
      bloc.add(const GetRandomEvent());

      // Verifica los resultados según lo esperado
      expect(states, [
        isA<LoadingState>(),
        isA<SuccessGetRandomState>(),
      ]);
    });

    test(
        'emits [LoadingState, FailedGetRandomState] when GetRandomEvent is added and fails without blocTest',
        () async {
      MockGetRandomUseCaseError mockGetRandomUseCase =
          MockGetRandomUseCaseError();

      // Crear una instancia del Bloc con la implementación falsa
      final bloc = RandomBloc(getRandomUseCase: mockGetRandomUseCase);

      final states = <RandomState>[
        LoadingState(),
        FailedGetRandomState(),
      ];

      bloc.stream.listen((state) {
        states.add(state);
      });

      // Agrega tu lógica de prueba aquí
      bloc.add(const GetRandomEvent());

      // Verifica los resultados según lo esperado
      expect(states, [
        isA<LoadingState>(),
        isA<FailedGetRandomState>(),
      ]);
    });
  });
}
