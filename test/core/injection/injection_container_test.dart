import 'package:chuck_norris_io/core/network/network_info.dart';
import 'package:chuck_norris_io/core/network/server_api_client.dart';
import 'package:chuck_norris_io/features/random/data/datasources/random_datasource.dart';
import 'package:chuck_norris_io/features/random/domain/repositories/random_repository.dart';
import 'package:chuck_norris_io/features/random/domain/usecases/get_random.dart';
import 'package:chuck_norris_io/features/random/presentation/bloc/random_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockNetworkInfoRepository extends Mock implements NetworkInfoRepository {
  @override
  Future<bool> get hasConnection async => true;
}

class MockServerApiClient extends Mock implements ServerApiClient {
  @override
  NetworkInfoRepository get networkInfoRepository =>
      super.noSuchMethod(Invocation.getter(#networkInfoRepository),
          returnValue: NetworkInfoRepositoryImpl());
}

void injectionContainerTest() {
  group('Dependency Initialization Tests', () {
    late GetIt getIt;

    setUp(() {
      getIt = GetIt.instance;
      // Registra las dependencias simuladas (mock)
      getIt.registerLazySingleton<NetworkInfoRepository>(
          () => MockNetworkInfoRepository());
      getIt.registerLazySingleton<ServerApiClient>(() => MockServerApiClient());
      getIt.reset();
    });

    test('Core Dependencies are registered correctly', () {
      expect(getIt<NetworkInfoRepository>(), isA<NetworkInfoRepository>());
      expect(getIt<ServerApiClient>(), isA<ServerApiClient>());
    });

    test('initFeaturesDependecies initializes additional dependencies',
        () async {
      final mockNetworkInfoRepository = getIt<NetworkInfoRepository>();
      final mockServerApiClient = getIt<ServerApiClient>();

      // Asegúrate de que se hayan registrado las dependencias en el nuevo alcance
      expect(mockNetworkInfoRepository.hasConnection, completes);
      expect(getIt<RandomBloc>(), isA<RandomBloc>());
      expect(getIt<GetRandomUseCase>(), isA<GetRandomUseCase>());
      expect(getIt<RandomClient>(), isA<RandomClient>());
      expect(getIt<RandomRepository>(), isA<RandomRepository>());
      // Verifica que initRandom se haya llamado una vez
      verifyNever(mockServerApiClient.networkInfoRepository);
    });
  });
}
